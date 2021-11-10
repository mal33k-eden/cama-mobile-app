import 'package:cama/models/user.dart';
import 'package:cama/providers/provider_auth.dart';
import 'package:cama/shared/form_kits.dart';
import 'package:flutter/material.dart';
import 'package:flutter_overlay_loader/flutter_overlay_loader.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class UpdateProfileDetails extends StatefulWidget {
  UpdateProfileDetails({Key? key}) : super(key: key);

  @override
  State<UpdateProfileDetails> createState() => _UpdateProfileDetailsState();
}

class _UpdateProfileDetailsState extends State<UpdateProfileDetails> {
  User? user;
  String selectedDate = DateFormat('dd-MM-yyyy').format(DateTime.now());
  late String initialDOB;
  final _FormKey = GlobalKey<FormState>();
  Map<String, dynamic> body = {};
  final dateController = TextEditingController();
  final fnameController = TextEditingController();
  final lnameController = TextEditingController();
  final hqController = TextEditingController();
  final nationalityController = TextEditingController();
  final postcodeController = TextEditingController();
  final addressController = TextEditingController();
  final regionController = TextEditingController();
  final townController = TextEditingController();
  final emailController = TextEditingController();
  final mobileController = TextEditingController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    WidgetsBinding.instance?.addPostFrameCallback((timeStamp) {
      User? _user = Provider.of<AuthProvider>(context, listen: false).getUser();
      dateController.text = _user!.date_of_birth;
      fnameController.text = _user.first_name;
      lnameController.text = _user.last_name;
      hqController.text = _user.highest_qualification;
      nationalityController.text = _user.nationality;
      postcodeController.text = _user.postcode;
      addressController.text = _user.address;
      townController.text = _user.town;
      regionController.text = _user.region;
      emailController.text = _user.email;
      mobileController.text = _user.mobile;
    });
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    dateController.dispose();
    Loader.hide();
  }

  @override
  Widget build(BuildContext context) {
    final auth = Provider.of<AuthProvider>(context);
    final user = auth.getUser();

    return Scaffold(
      appBar: AppBar(
        title: Text('Update Profile'),
        actions: [
          TextButton(
              onPressed: () {
                if (_FormKey.currentState!.validate()) {
                  _updateProfile(auth.token, auth);
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
              TextFormField(
                decoration: textFieldDecorator.copyWith(
                    label: const Text('First Name'),
                    prefixIcon: Icon(Icons.person_sharp),
                    hintText: 'e.g John'),
                validator: (val) => validateTextField(val),
                controller: fnameController,
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
                controller: lnameController,
              ),
              const SizedBox(
                height: 10,
              ),
              TextFormField(
                controller: dateController,
                showCursor: false,
                decoration: textFieldDecorator.copyWith(
                  label: const Text('Date Of Birth'),
                  prefixIcon: Icon(Icons.calendar_today_sharp),
                ),
                readOnly: true,
                validator: (val) => validateTextField(val),
                onTap: () {
                  _showDateModal(context);
                },
              ),
              const SizedBox(
                height: 10,
              ),
              TextFormField(
                validator: (val) => validateTextField(val),
                decoration: textFieldDecorator.copyWith(
                    label: const Text('Highest Qualification'),
                    prefixIcon: Icon(Icons.badge_sharp),
                    hintText: 'e.g Bachelors of Science'),
                controller: hqController,
              ),
              const SizedBox(
                height: 10,
              ),
              TextFormField(
                validator: (val) => validateTextField(val),
                decoration: textFieldDecorator.copyWith(
                    label: const Text('Nationality'),
                    prefixIcon: Icon(Icons.public),
                    hintText: 'e.g British'),
                controller: nationalityController,
              ),
              const SizedBox(
                height: 10,
              ),
              TextFormField(
                controller: postcodeController,
                decoration: textFieldDecorator.copyWith(
                    label: const Text('Postcode'),
                    prefixIcon: Icon(Icons.place_sharp),
                    hintText: 'e.g TS1 4PE'),
                validator: (val) => validateTextField(val),
              ),
              const SizedBox(
                height: 10,
              ),
              TextFormField(
                controller: addressController,
                decoration: textFieldDecorator.copyWith(
                    label: const Text('Address'),
                    prefixIcon: Icon(Icons.person_pin_sharp),
                    hintText: 'e.g 136 Ayresome Street'),
                validator: (val) => validateTextField(val),
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
                controller: townController,
              ),
              const SizedBox(
                height: 10,
              ),
              TextFormField(
                controller: regionController,
                decoration: textFieldDecorator.copyWith(
                    label: const Text('Region'),
                    prefixIcon: Icon(Icons.satellite_sharp),
                    hintText: 'e.g John'),
              ),
              const SizedBox(
                height: 10,
              ),
              TextFormField(
                controller: emailController,
                keyboardType: TextInputType.emailAddress,
                decoration: textFieldDecorator.copyWith(
                    label: const Text('E-mail'),
                    prefixIcon: Icon(Icons.mail_sharp),
                    hintText: 'e.g John.d@example.com'),
                validator: (val) => validateTextField(val),
                // The validator receives the text that the user has entered.
              ),
              const SizedBox(
                height: 10,
              ),
              TextFormField(
                controller: mobileController,
                keyboardType: TextInputType.phone,
                decoration: textFieldDecorator.copyWith(
                    label: const Text('Mobile'),
                    prefixIcon: Icon(Icons.phone_android_sharp),
                    hintText: 'e.g 07786982012'),
                validator: (val) => validateTextField(val),
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
        dateController.text = DateFormat('dd-MM-yyyy').format(datePicked);
      });
    }
  }

  void _updateProfile(token, auth) async {
    showCustomActivityAlert(context: context);
    body['first_name'] = fnameController.text;
    body['last_name'] = lnameController.text;
    body['date_of_birth'] = dateController.text;
    body['highest_qualification'] = hqController.text;
    body['nationality'] = nationalityController.text;
    body['postcode'] = postcodeController.text;
    body['address'] = addressController.text;
    body['town'] = townController.text;
    body['region'] = regionController.text;
    body['email'] = emailController.text;
    body['mobile'] = mobileController.text;

    await auth.updateUser(body: body, token: token);
    Loader.hide();
    bool res = auth.isProfileUpdate;
    if (res) {
      Navigator.pushReplacementNamed(context, 'profile-details');
    } else {
      showSnackBar(
          context: context, message: 'unable to update profile. Try again');
    }
  }
}
