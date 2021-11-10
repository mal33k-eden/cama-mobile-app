import 'package:cama/models/agency.dart';
import 'package:cama/providers/provider_agency.dart';
import 'package:cama/providers/provider_auth.dart';
import 'package:cama/shared/flavors.dart';
import 'package:cama/shared/form_kits.dart';
import 'package:flutter/material.dart';
import 'package:flutter_overlay_loader/flutter_overlay_loader.dart';
import 'package:provider/provider.dart';

class AgencyProfile extends StatefulWidget {
  const AgencyProfile({Key? key}) : super(key: key);

  @override
  State<AgencyProfile> createState() => _AgencyProfileState();
}

class _AgencyProfileState extends State<AgencyProfile> {
  final _scaffoldKey = GlobalKey<FormState>();
  bool _permitBCM = false;
  String requiredDocs = '';
  String requiredTrainings = '';
  bool isDocComplete = false;
  bool isTrainingComplete = false;
  var args;
  MyAgency? agency;

  @override
  void initState() {
    // TODO: implement initState
    Future.delayed(Duration.zero, () {
      args = ModalRoute.of(context)!.settings.arguments;

      setState(() {
        agency = args!['agency'];
        _permitBCM = (agency!.profile_update_permission == 1) ? true : false;
        _calculateActions();
      });
    });
    super.initState();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    Loader.hide();
  }

  @override
  Widget build(BuildContext context) {
    final _auth = Provider.of<AuthProvider>(context);
    final _agency = Provider.of<AgencyProvider>(context);
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        actions: [],
        title: Text('Agency Profile'),
      ),
      body: Container(
          child: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: Container(
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(25),
                    color: Flavor.primaryToDark,
                    boxShadow: [
                      BoxShadow(
                          offset: Offset(4.0, 4.0),
                          blurRadius: 25,
                          color: Colors.grey.shade300,
                          spreadRadius: 8),
                      BoxShadow(
                          offset: Offset(-4.0, -4.0),
                          blurRadius: 25,
                          color: Colors.white10,
                          spreadRadius: 8),
                    ]),
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Column(
                    children: [
                      Text(
                        'Agency Information',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: Colors.white),
                      ),
                      Divider(),
                      Row(
                        children: [
                          Icon(
                            Icons.business_sharp,
                            color: Colors.white,
                          ),
                          Text(
                            '  ${agency?.name}',
                            style: TextStyle(color: Colors.white, fontSize: 18),
                          ),
                        ],
                      ),
                      SizedBox(height: 10),
                      Row(
                        children: [
                          Icon(
                            Icons.phone_android_sharp,
                            color: Colors.white,
                          ),
                          Text('  ${agency?.mobile} /   ${agency?.telephone}',
                              style:
                                  TextStyle(color: Colors.white, fontSize: 15)),
                        ],
                      ),
                      SizedBox(height: 10),
                      Row(
                        children: [
                          Icon(
                            Icons.mail_sharp,
                            color: Colors.white,
                          ),
                          Text('  ${agency?.email}',
                              style:
                                  TextStyle(color: Colors.white, fontSize: 15)),
                        ],
                      ),
                      SizedBox(height: 10),
                      Row(
                        children: [
                          Icon(
                            Icons.place_sharp,
                            color: Colors.white,
                          ),
                          Text('  ${agency?.postcode}',
                              style:
                                  TextStyle(color: Colors.white, fontSize: 15)),
                        ],
                      ),
                      SizedBox(height: 10),
                      Row(
                        children: [
                          Icon(
                            Icons.map_sharp,
                            color: Colors.white,
                          ),
                          Text('  ${agency?.address}',
                              style:
                                  TextStyle(color: Colors.white, fontSize: 15)),
                        ],
                      ),
                      SizedBox(height: 10),
                      Row(
                        children: [
                          Icon(
                            Icons.place_sharp,
                            color: Colors.white,
                          ),
                          Text('  ${agency?.town}',
                              style:
                                  TextStyle(color: Colors.white, fontSize: 15)),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: Container(
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(25),
                    color: Colors.white,
                    boxShadow: [
                      BoxShadow(
                          offset: Offset(4.0, 4.0),
                          blurRadius: 25,
                          color: Colors.grey.shade300,
                          spreadRadius: 8),
                      BoxShadow(
                          offset: Offset(-4.0, -4.0),
                          blurRadius: 25,
                          color: Colors.white10,
                          spreadRadius: 8),
                    ]),
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Column(
                    children: [
                      Text(
                        'Actions',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: Flavor.primaryToDark),
                      ),
                      Divider(),
                      ListTile(
                        leading: CircleAvatar(
                          backgroundColor: Flavor.primaryToDark,
                          radius: 30,
                          child: Icon(
                            Icons.group_sharp,
                            color: Colors.white,
                            size: 30,
                          ),
                        ),
                        title: Text(
                          'Required Documents',
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                        subtitle: Text(requiredDocs),
                        trailing: CircleAvatar(
                          backgroundColor: Flavor.primaryToDark,
                          radius: 20,
                          child: (isDocComplete)
                              ? Icon(
                                  Icons.check_circle_sharp,
                                  color: Flavor.secondaryToDark,
                                )
                              : Icon(
                                  Icons.cancel_sharp,
                                  color: Colors.red,
                                ),
                        ),
                        onTap: () {
                          Navigator.pushNamed(context, 'agency-documents',
                              arguments: {'docs': agency!.required_docs});
                        },
                      ),
                      Divider(),
                      ListTile(
                        leading: CircleAvatar(
                          backgroundColor: Flavor.primaryToDark,
                          radius: 30,
                          child: Icon(
                            Icons.group_sharp,
                            color: Colors.white,
                            size: 30,
                          ),
                        ),
                        title: Text(
                          'Required Trainings',
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                        subtitle: Text(requiredTrainings),
                        trailing: CircleAvatar(
                          backgroundColor: Flavor.primaryToDark,
                          radius: 20,
                          child: (isTrainingComplete)
                              ? Icon(
                                  Icons.check_circle_sharp,
                                  color: Flavor.secondaryToDark,
                                )
                              : Icon(
                                  Icons.cancel_sharp,
                                  color: Colors.red,
                                ),
                        ),
                        onTap: () {
                          Navigator.pushNamed(context, 'agency-trainings',
                              arguments: {
                                'trainings': agency!.required_trainings
                              });
                        },
                      ),
                      Divider(),
                      ListTile(
                        leading: CircleAvatar(
                          backgroundColor: Flavor.primaryToDark,
                          radius: 30,
                          child: Icon(
                            Icons.group_sharp,
                            color: Colors.white,
                            size: 30,
                          ),
                        ),
                        title: Text(
                          'Policies',
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                        subtitle: Text(agency?.policy_status ?? '---'),
                        trailing: CircleAvatar(
                          backgroundColor: Flavor.primaryToDark,
                          radius: 20,
                          child: (agency?.policy_status == 'agreed')
                              ? Icon(
                                  Icons.check_circle_sharp,
                                  color: Flavor.secondaryToDark,
                                )
                              : Icon(
                                  Icons.cancel_sharp,
                                  color: Colors.red,
                                ),
                        ),
                        onTap: () {
                          _showPermisionDialog('policy', agency!.profile_code,
                              _auth, _agency, _scaffoldKey);
                        },
                      ),
                      Divider(),
                    ],
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: Container(
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(25),
                    color: Colors.white,
                    boxShadow: [
                      BoxShadow(
                          offset: Offset(4.0, 4.0),
                          blurRadius: 25,
                          color: Colors.grey.shade300,
                          spreadRadius: 8),
                      BoxShadow(
                          offset: Offset(-4.0, -4.0),
                          blurRadius: 25,
                          color: Colors.white10,
                          spreadRadius: 8),
                    ]),
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Column(
                    children: [
                      Text(
                        'Permissions',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: Flavor.primaryToDark),
                      ),
                      Divider(),
                      Row(
                        children: [
                          Checkbox(
                            value: _permitBCM,
                            checkColor: Flavor.primaryToDark,
                            activeColor: Flavor.secondaryToDark,
                            onChanged: (value) {
                              setState(() {
                                _permitBCM = value!;
                                _showPermisionDialog(
                                    'bcm',
                                    agency!.profile_code,
                                    _auth,
                                    _agency,
                                    _scaffoldKey);
                              });
                            },
                          ), //SizedBox
                          Text(
                            'Basic Compliance Management',
                            style: TextStyle(fontSize: 15.0),
                          ),
                          //Checkbox
                        ], //<Widget>[]
                      ),
                    ],
                  ),
                ),
              ),
            )
          ],
        ),
      )),
    );
  }

  void _calculateActions() {
    int _totalDocSubmitted = 0;
    int _totalTrainingSubmitted = 0;
    int? _totalDocReq = agency!.required_docs.length;
    int? _totalTrainReq = agency!.required_trainings.length;
    for (var item in agency!.required_docs) {
      (item['is_submitted']) ? _totalDocSubmitted += 1 : null;
    }
    for (var item in agency!.required_trainings) {
      (item['is_submitted']) ? _totalTrainingSubmitted += 1 : null;
    }
    requiredDocs = '${_totalDocSubmitted} / ${_totalDocReq}';
    requiredTrainings = '${_totalTrainingSubmitted} / ${_totalTrainReq}';
    (_totalTrainReq == _totalTrainingSubmitted)
        ? isTrainingComplete = true
        : null;
    (_totalDocReq == _totalDocSubmitted) ? isDocComplete = true : null;
  }

  void _showPermisionDialog(String action, String profile_code,
      AuthProvider auth, AgencyProvider agency, scafoldstate) {
    var actionTxt;
    print(action);
    if (action == 'policy') {
      actionTxt = 'Agree To Policy(s)';
    } else if (action == 'bcm') {
      actionTxt = 'Give Permision';
    }
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(actionTxt),
        scrollable: true,
        content: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
                'By clicking contine, you will be agreeing to the terms and policies of this agency.'),
          ],
        ),
        actions: [
          TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: Text(
                'Cancel',
                style: TextStyle(color: Colors.red),
              )),
          TextButton(
              onPressed: () {
                Navigator.pop(context);
                _submitAction(
                    context, action, profile_code, auth, agency, scafoldstate);
              },
              child: Text('Continue'))
        ],
      ),
    );
  }

  void _submitAction(BuildContext context, String action, String profile_code,
      AuthProvider auth, AgencyProvider agency, scafoldstate) async {
    showCustomActivityAlert(context: context);
    Map<String, dynamic> body = {};
    body['profile_code'] = profile_code;
    body['action'] = action;
    await agency.profileActions(body: body, token: auth.token!);
    if (agency.isSetMyAgencies) {
      showSnackBar(
          context: scafoldstate.currentContext, message: 'Profile Updated');
      // Navigator.of(scafoldstate.currentContext)
      //     .pushReplacementNamed('agencies');
      Loader.hide();
      Navigator.pop(scafoldstate.currentContext);
    } else {
      Loader.hide();
      await showCustomAlert(
          scaffoldState: scafoldstate,
          title: 'Error',
          message: 'something went wrong try again');
    }
  }
}
