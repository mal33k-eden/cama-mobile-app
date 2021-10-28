import 'dart:io';

import 'package:cama/models/shift.dart';
import 'package:cama/providers/provider_auth.dart';
import 'package:cama/providers/provider_file.dart';
import 'package:cama/providers/provider_shift.dart';
import 'package:cama/shared/avart_icon.dart';
import 'package:cama/shared/flavors.dart';
import 'package:cama/shared/form_kits.dart';
import 'package:cama/widgets/price.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:path/path.dart' as path;

class UploadTimeSheet extends StatefulWidget {
  const UploadTimeSheet({Key? key}) : super(key: key);

  @override
  State<UploadTimeSheet> createState() => _UploadTimeSheetState();
}

class _UploadTimeSheetState extends State<UploadTimeSheet> {
  late final ShiftProvider _shiftProvider;
  late final AuthProvider _authProvider;
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  List<MyShift>? _shifts = [];
  bool watchStatus = false; // what is the action type| insert or update
  var selectedFile = null;
  var selectedFileExt = null;
  var shiftkey = null;
  var file;
  @override
  void initState() {
    _shifts = [];
    // TODO: implement initState
    WidgetsBinding.instance?.addPostFrameCallback((timeStamp) {
      _shiftProvider = Provider.of<ShiftProvider>(this.context, listen: false);
      _authProvider = Provider.of<AuthProvider>(this.context, listen: false);

      _getShiftData();
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final auth = Provider.of<AuthProvider>(context);
    final _file = Provider.of<FileProvider>(context);
    if (watchStatus) {
      final fileSelect = context.watch<FileProvider>().isFileSelected;
      if (fileSelect) {
        _updateSelectedFile(_file, context, _scaffoldKey);
        _checkWatchable(_file);
      }
    }

    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        title: Text('Upload TimeSheets'),
      ),
      body: (_shifts!.length > 0)
          ? Container(
              padding: EdgeInsets.all(20),
              child: SingleChildScrollView(
                  child: ListView.builder(
                      physics: ScrollPhysics(),
                      shrinkWrap: true,
                      itemCount: _shifts?.length,
                      itemBuilder: (BuildContext context, int index) {
                        return ListView(
                          shrinkWrap: true,
                          primary: false,
                          children: [
                            Container(
                              padding: EdgeInsets.all(15),
                              decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(25),
                                  boxShadow: [
                                    BoxShadow(
                                        offset: Offset(2.0, 2.0),
                                        blurRadius: 25,
                                        color: Colors.grey.shade200,
                                        spreadRadius: 1),
                                    BoxShadow(
                                        offset: Offset(-2.0, -2.0),
                                        blurRadius: 25,
                                        color: Colors.white10,
                                        spreadRadius: 1),
                                  ]),
                              child: Row(
                                children: [
                                  PriceView(
                                      rates: _shifts!.elementAt(index).rates),
                                  SizedBox(
                                    width: 10,
                                  ),
                                  Container(
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceEvenly,
                                      children: [
                                        Row(
                                          children: [
                                            Icon(Icons.home_sharp),
                                            Text(
                                              '${_shifts!.elementAt(index).home}',
                                              style: TextStyle(
                                                  fontSize: 15,
                                                  fontWeight: FontWeight.bold),
                                            ),
                                          ],
                                        ),
                                        Row(
                                          children: [
                                            Icon(Icons.place_sharp),
                                            Text(
                                                '${_shifts!.elementAt(index).postcode}, ${_shifts!.elementAt(index).address}'),
                                          ],
                                        ),
                                        Row(
                                          children: [
                                            Icon(Icons.calendar_today),
                                            //Text('Thu 2nd, Sep 2021'),
                                            Text(DateFormat.yMMMEd().format(
                                                DateTime.parse(_shifts!
                                                    .elementAt(index)
                                                    .date)))
                                          ],
                                        ),
                                        Row(
                                          children: [
                                            Icon(Icons.timer_sharp),
                                            Text(
                                              '${_shifts!.elementAt(index).start} - ${_shifts!.elementAt(index).end}',
                                            ),
                                          ],
                                        ),
                                        Row(
                                          children: [
                                            Icon(Icons.taxi_alert_sharp),
                                            Text(
                                              '${_shifts!.elementAt(index).pickup}',
                                            ),
                                          ],
                                        ),
                                        Row(
                                          children: [
                                            Icon(Icons.business_sharp),
                                            Text(
                                              '${_shifts!.elementAt(index).agency}',
                                              style: TextStyle(fontSize: 13),
                                            ),
                                          ],
                                        ),
                                        Row(
                                          children: [
                                            SizedBox(
                                              width: 45,
                                            ),
                                            TextButton.icon(
                                                onPressed: () {
                                                  _pickFile(
                                                      _scaffoldKey,
                                                      _file,
                                                      _shifts!
                                                          .elementAt(index)
                                                          .key);
                                                },
                                                icon: Icon(
                                                    Icons.upload_file_sharp,
                                                    color:
                                                        Flavor.secondaryToDark),
                                                label: Text(
                                                  'Upload Timesheet',
                                                  style: TextStyle(
                                                      color: Flavor
                                                          .secondaryToDark),
                                                ))
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(height: 30)
                          ],
                        );
                      })),
            )
          : SizedBox(),
    );
  }

  void _getShiftData() async {
    await _shiftProvider.timesheets(_authProvider.token!);
    if (_shiftProvider.isShiftLoaded) {
      if (mounted) {
        setState(() {
          _shifts = _shiftProvider.myShifts();
        });
      }
    }
  }

  void _pickFile(scaffoldState, FileProvider fileProvider, _shiftKey) async {
    setState(() {
      selectedFile = null;
      shiftkey = _shiftKey;
    });
    await fileProvider.pickFileTrigger(scaffoldState);
    _checkWatchable(fileProvider);
  }

  void _updateSelectedFile(
      FileProvider fileProvider, context, scaffoldKey) async {
    var filepath = await fileProvider.getPath();

    setState(() {
      if (filepath != 'null') {
        selectedFile = filepath;
        selectedFileExt = path.extension(filepath);
        fileProvider.updateSelectStatus(false);
        watchStatus = false;
        _confirmAction(context, scaffoldKey, shiftkey);
      }
    });
  }

  void _checkWatchable(FileProvider fileProvider) {
    setState(() {
      watchStatus = (fileProvider.isWatchable) ? true : false;
    });
  }

  void _confirmAction(context, scaffoldKey, shiftKey) {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('Upload Timesheet'),
            content: ImageSelectorDisplay(
                (selectedFileExt == '.pdf' || selectedFileExt == 'pdf')
                    ? 'assets/images/cama-pdf-placeholder.png'
                    : File(selectedFile),
                true,
                (selectedFileExt == '.pdf' || selectedFileExt == 'pdf')
                    ? true
                    : false),
            actions: [
              TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: Text('Cancel')),
              TextButton(
                  onPressed: () {
                    _submitForm(context, scaffoldKey, shiftKey);
                  },
                  child: Text('Upload')),
            ],
          );
        });
  }

  void _submitForm(context, scaffoldKey, shift_key) async {
    //open watch
    var tk = _authProvider.token;
    Map<String, dynamic> body = {};
    body['visible_key'] = shift_key;
    body['timesheet'] = File(selectedFile);
    await _shiftProvider.timesheetsUpload(body: body, token: tk!);
    if (_shiftProvider.isShiftLoaded) {
      //close watch
      _getShiftData();
      Navigator.pop(context);
      showSnackBar(
          context: scaffoldKey.currentContext,
          message: 'Your timesheet is uploaded');
    } else {
      //close watch
      Navigator.pop(context);
      await showCustomAlert(
          scaffoldState: scaffoldKey,
          title: 'Error',
          message: 'something went wrong try again');
    }
  }
}
