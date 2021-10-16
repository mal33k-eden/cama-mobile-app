import 'package:cama/shared/flavors.dart';
import 'package:flutter/material.dart';

class ProfileCard extends StatelessWidget {
  const ProfileCard({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.fromLTRB(10, 20, 0, 30),
      child: Column(
        children: [
          // Align(
          //   alignment: Alignment.topRight,
          //   child: IconButton(onPressed: () {}, icon: Icon(Icons.edit_sharp)),
          // ),
          Row(
            children: [
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(25),
                  color: Colors.white,
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
                  borderRadius: BorderRadius.circular(25),
                  child: CircleAvatar(
                    radius: 50,
                    child: Image.asset(
                      'assets/images/avatar.jpg',
                    ),
                  ),
                ),
              ),
              SizedBox(
                width: 15,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'John DoeKwajhuing',
                    style: TextStyle(
                        fontSize: 20,
                        color: Colors.white,
                        fontWeight: FontWeight.bold),
                  ),
                  SizedBox(
                    height: 4,
                  ),
                  Text('edenated@gmail.com',
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 13,
                          fontWeight: FontWeight.w200)),
                  SizedBox(
                    height: 8,
                  ),
                  Text('Health Care Assistant',
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 17,
                          fontWeight: FontWeight.w500)),
                ],
              ),
            ],
          ),
          SizedBox(
            height: 20,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Column(
                children: [
                  Text('DOB',
                      style: TextStyle(
                          color: Colors.white, fontWeight: FontWeight.bold)),
                  Text('25/12/1993',
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 17,
                          fontWeight: FontWeight.bold)),
                ],
              ),
              Column(
                children: [
                  Text('Mobile',
                      style: TextStyle(
                          color: Colors.white, fontWeight: FontWeight.bold)),
                  Text('07786982012',
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 17,
                          fontWeight: FontWeight.bold)),
                ],
              ),
              Column(
                children: [
                  Text('Postcode',
                      style: TextStyle(
                          color: Colors.white, fontWeight: FontWeight.bold)),
                  Text('TS14P3',
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 17,
                          fontWeight: FontWeight.bold)),
                ],
              )
            ],
          ),
        ],
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
    );
  }
}
