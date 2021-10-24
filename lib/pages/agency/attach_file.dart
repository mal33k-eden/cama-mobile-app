import 'package:cama/models/document.dart';
import 'package:cama/models/training.dart';
import 'package:cama/providers/provider_agency.dart';
import 'package:cama/providers/provider_auth.dart';
import 'package:cama/providers/provider_file.dart';
import 'package:cama/shared/flavors.dart';
import 'package:cama/shared/form_kits.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AttacheFile extends StatefulWidget {
  String required_doc_id;
  String doc_name;
  String staff_profile_id;
  String currentFileType; //default is doc
  var scafoldstate;
  AttacheFile(
      {Key? key,
      required this.doc_name,
      required this.staff_profile_id,
      required this.required_doc_id,
      required this.currentFileType,
      required this.scafoldstate})
      : super(key: key);

  @override
  _AttacheFileState createState() => _AttacheFileState();
}

class _AttacheFileState extends State<AttacheFile> {
  late final FileProvider _fileProvider;
  late final AuthProvider _authProvider;
  late final AgencyProvider _agencyProvider;

  int? selectedFile;
  int? submitFileId;
  var args;
  List<dynamic> file = [];
  List<MyDocument> myDocs = [];
  List<MyTraining> myTrns = [];

  @override
  void initState() {
    // TODO: implement initState
    WidgetsBinding.instance?.addPostFrameCallback((timeStamp) {
      _fileProvider = Provider.of<FileProvider>(context, listen: false);
      _authProvider = Provider.of<AuthProvider>(context, listen: false);
      _agencyProvider = Provider.of<AgencyProvider>(context, listen: false);
      if (mounted) {
        _getFiles();
      }
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    print(widget.doc_name);
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        SizedBox(
          height: 10,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Container(
              margin: EdgeInsets.fromLTRB(25, 0, 0, 0),
              child: Text(
                'Select Your File',
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                    color: Colors.white),
              ),
            ),
            (selectedFile != null)
                ? TextButton.icon(
                    onPressed: () {
                      _showPermissionDialog();
                    },
                    icon: Icon(
                      Icons.save_sharp,
                      color: Colors.white,
                    ),
                    label: Text(
                      'Submit',
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 15,
                          color: Colors.white),
                    ))
                : SizedBox()
          ],
        ),
        Divider(),
        SizedBox(
          height: 10,
        ),
        Expanded(
            child: SingleChildScrollView(
          child: ListView.builder(
              physics: ScrollPhysics(),
              shrinkWrap: true,
              itemCount: file.length,
              itemBuilder: (context, int index) {
                return Container(
                  child: RadioListTile(
                    value: index,
                    groupValue: selectedFile,
                    onChanged: (val) {
                      _selectedFile(val, file.elementAt(index).id);
                    },
                    selectedTileColor: Flavor.secondaryToDark,
                    activeColor: Flavor.secondaryToDark,
                    title: Text(
                      file.elementAt(index).name,
                      style: TextStyle(color: Colors.white),
                    ),
                    subtitle: (file.elementAt(index).expires_on != null)
                        ? Text(
                            file.elementAt(index).expires_on,
                            style: TextStyle(color: Colors.white),
                          )
                        : Text(
                            'valid until : N/A',
                            style: TextStyle(color: Colors.white),
                          ),
                  ),
                );
              }),
        ))
      ],
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
    _managePageView(widget.currentFileType);
  }

  void _managePageView(view) {
    file = [];
    if (mounted) {
      setState(() {
        widget.currentFileType = view;
        if (view == 'doc') {
          file = myDocs;
        } else {
          file = myTrns;
        }
      });
    }
  }

  _selectedFile(val, _submitFileId) {
    setState(() {
      selectedFile = val;
      submitFileId = _submitFileId;
    });
  }

  void _showPermissionDialog() {
    Navigator.pop(context);
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Submit File To Agency'),
        scrollable: true,
        content: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
                'By clicking contine, you will be submitting this document as ${widget.doc_name} to the agency.'),
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
                _submitFormAttachment(context);
              },
              child: Text('Edit'))
        ],
      ),
    );
  }

  void _submitFormAttachment(context) async {
    Map<String, dynamic> body = {};
    body['staff_profile_id'] = widget.staff_profile_id;

    body['staff_training_id'] = widget.staff_profile_id;
    print(widget.currentFileType);
    if (widget.currentFileType == 'doc') {
      body['staff_document_id'] = submitFileId.toString();
      body['required_doc_id'] = widget.required_doc_id;
      await _agencyProvider.attacheDoc(body: body, token: _authProvider.token!);
    } else {
      body['staff_training_id'] = submitFileId.toString();
      body['required_training_id'] = widget.required_doc_id;
      await _agencyProvider.attacheTraining(
          body: body, token: _authProvider.token!);
    }
    if (_agencyProvider.isSetMyAgencies) {
      showSnackBar(
          context: widget.scafoldstate.currentContext,
          message: 'File Submitted');
      Navigator.pop(widget.scafoldstate.currentContext);
    } else {
      Navigator.pop(widget.scafoldstate.currentContext);
      await showCustomAlert(
          scaffoldState: widget.scafoldstate!,
          title: 'Error',
          message: 'something went wrong try again');
    }
  }
}
