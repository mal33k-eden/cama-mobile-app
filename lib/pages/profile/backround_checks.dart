import 'package:cama/shared/flavors.dart';
import 'package:cama/shared/form_kits.dart';
import 'package:flutter/material.dart';

class BackgroundChecks extends StatelessWidget {
  const BackgroundChecks({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Background Checks'),
        actions: [
          IconButton(
            icon: Icon(Icons.edit_sharp),
            color: Colors.white,
            onPressed: () {
              Navigator.pushNamed(context, 'background-checks-edit');
            },
          ),
        ],
      ),
      body: Container(
        child: SingleChildScrollView(
          child: Column(
            children: [
              ListTile(
                title: Text('Update Service ID'),
                subtitle: Text('OP98MKL091QR'),
              ),
              ListTile(
                title: Text('Valid Until'),
                subtitle: Text('112-25-2021'),
              ),
              ListTile(
                title: Text('Declaration'),
                subtitle: Text('True'),
              ),
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: Container(
                  //padding: EdgeInsets.all(10),
                  child: ListTile(
                    leading: CircleAvatar(
                      backgroundColor: Colors.white,
                      child: Icon(
                        Icons.description_sharp,
                        color: Flavor.primaryToDark,
                      ),
                    ),
                    title: Text(
                      'File_name.pdf',
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 20,
                          fontWeight: FontWeight.bold),
                    ),
                    subtitle: Text(
                      'File Available',
                      style: TextStyle(
                          color: Colors.white, fontWeight: FontWeight.bold),
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
}
