import 'package:cama/shared/flavors.dart';
import 'package:flutter/material.dart';

class AgencyProfile extends StatefulWidget {
  const AgencyProfile({Key? key}) : super(key: key);

  @override
  State<AgencyProfile> createState() => _AgencyProfileState();
}

class _AgencyProfileState extends State<AgencyProfile> {
  bool _permitBCM = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                            ' Goodwill Healthcare Service LTD',
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
                          Text(' 07786982012 / 07786982012',
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
                          Text(' info@ghscare.org.uk',
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
                          Text(' Ts1 4PE',
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
                          Text(' Address',
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
                          Text(' Town',
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
                        subtitle: Text('0/9'),
                        trailing: CircleAvatar(
                          backgroundColor: Flavor.primaryToDark,
                          radius: 20,
                          child: Icon(
                            Icons.cancel_sharp,
                            color: Colors.red,
                          ),
                        ),
                        onTap: () {
                          Navigator.pushNamed(context, 'agency-documents');
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
                        subtitle: Text('0/2'),
                        trailing: CircleAvatar(
                          backgroundColor: Flavor.primaryToDark,
                          radius: 20,
                          child: Icon(
                            Icons.cancel_sharp,
                            color: Colors.red,
                          ),
                        ),
                        onTap: () {
                          Navigator.pushNamed(context, 'agency-trainings');
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
                        subtitle: Text('0/2'),
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
}
