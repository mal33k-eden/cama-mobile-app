import 'package:cama/pages/agency/attach_file.dart';
import 'package:cama/shared/flavors.dart';
import 'package:flutter/material.dart';

class AgencyDocuments extends StatefulWidget {
  const AgencyDocuments({Key? key}) : super(key: key);

  @override
  State<AgencyDocuments> createState() => _AgencyDocumentsState();
}

class _AgencyDocumentsState extends State<AgencyDocuments> {
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  var args;
  List<dynamic> docs = [];
  @override
  void initState() {
    // TODO: implement initState
    Future.delayed(Duration.zero, () {
      args = ModalRoute.of(context)!.settings.arguments;
      var _docs = args!["docs"];
      setState(() {
        docs = _docs;
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        title: Text('Required Documents'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: (docs.length > 0)
              ? ListView.builder(
                  shrinkWrap: true,
                  primary: false,
                  physics: ScrollPhysics(),
                  itemCount: docs.length,
                  itemBuilder: (BuildContext context, int index) {
                    return Container(
                      margin: EdgeInsets.fromLTRB(0, 10, 0, 10),
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
                        onTap: () {
                          _showUserDocumentsBottomSheet(
                              docs.elementAt(index)['name'],
                              docs.elementAt(index)['required_doc_id'],
                              docs.elementAt(index)['staff_profile_id'],
                              _scaffoldKey);
                        },
                        title: Text(docs.elementAt(index)['name']),
                        subtitle: Text(
                            (docs.elementAt(index)['expires_in'] != null)
                                ? 'Valid until: ' +
                                    docs.elementAt(index)['expires_in']
                                : 'Valid until: N/A'),
                        trailing: (docs.elementAt(index)['is_submitted'])
                            ? Icon(Icons.check_circle_sharp,
                                color: Flavor.secondaryToDark)
                            : Icon(Icons.cancel_sharp, color: null),
                      ),
                    );
                  })
              : SizedBox(),
        ),
      ),
    );
  }

  _showUserDocumentsBottomSheet(docName, reqid, profileId, scafoldstate) {
    return showModalBottomSheet(
        backgroundColor: Flavor.primaryToDark,
        context: context,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(
            top: Radius.circular(30),
          ),
        ),
        clipBehavior: Clip.antiAliasWithSaveLayer,
        builder: (context) {
          return AttacheFile(
            doc_name: docName,
            staff_profile_id: profileId.toString(),
            required_doc_id: reqid.toString(),
            currentFileType: 'doc',
            scafoldstate: scafoldstate,
          );
        });
  }
}
