import 'package:cama/api/auth.dart';
import 'package:cama/models/user.dart';
import 'package:cama/pages/profile/profilecard.dart';
import 'package:cama/providers/provider_auth.dart';
import 'package:cama/shared/flavors.dart';
import 'package:cama/widgets/loader.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Summary extends StatefulWidget {
  const Summary({Key? key}) : super(key: key);

  @override
  State<Summary> createState() => _SummaryState();
}

class _SummaryState extends State<Summary> {
  late final User user;
  late final AuthProvider auth;
  bool isSet = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    WidgetsBinding.instance?.addPostFrameCallback((timeStamp) {
      auth = Provider.of<AuthProvider>(context, listen: false);
      _getProfile(auth.token);
    });
  }

  @override
  Widget build(BuildContext context) {
    return (isSet)
        ? Scaffold(
            appBar: AppBar(
              leading: (user.compulsory_checks == "Complete")
                  ? IconButton(
                      onPressed: () {
                        Navigator.of(context).pushNamedAndRemoveUntil(
                            'dashboard', (Route<dynamic> route) => false);
                      },
                      icon: Icon(Icons.dashboard_sharp))
                  : null,
              title: Text('Profile Summary'),
              actions: [
                IconButton(
                    onPressed: () async {
                      await auth.logout(token: auth.token!);
                      (auth.isLoggedout)
                          ? Navigator.of(context).pushNamedAndRemoveUntil(
                              '/', (Route<dynamic> route) => false)
                          : null;
                    },
                    icon: Icon(Icons.power_settings_new_sharp))
              ],
            ),
            body: SingleChildScrollView(
              child: Container(
                padding: EdgeInsets.symmetric(vertical: 15, horizontal: 15),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    ProfileCard(),
                    SizedBox(
                      height: 25,
                    ),
                    Text(
                      'More Details',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Flavor.primaryToDark),
                    ),
                    Divider(),
                    SizedBox(
                      height: 5,
                    ),
                    // Text(
                    //   'In other to begin interacting with your agency, you will need to complete your profile with the right informations.',
                    //   style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    // ),
                    SizedBox(
                      height: 8,
                    ),
                    ListView(
                      primary: false,
                      shrinkWrap: true,
                      children: [
                        Card(
                            child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: ListTile(
                            leading: CircleAvatar(
                              backgroundColor: Flavor.primaryToDark,
                              radius: 30,
                              child: Icon(
                                Icons.person_sharp,
                                size: 30,
                                color: Colors.white,
                              ),
                            ),
                            title: Text(
                              'Personal Details',
                              style: TextStyle(
                                  fontSize: 18, fontWeight: FontWeight.bold),
                            ),
                            subtitle: Text(user.ProfileStatus),
                            trailing: CircleAvatar(
                              backgroundColor: Flavor.primaryToDark,
                              radius: 20,
                              child: Icon(
                                (user.ProfileStatus == 'Incomplete')
                                    ? Icons.cancel_sharp
                                    : Icons.check_circle_sharp,
                                color: (user.ProfileStatus == 'Incomplete')
                                    ? Colors.red
                                    : Flavor.secondaryToDark,
                              ),
                            ),
                            onTap: () {
                              Navigator.pushNamed(context, 'profile-details');
                            },
                          ),
                        )),
                        Card(
                            child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: ListTile(
                            leading: CircleAvatar(
                              backgroundColor: Flavor.primaryToDark,
                              radius: 30,
                              child: Icon(
                                Icons.person_search_sharp,
                                color: Colors.white,
                                size: 30,
                              ),
                            ),
                            title: Text(
                              'Background Checks',
                              style: TextStyle(
                                  fontSize: 18, fontWeight: FontWeight.bold),
                            ),
                            subtitle: Text(
                                (user.dbs == null) ? 'Incomplete' : 'Complete'),
                            trailing: CircleAvatar(
                              backgroundColor: Flavor.primaryToDark,
                              radius: 20,
                              child: Icon(
                                (user.dbs == null)
                                    ? Icons.cancel_sharp
                                    : Icons.check_circle_sharp,
                                color: (user.dbs == null)
                                    ? Colors.red
                                    : Flavor.secondaryToDark,
                              ),
                            ),
                            onTap: () {
                              Navigator.pushNamed(context, 'background-checks');
                            },
                          ),
                        )),
                        Card(
                            child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: ListTile(
                            leading: CircleAvatar(
                              backgroundColor: Flavor.primaryToDark,
                              radius: 30,
                              child: Icon(
                                Icons.work_sharp,
                                color: Colors.white,
                                size: 30,
                              ),
                            ),
                            title: Text(
                              'Work History',
                              style: TextStyle(
                                  fontSize: 18, fontWeight: FontWeight.bold),
                            ),
                            subtitle: Text((user.work_history.length < 2)
                                ? "${user.work_history.length} / 2"
                                : "Complete"),
                            trailing: CircleAvatar(
                              backgroundColor: Flavor.primaryToDark,
                              radius: 20,
                              child: Icon(
                                  (user.work_history.length < 2)
                                      ? Icons.cancel_sharp
                                      : Icons.check_circle_sharp,
                                  color: (user.work_history.length < 2)
                                      ? Colors.red
                                      : Flavor.secondaryToDark),
                            ),
                            onTap: () {
                              Navigator.pushNamed(context, 'work-history');
                            },
                          ),
                        )),
                        Card(
                            child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: ListTile(
                            leading: CircleAvatar(
                              backgroundColor: Flavor.primaryToDark,
                              radius: 30,
                              child: Icon(
                                Icons.badge_sharp,
                                color: Colors.white,
                                size: 30,
                              ),
                            ),
                            title: Text(
                              'Qualifications',
                              style: TextStyle(
                                  fontSize: 18, fontWeight: FontWeight.bold),
                            ),
                            subtitle: Text((user.qualifications.isEmpty)
                                ? "Incomplete"
                                : "Complete"),
                            trailing: CircleAvatar(
                              backgroundColor: Flavor.primaryToDark,
                              radius: 20,
                              child: Icon(
                                  (user.qualifications.isEmpty)
                                      ? Icons.cancel_sharp
                                      : Icons.check_circle_sharp,
                                  color: (user.qualifications.isEmpty)
                                      ? Colors.red
                                      : Flavor.secondaryToDark),
                            ),
                            onTap: () {
                              Navigator.pushNamed(context, 'qualification');
                            },
                          ),
                        )),
                        Card(
                            child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: ListTile(
                            leading: CircleAvatar(
                              backgroundColor: Flavor.primaryToDark,
                              radius: 30,
                              child: Icon(
                                Icons.family_restroom,
                                color: Colors.white,
                                size: 30,
                              ),
                            ),
                            title: Text(
                              'Next Of Kin',
                              style: TextStyle(
                                  fontSize: 18, fontWeight: FontWeight.bold),
                            ),
                            subtitle: Text((user.nextOfKin == null)
                                ? "Incomplete"
                                : "Completed"),
                            trailing: CircleAvatar(
                              backgroundColor: Flavor.primaryToDark,
                              radius: 20,
                              child: Icon(
                                  (user.nextOfKin == null)
                                      ? Icons.cancel_sharp
                                      : Icons.check_circle_sharp,
                                  color: (user.nextOfKin == null)
                                      ? Colors.red
                                      : Flavor.secondaryToDark),
                            ),
                            onTap: () {
                              Navigator.pushNamed(context, 'nextofkin');
                            },
                          ),
                        )),
                        Card(
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: ListTile(
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
                                'Referees',
                                style: TextStyle(
                                    fontSize: 18, fontWeight: FontWeight.bold),
                              ),
                              subtitle: Text((user.references.length < 2)
                                  ? "${user.references.length} / 2"
                                  : "Completed"),
                              trailing: CircleAvatar(
                                backgroundColor: Flavor.primaryToDark,
                                radius: 20,
                                child: Icon(
                                    (user.references.length < 2)
                                        ? Icons.cancel_sharp
                                        : Icons.check_circle_sharp,
                                    color: (user.references.length < 2)
                                        ? Colors.red
                                        : Flavor.secondaryToDark),
                              ),
                              onTap: () {
                                Navigator.pushNamed(context, 'referee');
                              },
                            ),
                          ),
                        ),
                      ],
                    )
                  ],
                ),
              ),
            ),
          )
        : Loader();
  }

  void _getProfile(token) async {
    await auth.fetchUserProfile(token);

    if (auth.isFetchProfile) {
      var _user = auth.getUser();

      if (mounted) {
        setState(() {
          user = _user!;
          isSet = true;
        });
      }
    }
  }
}
