import 'package:cama/providers/provider_auth.dart';
import 'package:cama/shared/flavors.dart';
import 'package:cama/shared/form_kits.dart';
import 'package:flutter/material.dart';
import 'package:provider/src/provider.dart';

class Qualification extends StatefulWidget {
  const Qualification({Key? key}) : super(key: key);

  @override
  State<Qualification> createState() => _QualificationState();
}

class _QualificationState extends State<Qualification> {
  @override
  Widget build(BuildContext context) {
    final auth = Provider.of<AuthProvider>(context);
    final user = context.watch<AuthProvider>().getUser();
    List<dynamic> qualifications = user!.qualifications;
    return Scaffold(
      appBar: AppBar(
        title: Text('Qualifications'),
        actions: [
          IconButton(
            icon: Icon(Icons.add_circle_sharp),
            color: Colors.white,
            onPressed: () {
              Navigator.pushNamed(context, 'qualification-edit',
                  arguments: {"qualification": null});
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: (qualifications.length > 0)
            ? ListView.builder(
                physics: ScrollPhysics(),
                shrinkWrap: true,
                primary: false,
                itemCount: qualifications.length,
                itemBuilder: (BuildContext context, int index) {
                  return Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Container(
                      //padding: EdgeInsets.all(10),
                      child: ListTile(
                        leading: CircleAvatar(
                          backgroundColor: Colors.white,
                          child: Text('${index + 1}'),
                        ),
                        title: Text(
                          '${qualifications[index]['qualification']}, ${qualifications[index]['year']}',
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 20,
                              fontWeight: FontWeight.bold),
                        ),
                        subtitle: Text(
                          qualifications[index]['course'],
                          style: TextStyle(
                              color: Colors.white, fontWeight: FontWeight.bold),
                        ),
                        trailing: InkWell(
                          child: Icon(
                            Icons.edit_sharp,
                            color: Colors.white,
                          ),
                          onTap: () {
                            _showWorkHistoryDetails(
                                context, qualifications.elementAt(index));
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
                  );
                })
            : SizedBox(),
      ),
    );
  }

  void _showWorkHistoryDetails(BuildContext context, details) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Update Qualification'),
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
                move(details);
              },
              child: Text('Edit'))
        ],
      ),
    );
  }

  void move(details) {
    Navigator.pushNamed(context, 'qualification-edit',
        arguments: {'qualification': details});
  }
}
