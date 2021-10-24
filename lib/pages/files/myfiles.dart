import 'package:cama/models/document.dart';
import 'package:cama/models/training.dart';
import 'package:cama/providers/provider_auth.dart';
import 'package:cama/providers/provider_file.dart';
import 'package:cama/shared/flavors.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class MyFiles extends StatefulWidget {
  const MyFiles({Key? key}) : super(key: key);

  @override
  State<MyFiles> createState() => _MyFilesState();
}

class _MyFilesState extends State<MyFiles> {
  late final FileProvider _fileProvider;
  late final AuthProvider _authProvider;
  var args;
  List<dynamic> file = [];
  List<MyDocument> myDocs = [];
  List<MyTraining> myTrns = [];
  String currentFileType = 'doc'; //default is doc
  @override
  void initState() {
    // TODO: implement initState
    WidgetsBinding.instance?.addPostFrameCallback((timeStamp) {
      _fileProvider = Provider.of<FileProvider>(context, listen: false);
      _authProvider = Provider.of<AuthProvider>(context, listen: false);

      _getFiles();
    });
    // Future.delayed(Duration.zero, () {
    //   args = ModalRoute.of(context)!.settings.arguments;
    //   var _docs = args!["docs"];
    //   setState(() {
    //     docs = _docs;
    //   });
    // });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    print(myDocs.length);
    return Scaffold(
      appBar: AppBar(
        title: Text(
            'All My ${(currentFileType == 'doc') ? 'Documents' : 'Trainings'}'),
        actions: [
          IconButton(
            icon: Icon(Icons.swipe_sharp),
            onPressed: () {
              _managePageView((currentFileType == 'doc') ? 'training' : 'doc');
            },
          ),
          IconButton(
            icon: Icon(Icons.add_circle_sharp),
            onPressed: () {
              Navigator.pushNamed(context, 'my-files-edit');
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: (file.length > 0)
              ? ListView.builder(
                  shrinkWrap: true,
                  primary: false,
                  physics: ScrollPhysics(),
                  itemCount: file.length,
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
                      child: InkWell(
                        onTap: () {
                          _permissionEditDetails(
                              context, file.elementAt(index));
                        },
                        child: ListTile(
                            leading: CircleAvatar(
                                backgroundColor: Flavor.primaryToDark,
                                child: (file.elementAt(index).file_extension ==
                                        'pdf')
                                    ? Icon(
                                        Icons.picture_as_pdf_sharp,
                                        color: Colors.white,
                                      )
                                    : Icon(
                                        Icons.photo_sharp,
                                        color: Colors.white,
                                      )),
                            title: Text(file.elementAt(index).name),
                            subtitle: Text(
                                (file.elementAt(index).expires_on == null ||
                                        file.elementAt(index).expires_on == '')
                                    ? 'valid until : N/A'
                                    : 'valid until : ' +
                                        file.elementAt(index).expires_on),
                            trailing: Icon(Icons.check_circle_sharp,
                                color: Flavor.secondaryToDark)),
                      ),
                    );
                  })
              : SizedBox(),
        ),
      ),
    );
  }

  void _getFiles() async {
    await _fileProvider.getAllFiles(_authProvider.token);
    if (_fileProvider.isSetMyDocs) {
      if (mounted) {
        setState(() {
          myDocs = _fileProvider.myDocs()!;
        });
      }
    }
    if (_fileProvider.isSetMyTrainings) {
      if (mounted) {
        setState(() {
          myTrns = _fileProvider.myTrainings()!;
        });
      }
    }
    _managePageView(currentFileType);
  }

  void _managePageView(view) {
    file = [];
    setState(() {
      currentFileType = view;
      if (view == 'doc') {
        file = myDocs;
      } else {
        file = myTrns;
      }
    });
  }

  void _permissionEditDetails(BuildContext context, details) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Update File Details'),
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
                moveToEdit(details);
              },
              child: Text('Edit'))
        ],
      ),
    );
  }

  void moveToEdit(details) {
    Navigator.pushNamed(this.context, 'my-files-edit',
        arguments: {"file": details, 'type': currentFileType});
  }
}
