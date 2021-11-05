import 'package:cama/models/shift.dart';
import 'package:cama/providers/provider_auth.dart';
import 'package:cama/providers/provider_shift.dart';
import 'package:cama/shared/avart_icon.dart';
import 'package:cama/shared/flavors.dart';
import 'package:cama/shared/form_kits.dart';
import 'package:cama/widgets/loader.dart';
import 'package:cama/widgets/price.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class ShiftPool extends StatefulWidget {
  const ShiftPool({Key? key}) : super(key: key);

  @override
  State<ShiftPool> createState() => _ShiftPoolState();
}

class _ShiftPoolState extends State<ShiftPool> {
  late final ShiftProvider _shiftProvider;
  late final AuthProvider _authProvider;
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  int poolCurPage = 0;
  int poolLastPage = 0;
  List<MyShift>? _shifts = [];
  bool _isLoading = false;
  bool loading = false;
  bool _hasMore = true;
  ScrollController _scrollController = ScrollController();
  @override
  void initState() {
    // _shifts = [];
    // TODO: implement initState
    WidgetsBinding.instance?.addPostFrameCallback((timeStamp) {
      _shiftProvider = Provider.of<ShiftProvider>(this.context, listen: false);
      _authProvider = Provider.of<AuthProvider>(this.context, listen: false);

      _getShiftPoolData();
      _isLoading = false;
      _hasMore = true;
    });
    _scrollController.addListener(() {
      if (_scrollController.position.pixels ==
          _scrollController.position.maxScrollExtent) {
        _getShiftPoolData();
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Locale locale = Localizations.localeOf(context);
    var format =
        NumberFormat.simpleCurrency(locale: locale.toString(), name: 'GBP');
    var cur = format.currencySymbol;

    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        title: Text('Shift Pool'),
      ), //(_shifts!.length > 0)
      body: (_shifts!.length > 0)
          ? Container(
              padding: EdgeInsets.all(20),
              child: SingleChildScrollView(
                controller: _scrollController,
                primary: false,
                child: ListView.builder(
                    physics: ScrollPhysics(),
                    shrinkWrap: true,
                    itemCount:
                        (_hasMore) ? _shifts!.length + 1 : _shifts!.length,
                    itemBuilder: (BuildContext context, int index) {
                      if (index == _shifts!.length && _hasMore) {
                        return Center(
                          child: SizedBox(
                            child: CupertinoActivityIndicator(),
                            height: 24,
                            width: 24,
                          ),
                        );
                      }
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
                                                'Pick Shift',
                                                style: TextStyle(
                                                    color:
                                                        Flavor.secondaryToDark),
                                              ))
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
                    }),
              ),
            )
          : Container(
              alignment: AlignmentDirectional.center,
              child: CustomActivityIndicator(size: 20),
            ),
    );
  }

  void _getShiftPoolData() async {
    if (!_isLoading && _hasMore) {
      _isLoading = true;
      await _shiftProvider.getPool(_authProvider.token!, poolCurPage + 1);
      if (_shiftProvider.isShiftLoaded) {
        if (mounted) {
          setState(() {
            _shifts = _shiftProvider.myShifts();
            poolCurPage = _shiftProvider.poolCurPage;
            poolLastPage = _shiftProvider.poolPageLen;
            if (poolCurPage == poolLastPage) {
              _isLoading = false;
              _hasMore = false;
            } else {
              _isLoading = false;
            }
          });
        }
      }
    }
  }

  void _refreshShiftPoolData() async {
    _isLoading = true;
    await _shiftProvider.getPool(_authProvider.token!, poolCurPage);
    if (_shiftProvider.isShiftLoaded) {
      if (mounted) {
        setState(() {
          _shifts = _shiftProvider.myShifts();
          poolCurPage = _shiftProvider.poolCurPage;
          poolLastPage = _shiftProvider.poolPageLen;
          if (poolCurPage == poolLastPage) {
            _isLoading = false;
            _hasMore = false;
          } else {
            _isLoading = false;
          }
        });
      }
    }
  }

  void _confirmAction(context, scaffoldKey, shiftKey) {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('Pick Shift'),
            content: Text('Click the continue button to pick this shift.'),
            actions: [
              TextButton(onPressed: () {}, child: Text('Cancel')),
              TextButton(
                  onPressed: () {
                    //Navigator.pop(context);
                    _submitForm(context, scaffoldKey, shiftKey);
                  },
                  child: Text(
                    'Continue',
                  )),
            ],
          );
        });
  }

  void _submitForm(context, scaffoldKey, shift_key) async {
    //open watch

    var tk = _authProvider.token;
    Map<String, dynamic> body = {};
    body['visible_key'] = shift_key;
    await _shiftProvider.pickPoolShift(body: body, token: tk!);
    if (_shiftProvider.isShiftLoaded) {
      //close watch
      _refreshShiftPoolData();
      Navigator.pop(context);
      showSnackBar(
          context: scaffoldKey.currentContext,
          message:
              'Your request has been placed. A notification will be sent once your request is successful');
    } else {
      //close watch
      Navigator.pop(context);
      await showCustomAlert(
          scaffoldState: scaffoldKey,
          title: 'Error',
          message: 'something went wrong try again');
    }
  }

  void showLoading(context, scaffoldKey, shiftKey) {
    _submitForm(context, scaffoldKey, shiftKey);
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return Container(
            alignment: AlignmentDirectional.center,
            child: CustomActivityIndicator(size: 20),
          );
        });
  }
}
