import 'package:cached_network_image/cached_network_image.dart';
import 'package:cama/models/my_dashboard.dart';
import 'package:cama/models/user.dart';
import 'package:cama/pages/dashboard/agencies_card.dart';
import 'package:cama/pages/dashboard/files_card.dart';
import 'package:cama/pages/dashboard/shift_calendar_card.dart';
import 'package:cama/pages/dashboard/shift_pool_card.dart';
import 'package:cama/pages/dashboard/unconfirmed_shift_card.dart';
import 'package:cama/pages/dashboard/upload_timesheet_card.dart';
import 'package:cama/providers/provider_auth.dart';
import 'package:cama/providers/provider_dashboard.dart';
import 'package:cama/shared/flavors.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class DashBoard extends StatefulWidget {
  const DashBoard({Key? key}) : super(key: key);

  @override
  State<DashBoard> createState() => _DashBoardState();
}

class _DashBoardState extends State<DashBoard> {
  late final User user;
  late final AuthProvider _auth;
  late final DashBoardProvider _DProvider;
  MyDashBoard? dashBoard;
  bool isSet = false;
  bool hasToday = false;
  Map<String, dynamic> shift = {};
  @override
  void initState() {
    // TODO: implement initState
    WidgetsBinding.instance?.addPostFrameCallback((timeStamp) {
      _auth = Provider.of<AuthProvider>(this.context, listen: false);
      _DProvider = Provider.of<DashBoardProvider>(this.context, listen: false);
      print(_auth.token);
      _getProfile(_auth.token);
      _getDashBoard(_DProvider, _auth.token);
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('C.A.M.A'),
        actions: [
          Container(
            margin: EdgeInsets.all(10),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(25),
              boxShadow: [
                BoxShadow(
                    offset: Offset(4.0, 4.0),
                    blurRadius: 15,
                    color: Flavor.primaryToDark.shade50,
                    spreadRadius: 5),
                BoxShadow(
                    offset: Offset(-4.0, -4.0),
                    blurRadius: 15,
                    color: Colors.white10,
                    spreadRadius: 5),
              ],
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(2030),
              child: InkWell(
                onTap: () {
                  Navigator.pushNamed(context, 'profile-summary');
                },
                child: (dashBoard != null)
                    ? CircleAvatar(
                        backgroundImage:
                            CachedNetworkImageProvider(dashBoard!.photo),
                        radius: 25,
                      )
                    : CircleAvatar(
                        backgroundImage: AssetImage(
                          'assets/images/avatar.png',
                        ),
                        radius: 25,
                      ),
              ),
            ),
          ),
        ],
      ),
      body: Container(
        padding: EdgeInsets.all(20),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Hello,',
                style: TextStyle(
                  fontWeight: FontWeight.normal,
                  fontSize: 30,
                ),
              ),
              Text(
                (dashBoard != null) ? dashBoard!.full_name : '',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
                ),
              ),
              SizedBox(
                height: 10,
              ),
              (hasToday)
                  ? Container(
                      padding: EdgeInsets.all(30),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(25),
                        color: Flavor.primaryToDark,
                      ),
                      child: Row(
                        children: [
                          Container(
                            decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(10)),
                            padding: EdgeInsets.all(10),
                            child: Column(
                              children: [
                                Text(shift['date1']),
                                Divider(),
                                Text(shift['date2'])
                              ],
                            ),
                          ),
                          SizedBox(
                            width: 20,
                          ),
                          Container(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Today\'s Shift',
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold),
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                                Text(
                                  shift['period'],
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 15,
                                      fontWeight: FontWeight.bold),
                                ),
                                SizedBox(
                                  height: 5,
                                ),
                                Text(shift['home'],
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 20,
                                        fontWeight: FontWeight.bold)),
                                Text(
                                  shift['agency'],
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 13,
                                      fontWeight: FontWeight.bold),
                                )
                              ],
                            ),
                          )
                        ],
                      ),
                    )
                  : SizedBox(),
              SizedBox(
                height: 20,
              ),
              GridView.count(
                  physics: NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  primary: false,
                  padding: const EdgeInsets.all(10),
                  crossAxisSpacing: 10,
                  mainAxisSpacing: 10,
                  crossAxisCount: 2,
                  children: [
                    ShiftCalendarCard(
                        value: (dashBoard != null) ? dashBoard!.calendar : 0),
                    ShiftPoolCard(
                      value: (dashBoard != null) ? dashBoard!.pool : 0,
                    ),
                    UnconfirmedShiftCard(
                        value:
                            (dashBoard != null) ? dashBoard!.unconfirmed : 0),
                    UploadTimeSheetCard(
                      value: (dashBoard != null) ? dashBoard!.timesheet : 0,
                    ),
                    AllFilesCard(
                      value: (dashBoard != null) ? dashBoard!.files : 0,
                    ),
                    AgenciesCard(
                      value: (dashBoard != null) ? dashBoard!.agencies : 0,
                    )
                  ]),
            ],
          ),
        ),
      ),
    );
  }

  void _getProfile(token) async {
    await _auth.fetchUserProfile(token);

    if (_auth.isFetchProfile) {
      var _user = _auth.getUser();

      if (mounted) {
        setState(() {
          user = _user!;
          isSet = true;
          _updateFcmToken(token);
        });
      }
    }
  }

  void _updateFcmToken(_token) async {
    String? tk = await FirebaseMessaging.instance.getToken();
    Map<String, dynamic> body = {};
    // Save the initial token to the database
    body['fcm_token'] = tk;
    await _auth.updateUser(body: body, token: _token);
  }

  void _getDashBoard(DashBoardProvider dProvider, token) async {
    await _DProvider.fetchDashBoard(token);
    var db = await _DProvider.getDashBoard();
    setState(() {
      dashBoard = db;
      if (db != null) {
        hasToday = db.hasShiftToday;
        if (hasToday) {
          shift = db.shift.elementAt(0);
        }
      }
    });
  }
}
