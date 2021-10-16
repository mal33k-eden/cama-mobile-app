import 'package:cama/pages/profile/profilecard.dart';
import 'package:cama/shared/flavors.dart';
import 'package:flutter/material.dart';

class Summary extends StatelessWidget {
  const Summary({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Profile Summary'),
        actions: [IconButton(onPressed: () {}, icon: Icon(Icons.logout_sharp))],
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
                      subtitle: Text('Incomplete'),
                      trailing: CircleAvatar(
                        backgroundColor: Flavor.primaryToDark,
                        radius: 20,
                        child: Icon(
                          Icons.cancel_sharp,
                          color: Flavor.secondaryToDark,
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
                      trailing: CircleAvatar(
                        backgroundColor: Flavor.primaryToDark,
                        radius: 20,
                        child: Icon(
                          Icons.cancel_sharp,
                          color: Colors.red,
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
                      trailing: CircleAvatar(
                        backgroundColor: Flavor.primaryToDark,
                        radius: 20,
                        child: Icon(
                          Icons.cancel_sharp,
                          color: Colors.red,
                        ),
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
                      trailing: CircleAvatar(
                        backgroundColor: Flavor.primaryToDark,
                        radius: 20,
                        child: Icon(
                          Icons.cancel_sharp,
                          color: Colors.red,
                        ),
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
                      trailing: CircleAvatar(
                        backgroundColor: Flavor.primaryToDark,
                        radius: 20,
                        child: Icon(
                          Icons.cancel_sharp,
                          color: Colors.red,
                        ),
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
                        trailing: CircleAvatar(
                          backgroundColor: Flavor.primaryToDark,
                          radius: 20,
                          child: Icon(
                            Icons.cancel_sharp,
                            color: Colors.red,
                          ),
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
    );
  }
}
