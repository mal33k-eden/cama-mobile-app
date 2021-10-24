import 'dart:io';

import 'package:cama/providers/provider_auth.dart';
import 'package:cama/shared/avart_icon.dart';
import 'package:cama/shared/flavors.dart';
import 'package:cama/shared/form_kits.dart';
import 'package:cama/providers/provider_file.dart';
import 'package:cama/shared/imageviewer.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:path/path.dart' as path;
import 'package:provider/provider.dart';

class UpdateFile extends StatefulWidget {
  const UpdateFile({Key? key}) : super(key: key);

  @override
  _UpdateFileState createState() => _UpdateFileState();
}

class _UpdateFileState extends State<UpdateFile> {
  String selectedDate = '----';
  final _FormKey = GlobalKey<FormState>();
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  final nameController = TextEditingController();
  final dateController = TextEditingController();
  bool isLocal = true;
  bool isDoc = false;
  bool watchStatus = false;
  bool isTraining = false;
  bool isupdate = false; // what is the action type| insert or update
  var selectedFile = null;
  var selectedFileExt = null;
  var args;
  var file;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    dateController.text = selectedDate;
    Future.delayed(Duration.zero, () {
      args = ModalRoute.of(context)!.settings.arguments;
      if (args != null) {
        file = args["file"] ?? null;
        var type = args["type"] ?? null;
        if (file != null) {
          setState(() {
            if (type == 'doc') {
              isDoc = true;
              isTraining = false;
            } else {
              isTraining = true;
              isDoc = false;
            }
            isLocal = false;
            isupdate = true;
            nameController.text = file.name;
            dateController.text =
                (file.expires_on != null || file.expires_on != '')
                    ? file.expires_on
                    : '----';

            selectedFile = file.file;
            selectedFileExt = file.file_extension;
          });
        }
      }
    });
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    nameController.dispose();
    dateController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final auth = Provider.of<AuthProvider>(context);
    final _file = Provider.of<FileProvider>(context);
    if (watchStatus) {
      final fileSelect = context.watch<FileProvider>().isFileSelected;
      if (fileSelect) {
        _updateSelectedFile(_file);
        _checkWatchable(_file);
      }
    }
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        title: Text((isupdate) ? 'Update File' : 'Add File'),
        actions: [
          TextButton(
            onPressed: () {
              if (selectedFile != null) {
                if (isDoc || isTraining) {
                  if (_FormKey.currentState!.validate()) {
                    _submitForm(auth, _file, _scaffoldKey);
                  }
                } else {
                  showCustomAlert(
                      scaffoldState: _scaffoldKey,
                      title: 'Error',
                      message: 'Kindly select a file type to upload');
                }
              } else {
                showCustomAlert(
                    scaffoldState: _scaffoldKey,
                    title: 'Error',
                    message:
                        'You need to add an file to this form before submitting');
              }
            },
            child: Center(
              child: Text(
                'Save',
                style: TextStyle(color: Colors.white),
              ),
            ),
          )
        ],
      ),
      body: Container(
        padding: EdgeInsets.symmetric(horizontal: 30, vertical: 10),
        child: Form(
          key: _FormKey,
          child: ListView(
            shrinkWrap: true,
            children: [
              SizedBox(
                height: 15,
              ),
              Text(
                'Select File Type',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              Row(
                children: [
                  Checkbox(
                    activeColor: Flavor.secondaryToDark,
                    value: isDoc,
                    onChanged: (value) {
                      _updateActionState(value, 'doc');
                    },
                  ),
                  Text('Document'),
                  SizedBox(
                    width: 20,
                  ),
                  Checkbox(
                    activeColor: Flavor.secondaryToDark,
                    value: isTraining,
                    onChanged: (value) {
                      _updateActionState(value, 'tr');
                    },
                  ),
                  Text('Training')
                ],
              ),
              TextFormField(
                controller: nameController,
                decoration: textFieldDecorator.copyWith(
                    label: const Text('File Name'),
                    prefixIcon: Icon(Icons.file_upload),
                    hintText: 'Enter the name of the file'),
                validator: (val) => validateTextField(val),
                // The validator receives the text that the user has entered.
              ),
              const SizedBox(
                height: 10,
              ),
              TextFormField(
                showCursor: false,
                decoration: textFieldDecorator.copyWith(
                  label: const Text('Expires On'),
                  prefixIcon: Icon(Icons.calendar_today_sharp),
                ),
                readOnly: true,
                controller: dateController,
                onTap: () {
                  _showDateModal(context);
                },
                // The validator receives the text that the user has entered.
              ),
              const SizedBox(
                height: 25,
              ),
              (selectedFile != null)
                  ? Center(
                      //padding: EdgeInsets.all(10),
                      child: Stack(
                        children: [
                          InkWell(
                            child: ImageSelectorDisplay(
                                (selectedFileExt == '.pdf' ||
                                        selectedFileExt == 'pdf')
                                    ? 'assets/images/cama-pdf-placeholder.png'
                                    : (isLocal)
                                        ? File(selectedFile)
                                        : selectedFile,
                                isLocal,
                                (selectedFileExt == '.pdf' ||
                                        selectedFileExt == 'pdf')
                                    ? true
                                    : false),
                          ),
                          Positioned(
                            child: InkWell(
                              child: removeImageIcon(),
                              onTap: () {
                                setState(() {
                                  selectedFile = null;
                                  isLocal = true;
                                });
                              },
                            ),
                            top: 0,
                            right: 2,
                          ),
                        ],
                      ),
                    )
                  : TextButton(
                      onPressed: () {
                        _pickFile(_scaffoldKey, _file);
                      },
                      child: Text('Add A File')),
            ],
          ),
        ),
      ),
    );
  }

  void _showDateModal(BuildContext context) async {
    final DateTime? datePicked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(1800),
      lastDate: DateTime(3000),
    );

    if (datePicked != null && datePicked != selectedDate) {
      setState(() {
        selectedDate = DateFormat('dd-MM-yyyy').format(datePicked);
        dateController.text = selectedDate;
      });
    }
  }

  void _updateActionState(bool? value, String type) {
    if (!isupdate) {
      setState(() {
        if (type == 'doc') {
          isDoc = value!;
          isTraining = !isDoc;
        } else {
          isTraining = value!;
          isDoc = !isTraining;
        }
      });
    }
  }

  void _pickFile(scaffoldState, FileProvider fileProvider) async {
    setState(() {
      selectedFile = null;
    });
    await fileProvider.pickFileTrigger(scaffoldState);
    _checkWatchable(fileProvider);
  }

  void _updateSelectedFile(FileProvider fileProvider) async {
    var filepath = await fileProvider.getPath();

    setState(() {
      if (filepath != 'null') {
        selectedFile = filepath;
        selectedFileExt = path.extension(filepath);
        print(selectedFileExt);
        fileProvider.updateSelectStatus(false);
        watchStatus = false;
      }
    });
  }

  void _checkWatchable(FileProvider fileProvider) {
    setState(() {
      watchStatus = (fileProvider.isWatchable) ? true : false;
    });
  }

  void _submitForm(auth, FileProvider fileProvider, scaffoldKey) async {
    Map<String, dynamic> body = {};
    body['expires_on'] = dateController.text;
    body['name'] = nameController.text;
    if (isLocal) {
      (isDoc) ? body['file'] = File(selectedFile) : null;
      (isTraining) ? body['certificate'] = File(selectedFile) : null;
    }
    if (isupdate) {
      body['id'] = file.id;
    }

    (isDoc)
        ? await fileProvider.updateDocument(body: body, token: auth.token)
        : await fileProvider.updateTraining(body: body, token: auth.token);

    if (fileProvider.isDocUpdated) {
      showSnackBar(
          context: context,
          message: (isDoc) ? 'Document updated' : 'Training updated');
      Navigator.pop(context);
    } else {
      await showCustomAlert(
          scaffoldState: scaffoldKey,
          title: 'Error',
          message: 'something went wrong try again');
      Navigator.pop(context);
    }
  }
}
