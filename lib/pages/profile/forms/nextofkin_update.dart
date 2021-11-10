import 'package:cama/providers/provider_auth.dart';
import 'package:cama/shared/avart_icon.dart';
import 'package:cama/shared/form_kits.dart';
import 'package:flutter/material.dart';
import 'package:flutter_overlay_loader/flutter_overlay_loader.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class UpdateNextOfKin extends StatefulWidget {
  UpdateNextOfKin({Key? key}) : super(key: key);

  @override
  State<UpdateNextOfKin> createState() => _UpdateNextOfKinState();
}

class _UpdateNextOfKinState extends State<UpdateNextOfKin> {
  final _FormKey = GlobalKey<FormState>();
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  final nameController = TextEditingController();
  final postcodeController = TextEditingController();
  final addressController = TextEditingController();
  final emailController = TextEditingController();
  final mobileController = TextEditingController();
  final phoneController = TextEditingController();
  bool isCreate = true;
  int updateId = 0;
  var args;

  @override
  void initState() {
    // TODO: implement initState
    Future.delayed(Duration.zero, () {
      args = ModalRoute.of(context)!.settings.arguments;
      var nok = args!["nok"];

      if (nok != null) {
        setState(() {
          nameController.text = nok['full_name'];
          postcodeController.text = nok['postcode'];
          mobileController.text = nok['home_telephone'];
          phoneController.text = nok['office_telephone'];
          addressController.text = nok['address'];
          emailController.text = nok['email'];
          isCreate = false;
          updateId = nok['id'];
        });
      }
    });
    super.initState();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    nameController.dispose();
    postcodeController.dispose();
    addressController.dispose();
    emailController.dispose();
    mobileController.dispose();
    phoneController.dispose();
    Loader.hide();
  }

  @override
  Widget build(BuildContext context) {
    final auth = Provider.of<AuthProvider>(context);
    final isLoading = context.watch<AuthProvider>().loading;
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        title: Text((isCreate) ? 'Add Next Of Kin' : 'Update Next Of Kin'),
        actions: [
          TextButton(
            onPressed: () {
              if (_FormKey.currentState!.validate()) {
                _submitForm(_scaffoldKey, auth);
              }
            },
            child: Center(
                child: Text(
              (isCreate) ? 'Add ' : 'Save',
              style: TextStyle(color: Colors.white),
            )),
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
                controller: nameController,
                decoration: textFieldDecorator.copyWith(
                    label: const Text('Full Name'),
                    prefixIcon: Icon(Icons.person_sharp),
                    hintText: 'e.g John'),
                validator: (val) => validateTextField(val),
                // The validator receives the text that the user has entered.
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
                // The validator receives the text that the user has entered.
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
                // The validator receives the text that the user has entered.
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
                    hintText: 'e.g John'),
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
                // The validator receives the text that the user has entered.
              ),
              const SizedBox(
                height: 10,
              ),
              TextFormField(
                controller: phoneController,
                keyboardType: TextInputType.phone,
                decoration: textFieldDecorator.copyWith(
                    label: const Text('Phone'),
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

  Future<void> _submitForm(scaffoldState, auth) async {
    showCustomActivityAlert(context: context);
    Map<String, dynamic> body = {};
    body['full_name'] = nameController.text;
    body['address'] = addressController.text;
    body['postcode'] = postcodeController.text;
    body['home_telephone'] = mobileController.text;
    body['office_telephone'] = phoneController.text;
    body['email'] = emailController.text;
    body['action'] = 'insert';
    if (!isCreate) {
      body['id'] = updateId;
      body['action'] = 'update';
    }
    //validate DBSFILE = MUST NOT BE NULL
    await auth.updateNextOfKin(body: body, token: auth.token);
    Loader.hide();
    if (auth.isProfileUpdate) {
      showSnackBar(context: context, message: 'Profile updated');
      Navigator.pop(context);
    } else {
      await showCustomAlert(
          title: 'Error',
          message: 'something went wrong try again',
          scaffoldState: scaffoldState);
      Navigator.pop(context);
    }
  }
}
