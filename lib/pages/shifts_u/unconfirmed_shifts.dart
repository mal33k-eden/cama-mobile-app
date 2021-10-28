import 'package:cama/models/shift.dart';
import 'package:cama/providers/provider_auth.dart';
import 'package:cama/providers/provider_shift.dart';
import 'package:cama/shared/flavors.dart';
import 'package:cama/shared/form_kits.dart';
import 'package:cama/widgets/price.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:path/path.dart';
import 'package:provider/provider.dart';

class UnconfimredShifts extends StatefulWidget {
  const UnconfimredShifts({Key? key}) : super(key: key);

  @override
  State<UnconfimredShifts> createState() => _UnconfimredShiftsState();
}

class _UnconfimredShiftsState extends State<UnconfimredShifts> {
  late final ShiftProvider _shiftProvider;
  late final AuthProvider _authProvider;
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  List<MyShift>? _shifts = [];
  @override
  void initState() {
    _shifts = [];
    // TODO: implement initState
    WidgetsBinding.instance?.addPostFrameCallback((timeStamp) {
      _shiftProvider = Provider.of<ShiftProvider>(this.context, listen: false);
      _authProvider = Provider.of<AuthProvider>(this.context, listen: false);

      _getShiftData();
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        // actions: [Icon(Icons.tune_sharp)],
        title: Text('Unconfirmed Shifts'),
      ),
      body: (_shifts!.length > 0)
          ? Container(
              padding: EdgeInsets.all(20),
              child: SingleChildScrollView(
                  child: ListView.builder(
                      physics: ScrollPhysics(),
                      shrinkWrap: true,
                      itemCount: _shifts?.length,
                      itemBuilder: (BuildContext context, int index) {
                        return ListView(
                          shrinkWrap: true,
                          primary: false,
                          children: [
                            Container(
                              padding: EdgeInsets.all(15),
                              decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(25),
                                  boxShadow: [
                                    BoxShadow(
                                        offset: Offset(2.0, 2.0),
                                        blurRadius: 25,
                                        color: Colors.grey.shade200,
                                        spreadRadius: 1),
                                    BoxShadow(
                                        offset: Offset(-2.0, -2.0),
                                        blurRadius: 25,
                                        color: Colors.white10,
                                        spreadRadius: 1),
                                  ]),
                              child: Row(
                                children: [
                                  PriceView(
                                      rates: _shifts!.elementAt(index).rates),
                                  SizedBox(
                                    width: 10,
                                  ),
                                  Container(
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceEvenly,
                                      children: [
                                        Row(
                                          children: [
                                            Icon(Icons.home_sharp),
                                            Text(
                                              '${_shifts!.elementAt(index).home}',
                                              style: TextStyle(
                                                  fontSize: 15,
                                                  fontWeight: FontWeight.bold),
                                            ),
                                          ],
                                        ),
                                        Row(
                                          children: [
                                            Icon(Icons.place_sharp),
                                            Text(
                                                '${_shifts!.elementAt(index).postcode}, ${_shifts!.elementAt(index).address}'),
                                          ],
                                        ),
                                        Row(
                                          children: [
                                            Icon(Icons.calendar_today),
                                            //Text('Thu 2nd, Sep 2021'),
                                            Text(DateFormat.yMMMEd().format(
                                                DateTime.parse(_shifts!
                                                    .elementAt(index)
                                                    .date)))
                                          ],
                                        ),
                                        Row(
                                          children: [
                                            Icon(Icons.timer_sharp),
                                            Text(
                                              '${_shifts!.elementAt(index).start} - ${_shifts!.elementAt(index).end}',
                                            ),
                                          ],
                                        ),
                                        Row(
                                          children: [
                                            Icon(Icons.taxi_alert_sharp),
                                            Text(
                                              '${_shifts!.elementAt(index).pickup}',
                                            ),
                                          ],
                                        ),
                                        Row(
                                          children: [
                                            Icon(Icons.business_sharp),
                                            Text(
                                              '${_shifts!.elementAt(index).agency}',
                                              style: TextStyle(fontSize: 13),
                                            ),
                                          ],
                                        ),
                                        Row(
                                          children: [
                                            TextButton.icon(
                                                onPressed: () {
                                                  _confirmAction(
                                                      context,
                                                      'Confirm',
                                                      _scaffoldKey,
                                                      _shifts!
                                                          .elementAt(index)
                                                          .key);
                                                },
                                                icon: Icon(
                                                    Icons.check_circle_sharp,
                                                    color:
                                                        Flavor.secondaryToDark),
                                                label: Text(
                                                  'Confirm',
                                                  style: TextStyle(
                                                      color: Flavor
                                                          .secondaryToDark),
                                                )),
                                            TextButton.icon(
                                                onPressed: () {
                                                  _confirmAction(
                                                      context,
                                                      'Decline',
                                                      _scaffoldKey,
                                                      _shifts!
                                                          .elementAt(index)
                                                          .key);
                                                },
                                                icon: Icon(
                                                  Icons.cancel_sharp,
                                                  color: Colors.red,
                                                ),
                                                label: Text('Unavailable',
                                                    style: TextStyle(
                                                        color: Colors.red))),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(height: 30)
                          ],
                        );
                      })),
            )
          : SizedBox(),
    );
  }

  void _getShiftData() async {
    await _shiftProvider.getUnconfirmed(_authProvider.token!);
    if (_shiftProvider.isShiftLoaded) {
      if (mounted) {
        setState(() {
          _shifts = _shiftProvider.myShifts();
        });
      }
    }
  }

  void _confirmAction(context, action, scaffoldKey, shiftKey) {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text(action + ' Shift'),
            content:
                Text('Click the ${action} button to ${action} this shift.'),
            actions: [
              TextButton(onPressed: () {}, child: Text('Cancel')),
              TextButton(
                  onPressed: () {
                    _submitForm(context, scaffoldKey, shiftKey, action);
                  },
                  child: Text(
                    action,
                    style: TextStyle(
                        color: (action == 'Decline') ? Colors.red : null),
                  )),
            ],
          );
        });
  }

  void _submitForm(context, scaffoldKey, shift_key, action) async {
    //open watch
    var tk = _authProvider.token;
    Map<String, dynamic> body = {};
    body['visible_key'] = shift_key;
    if (action == 'Confirm') {
      await _shiftProvider.confirmShift(body: body, token: tk!);
    } else {
      await _shiftProvider.declineShift(body: body, token: tk!);
    }
    if (_shiftProvider.isShiftLoaded) {
      //close watch
      _getShiftData();
      Navigator.pop(context);
      showSnackBar(
          context: scaffoldKey.currentContext,
          message: 'Your shifts have been updated');
    } else {
      //close watch
      Navigator.pop(context);
      await showCustomAlert(
          scaffoldState: scaffoldKey,
          title: 'Error',
          message: 'something went wrong try again');
    }
  }
}
