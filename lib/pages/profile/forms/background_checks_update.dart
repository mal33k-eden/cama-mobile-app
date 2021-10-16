import 'package:cama/shared/flavors.dart';
import 'package:cama/shared/form_kits.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';

class BackgroundChecksUpdate extends StatefulWidget {
  BackgroundChecksUpdate({Key? key}) : super(key: key);

  @override
  State<BackgroundChecksUpdate> createState() => _BackgroundChecksUpdateState();
}

class _BackgroundChecksUpdateState extends State<BackgroundChecksUpdate> {
  String selectedDate = DateFormat('yyyy-MM-dd').format(DateTime.now());
  final dateController = TextEditingController();
  bool onUpdateService = false;
  bool haveDeclaration = false;
  bool haveReadDeclaration = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    dateController.text = selectedDate;
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    dateController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Update D.B.S Checks'),
        actions: [
          TextButton(
              onPressed: () {},
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
          child: ListView(
            shrinkWrap: true,
            children: [
              Row(
                children: [
                  Checkbox(
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
                      decoration: textFieldDecorator.copyWith(
                          label:
                              const Text('DBS Certificate Number (optional)'),
                          prefixIcon: Icon(Icons.person_sharp),
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
                      decoration: textFieldDecorator.copyWith(
                        label:
                            const Text('Provide Details Of Your Declaration'),
                        prefixIcon: Icon(Icons.calendar_today_sharp),
                      ),
                      maxLines: null,
                      keyboardType: TextInputType.multiline,
                      validator: (val) => validateTextField(val),
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
                child: Container(
                  //padding: EdgeInsets.all(10),
                  child: ListTile(
                    leading: CircleAvatar(
                      backgroundColor: Colors.white,
                      child: Icon(
                        Icons.description_sharp,
                        color: Flavor.primaryToDark,
                      ),
                    ),
                    title: Text(
                      'pdf,png,jpeg files only',
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 20,
                          fontWeight: FontWeight.bold),
                    ),
                    subtitle: Text(
                      'Click To Add A File',
                      style: TextStyle(
                          color: Colors.white, fontWeight: FontWeight.bold),
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
        selectedDate = DateFormat('yyyy-MM-dd').format(datePicked);
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
}
