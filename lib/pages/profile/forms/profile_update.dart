import 'package:cama/shared/form_kits.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class UpdateProfileDetails extends StatefulWidget {
  UpdateProfileDetails({Key? key}) : super(key: key);

  @override
  State<UpdateProfileDetails> createState() => _UpdateProfileDetailsState();
}

class _UpdateProfileDetailsState extends State<UpdateProfileDetails> {
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
        title: Text('Update Profile'),
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
                    label: const Text('First Name'),
                    prefixIcon: Icon(Icons.person_sharp),
                    hintText: 'e.g John'),
                validator: (val) => validateTextField(val),
                // The validator receives the text that the user has entered.
              ),
              const SizedBox(
                height: 10,
              ),
              TextFormField(
                decoration: textFieldDecorator.copyWith(
                    label: const Text('Last Name'),
                    prefixIcon: Icon(Icons.person_sharp),
                    hintText: 'e.g Doe'),
                validator: (val) => validateTextField(val),
                // The validator receives the text that the user has entered.
              ),
              const SizedBox(
                height: 10,
              ),
              TextFormField(
                showCursor: false,
                decoration: textFieldDecorator.copyWith(
                  label: const Text('Date Of Birth'),
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
                    label: const Text('Highest Qualification'),
                    prefixIcon: Icon(Icons.badge_sharp),
                    hintText: 'e.g Bachelors of Science'),
                validator: (val) => validateTextField(val),
                // The validator receives the text that the user has entered.
              ),
              const SizedBox(
                height: 10,
              ),
              TextFormField(
                decoration: textFieldDecorator.copyWith(
                    label: const Text('Nationality'),
                    prefixIcon: Icon(Icons.public),
                    hintText: 'e.g British'),
                validator: (val) => validateTextField(val),
                // The validator receives the text that the user has entered.
              ),
              const SizedBox(
                height: 10,
              ),
              TextFormField(
                decoration: textFieldDecorator.copyWith(
                    label: const Text('Postcode'),
                    prefixIcon: Icon(Icons.place_sharp),
                    hintText: 'e.g TS1 4PE'),
                validator: (val) => validateTextField(val),
                // The validator receives the text that the user has entered.
              ),
              const SizedBox(
                height: 10,
              ),
              TextFormField(
                decoration: textFieldDecorator.copyWith(
                    label: const Text('Address'),
                    prefixIcon: Icon(Icons.person_pin_sharp),
                    hintText: 'e.g 136 Ayresome Street'),
                validator: (val) => validateTextField(val),
                // The validator receives the text that the user has entered.
              ),
              const SizedBox(
                height: 10,
              ),
              TextFormField(
                decoration: textFieldDecorator.copyWith(
                    label: const Text('Town'),
                    prefixIcon: Icon(Icons.map_sharp),
                    hintText: 'e.g Middlesbrough'),
                validator: (val) => validateTextField(val),
                // The validator receives the text that the user has entered.
              ),
              const SizedBox(
                height: 10,
              ),
              TextFormField(
                decoration: textFieldDecorator.copyWith(
                    label: const Text('Region'),
                    prefixIcon: Icon(Icons.satellite_sharp),
                    hintText: 'e.g John'),
                validator: (val) => validateTextField(val),
                // The validator receives the text that the user has entered.
              ),
              const SizedBox(
                height: 10,
              ),
              TextFormField(
                keyboardType: TextInputType.emailAddress,
                decoration: textFieldDecorator.copyWith(
                    label: const Text('E-mail'),
                    prefixIcon: Icon(Icons.mail_sharp),
                    hintText: 'e.g John'),
                validator: (val) => validateTextField(val),
                // The validator receives the text that the user has entered.
              ),
              const SizedBox(
                height: 10,
              ),
              TextFormField(
                keyboardType: TextInputType.phone,
                decoration: textFieldDecorator.copyWith(
                    label: const Text('Mobile'),
                    prefixIcon: Icon(Icons.phone_android_sharp),
                    hintText: 'e.g 07786982012'),
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
