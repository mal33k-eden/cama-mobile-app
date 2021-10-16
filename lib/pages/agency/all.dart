import 'package:cama/shared/flavors.dart';
import 'package:flutter/material.dart';

class AllAgencies extends StatelessWidget {
  const AllAgencies({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [Icon(Icons.tune_sharp)],
        title: Text('Agencies'),
      ),
      body: Container(
        child: SingleChildScrollView(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(8),
                child: InkWell(
                  onTap: () {
                    Navigator.pushNamed(context, 'agency-profile');
                  },
                  child: Container(
                    padding: EdgeInsets.symmetric(horizontal: 8, vertical: 13),
                    child: Column(
                      children: [
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
                                  backgroundColor: Colors.white,
                                  radius: 50,
                                  child: Image.asset(
                                    'assets/logos/icon.png',
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
                                  'Good Will Healthcare LTD',
                                  style: TextStyle(
                                      fontSize: 20,
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold),
                                ),
                                SizedBox(
                                  height: 4,
                                ),
                                Text('info@ghscare.org.uk',
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 15,
                                        fontWeight: FontWeight.bold)),
                                SizedBox(
                                  height: 8,
                                ),
                                Text('TS14PE, Middlesbrough',
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 15,
                                        fontWeight: FontWeight.bold)),
                              ],
                            ),
                          ],
                        ),
                        Text('Enrolled',
                            textAlign: TextAlign.end,
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 15,
                                fontWeight: FontWeight.bold))
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
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8),
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 8, vertical: 13),
                  child: Column(
                    children: [
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
                                backgroundColor: Colors.white,
                                radius: 50,
                                child: Image.asset(
                                  'assets/logos/icon.png',
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
                                'Good Will Healthcare LTD',
                                style: TextStyle(
                                    fontSize: 20,
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold),
                              ),
                              SizedBox(
                                height: 4,
                              ),
                              Text('info@ghscare.org.uk',
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 15,
                                      fontWeight: FontWeight.bold)),
                              SizedBox(
                                height: 8,
                              ),
                              Text('TS14PE, Middlesbrough',
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 15,
                                      fontWeight: FontWeight.bold)),
                            ],
                          ),
                        ],
                      ),
                      Text('Enrolled',
                          textAlign: TextAlign.end,
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 15,
                              fontWeight: FontWeight.bold))
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
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
