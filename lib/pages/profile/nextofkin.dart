import 'package:cama/shared/form_kits.dart';
import 'package:flutter/material.dart';

class NextOfKin extends StatelessWidget {
  const NextOfKin({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Next Of Kin'),
        actions: [
          IconButton(
            icon: Icon(Icons.edit_sharp),
            color: Colors.white,
            onPressed: () {
              Navigator.pushNamed(context, 'nextofkin-edit');
            },
          ),
        ],
      ),
      body: Container(
        child: SingleChildScrollView(
          child: Column(
            children: [
              ListTile(
                title: Text('Full name'),
                subtitle: Text('John Doe'),
              ),
              ListTile(
                title: Text('Address'),
                subtitle: Text('136 Ayresome Street'),
              ),
              ListTile(
                title: Text('Postcode'),
                subtitle: Text('TS1 4PE'),
              ),
              ListTile(
                title: Text('Mobile'),
                subtitle: Text('07786982012'),
              ),
              ListTile(
                title: Text('Phone'),
                subtitle: Text('07786982012'),
              ),
              ListTile(
                title: Text('E-mail'),
                subtitle: Text('Edenated@gmail.com'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
