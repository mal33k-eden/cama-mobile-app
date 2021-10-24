import 'dart:io';
import 'package:cama/providers/provider_auth.dart';
import 'package:cama/shared/avart_icon.dart';
import 'package:cama/shared/flavors.dart';
import 'package:cama/shared/form_kits.dart';
import 'package:cama/shared/imageviewer.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:path/path.dart' as path;

class BackgroundChecksUpdate extends StatefulWidget {
  BackgroundChecksUpdate({Key? key}) : super(key: key);

  @override
  State<BackgroundChecksUpdate> createState() => _BackgroundChecksUpdateState();
}

class _BackgroundChecksUpdateState extends State<BackgroundChecksUpdate> {
  String selectedDate = DateFormat('dd-MM-yyyy').format(DateTime.now());
  final dateController = TextEditingController();
  final updateServiceController = TextEditingController();
  final declarationController = TextEditingController();
  bool onUpdateService = false;
  bool haveDeclaration = false;
  bool haveReadDeclaration = false;
  bool isLocal = true;
  var args;

  final _FormKey = GlobalKey<FormState>();
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  var dbsFile = null;
  @override
  void initState() {
    // TODO: implement initState
    Future.delayed(Duration.zero, () {
      args = ModalRoute.of(context)!.settings.arguments;
      var dbs = args!["dbs"];
      dateController.text = selectedDate;
      if (dbs != null) {
        setState(() {
          (dbs['update_service'] == 'Yes')
              ? onUpdateService = true
              : onUpdateService = false;
          (dbs['update_service'] == 'Yes')
              ? updateServiceController.text = dbs['update_service_id']
              : onUpdateService = false;
          dateController.text = DateFormat('dd-MM-yyyy')
              .format(DateTime.parse(dbs['expires_on']));
          haveReadDeclaration = true;
          (dbs['declaration'] == 'Yes')
              ? haveDeclaration = true
              : haveDeclaration = false;
          (dbs['declaration'] == 'Yes')
              ? declarationController.text = dbs['declaration_details']
              : haveDeclaration = false;
          dbsFile = dbs['certificate'];
          isLocal = false;
        });
      }
    });
    super.initState();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    dateController.dispose();
    updateServiceController.dispose();
    declarationController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final auth = Provider.of<AuthProvider>(context);

    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        title: Text('Update D.B.S Checks'),
        actions: [
          TextButton(
              onPressed: () {
                if (_FormKey.currentState!.validate()) {
                  _submitDBForm(_scaffoldKey, auth);
                }
              },
              child: Center(
                  child: Text(
                'Done',
                style: TextStyle(color: Colors.white),
              )))
        ],
      ),
      body: Container(
        padding: EdgeInsets.symmetric(horizontal: 30, vertical: 10),
        child: Form(
          key: _FormKey,
          child: ListView(
            shrinkWrap: true,
            children: [
              Row(
                children: [
                  Checkbox(
                    activeColor: Flavor.secondaryToDark,
                    value: onUpdateService,
                    onChanged: (value) {
                      setState(() {
                        onUpdateService = value!;
                      });
                    },
                  ),
                  Text('Registered with DBS Update Service?')
                ],
              ),
              (onUpdateService)
                  ? //Checkbox
                  TextFormField(
                      controller: updateServiceController,
                      decoration: textFieldDecorator.copyWith(
                          label:
                              const Text('DBS Certificate Number (optional)'),
                          prefixIcon: Icon(Icons.badge_sharp),
                          hintText: 'e.g PKI9086YQ21'),
                      validator: (val) => validateTextField(val),
                      // The validator receives the text that the user has entered.
                    )
                  : const SizedBox(
                      height: 5,
                    ),
              const SizedBox(
                height: 5,
              ),
              TextFormField(
                showCursor: false,
                decoration: textFieldDecorator.copyWith(
                  label: const Text('Expires On'),
                  prefixIcon: Icon(Icons.calendar_today_sharp),
                ),
                readOnly: true,
                controller: dateController,
                validator: (val) => validateTextField(val),
                onTap: () {
                  _showDateModal(context);
                },
                // The validator receives the text that the user has entered.
              ),
              const SizedBox(
                height: 15,
              ),
              Text(
                "Please read the Criminal Declaration",
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 18, color: Flavor.primaryToDark),
              ),
              Divider(),
              const SizedBox(
                height: 10,
              ),
              Row(
                children: [
                  Checkbox(
                    activeColor: Flavor.secondaryToDark,
                    value: haveReadDeclaration,
                    onChanged: (value) {
                      setState(() {
                        haveReadDeclaration = value!;
                      });
                    },
                  ),
                  InkWell(
                    child: Text(
                      "Yes, I have read the declaration",
                      style: TextStyle(color: Flavor.primaryToDark),
                    ),
                    onTap: () {
                      _showDeclaration(context);
                    },
                  ),
                ],
              ),
              const SizedBox(
                height: 10,
              ),
              Text(
                "Answer YES to any of the questions?",
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 15, color: Flavor.primaryToDark),
              ),
              const SizedBox(
                height: 5,
              ),
              (haveReadDeclaration)
                  ? Row(
                      children: [
                        Checkbox(
                          activeColor: Flavor.secondaryToDark,
                          value: haveDeclaration,
                          onChanged: (value) {
                            setState(() {
                              haveDeclaration = value!;
                            });
                          },
                        ),
                        Text("Yes, I Have"),
                      ],
                    )
                  : const SizedBox(
                      height: 5,
                    ),
              (haveDeclaration)
                  ? TextFormField(
                      controller: declarationController,
                      decoration: textFieldDecorator.copyWith(
                        label:
                            const Text('Provide Details Of Your Declaration'),
                        prefixIcon: Icon(Icons.note_add_sharp),
                      ),
                      maxLines: null,
                      keyboardType: TextInputType.multiline,
                      //validator: (val) => validateTextField(val),
                      // The validator receives the text that the user has entered.
                    )
                  : const SizedBox(
                      height: 5,
                    ),
              const SizedBox(
                height: 10,
              ),
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  children: [
                    if (dbsFile != null)
                      Center(
                        //padding: EdgeInsets.all(10),
                        child: Stack(
                          children: [
                            InkWell(
                              child: ImageSelectorDisplay(
                                  (path.extension(dbsFile) == '.pdf')
                                      ? 'assets/images/cama-pdf-placeholder.png'
                                      : File(dbsFile),
                                  isLocal,
                                  (path.extension(dbsFile) == '.pdf')
                                      ? true
                                      : false),
                              onTap: () {
                                showDialog(
                                    context: context,
                                    builder: (_) => ImageViewerPop(
                                          path: (path.extension(dbsFile) ==
                                                  '.pdf')
                                              ? 'assets/images/cama-pdf-placeholder.png'
                                              : File(dbsFile),
                                          isLocal: isLocal,
                                          isAsset: (path.extension(dbsFile) ==
                                                  '.pdf')
                                              ? true
                                              : false,
                                        ));
                              },
                            ),
                            (isLocal)
                                ? Positioned(
                                    child: InkWell(
                                      child: removeImageIcon(),
                                      onTap: () {
                                        setState(() {
                                          dbsFile = null;
                                        });
                                      },
                                    ),
                                    top: 0,
                                    right: 2,
                                  )
                                : SizedBox(),
                          ],
                        ),
                      )
                    else
                      SizedBox(),
                    SizedBox(
                      height: 20,
                    ),
                    Container(
                      //padding: EdgeInsets.all(10),
                      child: InkWell(
                        child: ListTile(
                          leading: CircleAvatar(
                            backgroundColor: Colors.white,
                            child: Icon(
                              Icons.image_sharp,
                              color: Flavor.primaryToDark,
                            ),
                          ),
                          title: Text(
                            'Image files only',
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 20,
                                fontWeight: FontWeight.bold),
                          ),
                          subtitle: Text(
                            'Click To Add A File',
                            style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                        onTap: () {
                          // _uploadImage(ImageSource.gallery);
                        },
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
                  ],
                ),
              ),
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
      firstDate: DateTime(1999),
      lastDate: DateTime(3000),
    );

    if (datePicked != null && datePicked != selectedDate) {
      setState(() {
        selectedDate = DateFormat('dd-MM-yyyy').format(datePicked);
        dateController.text = selectedDate;
      });
    }
  }

  void _showDeclaration(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        scrollable: true,
        title: Text(
          "Declaration of Criminal Convictions",
          textAlign: TextAlign.center,
          style: TextStyle(color: Flavor.primaryToDark),
        ),
        content: Column(
          children: [
            Text(
                "You will be working with vulnerable persons in the post that you have applied for. Consequently, you are required to disclose details of your criminal record. Under the Rehabilitation of Offenders Act 1974 (Exemptions) order, you cannot withhold information about convictions which may, for other purpose, be regarded as 'spent'."),
            const SizedBox(
              height: 10,
            ),
            Text("Please answer the following question:"),
            const SizedBox(
              height: 5,
            ),
            Text("1) Have you ever been convicted of a criminal offence?"),
            const SizedBox(
              height: 5,
            ),
            Text("2) Have you the recipient of a police caution?"),
            const SizedBox(
              height: 5,
            ),
            Text(
                "3) Have you been the subject of a conditional discharge of probation order?"),
            const SizedBox(
              height: 5,
            ),
          ],
        ),
      ),
    );
  }

  void _submitDBForm(scaffoldState, auth) async {
    Map<String, dynamic> body = {};
    body['update_service'] = (onUpdateService) ? 'Yes' : 'No';
    body['update_service_id'] = updateServiceController.text;
    body['expires_on'] = dateController.text;
    body['declaration'] = (haveDeclaration) ? 'Yes' : 'No';
    body['declaration_details'] = declarationController.text;
    body['certificate'] = dbsFile;
    //validate DBSFILE = MUST NOT BE NULL
    if (dbsFile == null) {
      //display error
      showCustomAlert(
          scaffoldState: scaffoldState,
          title: 'Error',
          message:
              'You need to add an image of your DBS to this form before submitting');
    } else {
      await auth.updateUserDBS(body: body, token: auth.token);
      if (auth.isProfileUpdate) {
        showSnackBar(context: context, message: 'Profile updated');
        Navigator.pop(context);
      } else {
        await showCustomAlert(
            scaffoldState: scaffoldState,
            title: 'Error',
            message: 'something went wrong try again');
        Navigator.pop(context);
      }
    }
  }

  Future _uploadImage(ImageSource source, scaffoldState) async {
    print(dbsFile);
    try {
      XFile? image = await ImagePicker().pickImage(source: source);
      if (image == null) return;
      setState(() {
        dbsFile = File(image.path);
        isLocal = true;
      });

      print(dbsFile);
    } on PlatformException catch (e) {
      await showCustomAlert(
          scaffoldState: scaffoldState,
          title: 'File Permission Error',
          message:
              'you will need to give the app permission to your camera and gallery in other to upoad images.');
    }
  }
}
