import 'package:cama/providers/provider_auth.dart';
import 'package:cama/shared/form_kits.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class NextOfKin extends StatelessWidget {
  const NextOfKin({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final auth = Provider.of<AuthProvider>(context);
    final user = context.watch<AuthProvider>().getUser();
    Map nok = user!.nextOfKin;
    return Scaffold(
      appBar: AppBar(
        title: Text('Next Of Kin'),
        actions: [
          IconButton(
            icon:
                Icon((nok != null) ? Icons.edit_sharp : Icons.add_circle_sharp),
            color: Colors.white,
            onPressed: () {
              Navigator.pushNamed(context, 'nextofkin-edit',
                  arguments: {'nok': nok});
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
                subtitle: (nok == null)
                    ? Text('----')
                    : Text(
                        (nok['full_name'] == null) ? '----' : nok['full_name']),
              ),
              ListTile(
                title: Text('Address'),
                subtitle: (nok == null)
                    ? Text('----')
                    : Text((nok['address'] == null) ? '----' : nok['address']),
              ),
              ListTile(
                title: Text('Postcode'),
                subtitle: (nok == null)
                    ? Text('----')
                    : Text(
                        (nok['postcode'] == null) ? '----' : nok['postcode']),
              ),
              ListTile(
                title: Text('Mobile'),
                subtitle: (nok == null)
                    ? Text('----')
                    : Text((nok['home_telephone'] == null)
                        ? '----'
                        : nok['home_telephone']),
              ),
              ListTile(
                title: Text('Phone'),
                subtitle: (nok == null)
                    ? Text('----')
                    : Text((nok['office_telephone'] == null)
                        ? '----'
                        : nok['office_telephone']),
              ),
              ListTile(
                title: Text('E-mail'),
                subtitle: (nok == null)
                    ? Text('----')
                    : Text((nok['email'] == null) ? '----' : nok['email']),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
