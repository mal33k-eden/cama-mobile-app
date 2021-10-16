import 'package:cama/shared/flavors.dart';
import 'package:cama/shared/form_kits.dart';
import 'package:flutter/material.dart';

class Referee extends StatelessWidget {
  const Referee({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Referee'),
        actions: [
          IconButton(
            icon: Icon(Icons.edit_sharp),
            color: Colors.white,
            onPressed: () {
              Navigator.pushNamed(context, 'referee-edit');
            },
          ),
        ],
      ),
      body: Container(
        child: SingleChildScrollView(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: Container(
                  //padding: EdgeInsets.all(10),
                  child: ListTile(
                    leading: CircleAvatar(
                      backgroundColor: Colors.white,
                      child: Text('1'),
                    ),
                    title: Text(
                      'Full Name',
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 20,
                          fontWeight: FontWeight.bold),
                    ),
                    subtitle: Text(
                      'Character/Professional',
                      style: TextStyle(
                          color: Colors.white, fontWeight: FontWeight.bold),
                    ),
                    trailing: InkWell(
                      child: Icon(
                        Icons.search_sharp,
                        color: Colors.white,
                      ),
                      onTap: () {
                        _showRefereeDetails(context);
                      },
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
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _showRefereeDetails(BuildContext context) {
    showDialog(
        context: context,
        builder: (context) => AlertDialog(
              title: Text('Details'),
              scrollable: true,
              content: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('Full NAME:'),
                  Text('Company:'),
                  Text('Position:'),
                  Text('Type:'),
                  Text('Email:'),
                  Text('Phone:'),
                  Text('Address:'),
                ],
              ),
            ));
  }
}
