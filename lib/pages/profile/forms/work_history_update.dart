import 'package:cama/shared/form_kits.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class UpdateWorkHistory extends StatefulWidget {
  UpdateWorkHistory({Key? key}) : super(key: key);

  @override
  State<UpdateWorkHistory> createState() => _UpdateWorkHistoryState();
}

class _UpdateWorkHistoryState extends State<UpdateWorkHistory> {
  String selectedDate = DateFormat('yyyy-MM-dd').format(DateTime.now());
  final dateController = TextEditingController();

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
        title: Text('Update Work History'),
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
              TextFormField(
                decoration: textFieldDecorator.copyWith(
                    label: const Text('Employer'),
                    prefixIcon: Icon(Icons.business_center_sharp),
                    hintText: 'e.g John'),
                validator: (val) => validateTextField(val),
                // The validator receives the text that the user has entered.
              ),
              const SizedBox(
                height: 10,
              ),
              TextFormField(
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
                controller: dateController,
                validator: (val) => validateTextField(val),
                onTap: () {
                  _showDateModal(context);
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
                controller: dateController,
                validator: (val) => validateTextField(val),
                onTap: () {
                  _showDateModal(context);
                },
                // The validator receives the text that the user has entered.
              ),
              const SizedBox(
                height: 10,
              ),
              TextFormField(
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
}
