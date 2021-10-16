import 'package:cama/shared/form_kits.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class UpdateReferee extends StatefulWidget {
  UpdateReferee({Key? key}) : super(key: key);

  @override
  State<UpdateReferee> createState() => _UpdateRefereeState();
}

class _UpdateRefereeState extends State<UpdateReferee> {
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
        title: Text('Update Referee'),
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
                    label: const Text('Full Name'),
                    prefixIcon: Icon(Icons.business_center_sharp),
                    hintText: 'e.g John Doe'),
                validator: (val) => validateTextField(val),
                // The validator receives the text that the user has entered.
              ),
              const SizedBox(
                height: 10,
              ),
              TextFormField(
                decoration: textFieldDecorator.copyWith(
                    label: const Text('Company'),
                    prefixIcon: Icon(Icons.badge_sharp),
                    hintText: 'e.g Nurse'),
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
                decoration: textFieldDecorator.copyWith(
                    label: const Text('Email'),
                    prefixIcon: Icon(Icons.badge_sharp),
                    hintText: 'e.g Nurse'),
                validator: (val) => validateTextField(val),
                // The validator receives the text that the user has entered.
              ),
              const SizedBox(
                height: 10,
              ),
              TextFormField(
                decoration: textFieldDecorator.copyWith(
                    label: const Text('Telephone'),
                    prefixIcon: Icon(Icons.badge_sharp),
                    hintText: 'e.g Nurse'),
                validator: (val) => validateTextField(val),
                // The validator receives the text that the user has entered.
              ),
              const SizedBox(
                height: 10,
              ),
              TextFormField(
                decoration: textFieldDecorator.copyWith(
                    label: const Text('Address'),
                    prefixIcon: Icon(Icons.badge_sharp),
                    hintText: 'e.g Nurse'),
                validator: (val) => validateTextField(val),
                // The validator receives the text that the user has entered.
              ),
              const SizedBox(
                height: 10,
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
}
