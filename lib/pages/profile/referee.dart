import 'package:cama/providers/provider_auth.dart';
import 'package:cama/shared/flavors.dart';
import 'package:cama/shared/form_kits.dart';
import 'package:flutter/material.dart';
import 'package:path/path.dart';
import 'package:provider/src/provider.dart';

class Referee extends StatefulWidget {
  const Referee({Key? key}) : super(key: key);

  @override
  State<Referee> createState() => _RefereeState();
}

class _RefereeState extends State<Referee> {
  @override
  Widget build(BuildContext context) {
    final auth = Provider.of<AuthProvider>(context);
    final user = context.watch<AuthProvider>().getUser();
    List<dynamic> referees = user!.references;
    return Scaffold(
      appBar: AppBar(
        title: Text('Referees'),
        actions: [
          IconButton(
            icon: Icon(Icons.add_circle_sharp),
            color: Colors.white,
            onPressed: () {
              Navigator.pushNamed(context, 'referee-edit',
                  arguments: {"ref": null});
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: (referees.length > 0)
            ? ListView.builder(
                physics: ScrollPhysics(),
                shrinkWrap: true,
                primary: false,
                itemCount: referees.length,
                itemBuilder: (BuildContext context, int index) {
                  return Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Container(
                      //padding: EdgeInsets.all(10),
                      child: InkWell(
                        onTap: () {
                          _permissionEditDetails(
                              context, referees.elementAt(index));
                        },
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 25, vertical: 15),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              Row(
                                children: [
                                  Icon(
                                    Icons.person_sharp,
                                    color: Colors.white,
                                  ),
                                  SizedBox(
                                    width: 10,
                                  ),
                                  Text(
                                    referees.elementAt(index)['full_name'],
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ],
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              Row(
                                children: [
                                  Icon(
                                    Icons.business,
                                    color: Colors.white,
                                  ),
                                  SizedBox(
                                    width: 10,
                                  ),
                                  Text(
                                    referees.elementAt(index)['company'],
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ],
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              Row(
                                children: [
                                  Icon(
                                    Icons.badge_sharp,
                                    color: Colors.white,
                                  ),
                                  SizedBox(
                                    width: 10,
                                  ),
                                  Text(
                                    referees.elementAt(index)['position'],
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ],
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              Row(
                                children: [
                                  Icon(
                                    Icons.phone_android_sharp,
                                    color: Colors.white,
                                  ),
                                  SizedBox(
                                    width: 10,
                                  ),
                                  Text(
                                    referees.elementAt(index)['telephone'],
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  SizedBox(
                                    width: 30,
                                  ),
                                  Icon(
                                    Icons.email_sharp,
                                    color: Colors.white,
                                  ),
                                  Row(
                                    children: [
                                      Text(
                                        referees.elementAt(index)['email'],
                                        style: TextStyle(
                                            color: Colors.white,
                                            fontWeight: FontWeight.bold),
                                      )
                                    ],
                                  ),
                                ],
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              Row(
                                children: [
                                  Icon(
                                    Icons.location_city,
                                    color: Colors.white,
                                  ),
                                  SizedBox(
                                    width: 10,
                                  ),
                                  Text(
                                    referees.elementAt(index)['address'],
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold),
                                  )
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
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
                    ),
                  );
                })
            : SizedBox(),
      ),
    );
  }

  void moveToEdit(Map details) {
    Navigator.pushNamed(this.context, 'referee-edit',
        arguments: {"ref": details});
  }

  void _permissionEditDetails(BuildContext context, details) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Update Referee Details'),
        scrollable: true,
        content: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text('Are your sure you want to make changes to this entery?'),
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
                moveToEdit(details);
              },
              child: Text('Edit'))
        ],
      ),
    );
  }
}
