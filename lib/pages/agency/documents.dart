import 'package:flutter/material.dart';

class AgencyDocuments extends StatelessWidget {
  const AgencyDocuments({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Required Documents'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: ListView(
            shrinkWrap: true,
            children: [
              Container(
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
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
                child: ListTile(
                  title: Text('Curriculum Vitae'),
                  subtitle: Text('Expires in 2020'),
                  trailing: Icon(Icons.cancel_sharp),
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Container(
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
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
                child: ListTile(
                  title: Text('Passport'),
                  subtitle: Text('Expires in 2020'),
                  trailing: Icon(Icons.cancel_sharp),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
