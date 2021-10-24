import 'package:cama/pages/agency/attach_file.dart';
import 'package:cama/shared/flavors.dart';
import 'package:flutter/material.dart';

class AgencyTraining extends StatefulWidget {
  const AgencyTraining({Key? key}) : super(key: key);

  @override
  State<AgencyTraining> createState() => _AgencyTrainingState();
}

class _AgencyTrainingState extends State<AgencyTraining> {
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  var args;
  List<dynamic> training = [];
  @override
  void initState() {
    // TODO: implement initState
    Future.delayed(Duration.zero, () {
      args = ModalRoute.of(context)!.settings.arguments;
      var _training = args!["trainings"];
      setState(() {
        training = _training;
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        title: Text('Required Trainings'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: (training.length > 0)
              ? ListView.builder(
                  shrinkWrap: true,
                  primary: false,
                  physics: ScrollPhysics(),
                  itemCount: training.length,
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
                              training.elementAt(index)['name'],
                              training.elementAt(index)['required_training_id'],
                              training.elementAt(index)['staff_profile_id'],
                              _scaffoldKey);
                        },
                        title: Text(training.elementAt(index)['name']),
                        subtitle: Text(
                            (training.elementAt(index)['expires_in'] != null)
                                ? 'Valid until: ' +
                                    training.elementAt(index)['expires_in']
                                : 'Valid until: N/A'),
                        trailing: (training.elementAt(index)['is_submitted'])
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
            currentFileType: 'training',
            scafoldstate: scafoldstate,
          );
        });
  }
}
