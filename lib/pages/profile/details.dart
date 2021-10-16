import 'package:cama/shared/form_kits.dart';
import 'package:flutter/material.dart';

class PersonalDetails extends StatelessWidget {
  const PersonalDetails({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Profile Details'),
        actions: [
          IconButton(
            icon: Icon(Icons.edit_sharp),
            color: Colors.white,
            onPressed: () {
              Navigator.pushNamed(context, 'profile-details-edit');
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
                title: Text('Date Of Birth'),
                subtitle: Text('John Doe'),
              ),
              ListTile(
                title: Text('Highest Qualification'),
                subtitle: Text('Masters'),
              ),
              ListTile(
                title: Text('Nationality '),
                subtitle: Text('Ghanaian'),
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
                title: Text('Region'),
                subtitle: Text('England'),
              ),
              ListTile(
                title: Text('Mobile'),
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
