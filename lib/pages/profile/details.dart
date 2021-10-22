import 'package:cama/providers/provider_auth.dart';
import 'package:cama/shared/form_kits.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class PersonalDetails extends StatelessWidget {
  const PersonalDetails({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final user = context.watch<AuthProvider>().getUser();
    return Scaffold(
      appBar: AppBar(
        title: Text('Profile Details'),
        actions: [
          IconButton(
            icon: Icon(Icons.edit_sharp),
            color: Colors.white,
            onPressed: () {
              Navigator.pushReplacementNamed(context, 'profile-details-edit');
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
                subtitle: Text("${user!.first_name} ${user.last_name}"),
              ),
              ListTile(
                title: Text('Date Of Birth'),
                subtitle: Text(
                    "${(user.date_of_birth != null) ? user.date_of_birth : '---'}"),
              ),
              ListTile(
                title: Text('Highest Qualification'),
                subtitle: Text(
                    "${(user.highest_qualification != null) ? user.highest_qualification : '---'}"),
              ),
              ListTile(
                title: Text('Nationality '),
                subtitle: Text("${user.nationality}"),
              ),
              ListTile(
                title: Text('Address'),
                subtitle: Text("${user.address}"),
              ),
              ListTile(
                title: Text('Postcode'),
                subtitle: Text("${user.postcode}"),
              ),
              ListTile(
                title: Text('Region'),
                subtitle: Text("${user.region}"),
              ),
              ListTile(
                title: Text('Mobile'),
                subtitle: Text(user.mobile),
              ),
              ListTile(
                title: Text('E-mail'),
                subtitle: Text(user.email),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
