import 'package:cama/providers/provider_auth.dart';
import 'package:cama/shared/form_kits.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class UpdateWorkHistory extends StatefulWidget {
  UpdateWorkHistory({Key? key}) : super(key: key);

  @override
  State<UpdateWorkHistory> createState() => _UpdateWorkHistoryState();
}

class _UpdateWorkHistoryState extends State<UpdateWorkHistory> {
  String selectedStartDate = DateFormat('dd-MM-yyyy').format(DateTime.now());
  final startDateController = TextEditingController();
  final endDateController = TextEditingController();
  final employerController = TextEditingController();
  final positionController = TextEditingController();
  final reasonController = TextEditingController();
  final _FormKey = GlobalKey<FormState>();
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  var args;
  bool toCreate = true;
  int updateId = 0;

  @override
  void initState() {
    // TODO: implement initState

    Future.delayed(Duration.zero, () {
      args = ModalRoute.of(context)!.settings.arguments;
      var wh = args!["wh"];
      if (wh != null) {
        setState(() {
          toCreate = false;
          startDateController.text = wh['start_date'];
          endDateController.text =
              (wh['end_date'] == 'Till date') ? '' : wh['end_date'];
          employerController.text = wh['employer'];
          positionController.text = wh['title'];
          reasonController.text = wh['leave_reason'];
          updateId = wh['id'];
        });
      }
    });
    startDateController.text = selectedStartDate;
    super.initState();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    startDateController.dispose();
    endDateController.dispose();
    employerController.dispose();
    positionController.dispose();
    reasonController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final auth = Provider.of<AuthProvider>(context);
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        title: Text((toCreate) ? 'Add Work History' : 'Update Work History'),
        actions: [
          TextButton(
            onPressed: () {
              _addWorkHistory(_scaffoldKey, auth);
            },
            child: Center(
              child: Text(
                (toCreate) ? 'Add' : 'Save',
                style: TextStyle(color: Colors.white),
              ),
            ),
          ),
        ],
      ),
      body: Container(
        padding: EdgeInsets.symmetric(horizontal: 30, vertical: 10),
        child: Form(
          key: _FormKey,
          child: ListView(
            shrinkWrap: true,
            children: [
              TextFormField(
                controller: employerController,
                decoration: textFieldDecorator.copyWith(
                    label: const Text('Employer'),
                    prefixIcon: Icon(Icons.business_center_sharp),
                    hintText: 'enter your employer'),
                validator: (val) => validateTextField(val),
                // The validator receives the text that the user has entered.
              ),
              const SizedBox(
                height: 10,
              ),
              TextFormField(
                controller: positionController,
                decoration: textFieldDecorator.copyWith(
                    label: const Text('Position'),
                    prefixIcon: Icon(Icons.badge_sharp),
                    hintText: 'e.g Nurse'),
                validator: (val) => validateTextField(val),
                // The validator receives the text that the user has entered.
              ),
              const SizedBox(
                height: 10,
              ),
              TextFormField(
                showCursor: false,
                decoration: textFieldDecorator.copyWith(
                  label: const Text('Start Date'),
                  prefixIcon: Icon(Icons.calendar_today_sharp),
                ),
                readOnly: true,
                controller: startDateController,
                validator: (val) => validateTextField(val),
                onTap: () {
                  _showDateModal(context, 'start');
                },
                // The validator receives the text that the user has entered.
              ),
              const SizedBox(
                height: 10,
              ),
              TextFormField(
                showCursor: false,
                decoration: textFieldDecorator.copyWith(
                  label: const Text('End Date'),
                  prefixIcon: Icon(Icons.calendar_today_sharp),
                ),
                readOnly: true,
                controller: endDateController,
                validator: (val) => validateTextField(val),
                onTap: () {
                  _showDateModal(context, 'end');
                },
                // The validator receives the text that the user has entered.
              ),
              const SizedBox(
                height: 10,
              ),
              TextFormField(
                controller: reasonController,
                decoration: textFieldDecorator.copyWith(
                  label: const Text('Reason For Leaving'),
                  prefixIcon: Icon(Icons.note_add_sharp),
                ),
                maxLines: null,
                keyboardType: TextInputType.multiline,
                validator: (val) => validateTextField(val),
                // The validator receives the text that the user has entered.
              )
            ],
          ),
        ),
      ),
    );
  }

  void _showDateModal(BuildContext context, _type) async {
    final DateTime? datePicked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(1999),
      lastDate: DateTime(3000),
    );

    if (datePicked != null && datePicked != selectedStartDate) {
      setState(() {
        selectedStartDate = DateFormat('dd-MM-yyyy').format(datePicked);
        if (_type == 'start') {
          startDateController.text = selectedStartDate;
        } else {
          endDateController.text = selectedStartDate;
        }
      });
    }
  }

  void _addWorkHistory(scaffoldState, auth) async {
    Map<String, dynamic> body = {};
    body['employer'] = employerController.text;
    body['title'] = positionController.text;
    body['start_date'] = startDateController.text;
    body['end_date'] = endDateController.text;
    body['leave_reason'] = reasonController.text;
    body['action'] = 'insert';
    if (!toCreate) {
      body['id'] = updateId;
      body['action'] = 'update';
    }
    await auth.updateWorkHistory(body: body, token: auth.token);
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
