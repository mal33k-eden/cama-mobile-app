import 'package:cama/providers/provider_auth.dart';
import 'package:cama/shared/flavors.dart';
import 'package:cama/shared/form_kits.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class UpdateReferee extends StatefulWidget {
  UpdateReferee({Key? key}) : super(key: key);

  @override
  State<UpdateReferee> createState() => _UpdateRefereeState();
}

class _UpdateRefereeState extends State<UpdateReferee> {
  final nameController = TextEditingController();
  final relationshipController = TextEditingController();
  final companyController = TextEditingController();
  final positionController = TextEditingController();
  final emailController = TextEditingController();
  final addressController = TextEditingController();
  final phoneController = TextEditingController();
  final _FormKey = GlobalKey<FormState>();
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  var args;
  bool toCreate = true;
  bool isCharacter = false;
  bool isProfessional = true;
  int updateId = 0;

  @override
  void initState() {
    // TODO: implement initState
    Future.delayed(Duration.zero, () {
      args = ModalRoute.of(context)!.settings.arguments;
      var ref = args!["ref"];
      if (ref != null) {
        setState(() {
          toCreate = false;
          nameController.text = ref['full_name'];
          relationshipController.text = ref['relationship'];
          phoneController.text = ref['telephone'];
          positionController.text = ref['position'];
          addressController.text = ref['address'];
          companyController.text = ref['company'];
          emailController.text = ref['email'];
          updateId = ref['id'];
          toCreate = false;
          isCharacter = (ref['type'] == 'Character') ? true : false;
          isProfessional = (ref['type'] == 'Professional') ? true : false;
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
    relationshipController.dispose();
    companyController.dispose();
    phoneController.dispose();
    positionController.dispose();
    emailController.dispose();
    addressController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final auth = Provider.of<AuthProvider>(context);
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        title: Text((toCreate) ? 'Add Referee' : 'Update Referee'),
        actions: [
          TextButton(
            onPressed: () {
              if (_FormKey.currentState!.validate()) {
                (toCreate)
                    ? _givePermission(_scaffoldKey, auth)
                    : _submitForm(_scaffoldKey, auth);
              }
            },
            child: Center(
              child: Text(
                (toCreate) ? 'Add' : 'Save',
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
                'Select Character Type',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              Row(
                children: [
                  Checkbox(
                    activeColor: Flavor.secondaryToDark,
                    value: isProfessional,
                    onChanged: (value) {
                      setState(() {
                        isProfessional = value!;
                        isCharacter = !isCharacter;
                      });
                    },
                  ),
                  Text('Professional'),
                  SizedBox(
                    width: 20,
                  ),
                  Checkbox(
                    activeColor: Flavor.secondaryToDark,
                    value: isCharacter,
                    onChanged: (value) {
                      setState(() {
                        isCharacter = value!;
                        isProfessional = !isProfessional;
                      });
                    },
                  ),
                  Text('Character')
                ],
              ),
              TextFormField(
                controller: nameController,
                decoration: textFieldDecorator.copyWith(
                    label: const Text('Full Name'),
                    prefixIcon: Icon(Icons.person),
                    hintText: 'e.g John Doe'),
                validator: (val) => validateTextField(val),
                // The validator receives the text that the user has entered.
              ),
              const SizedBox(
                height: 10,
              ),
              TextFormField(
                controller: relationshipController,
                decoration: textFieldDecorator.copyWith(
                    label: const Text('Relationship'),
                    prefixIcon: Icon(Icons.person_add_alt_sharp),
                    hintText: 'whats your relationship with this referee?'),
                validator: (val) => validateTextField(val),
                // The validator receives the text that the user has entered.
              ),
              const SizedBox(
                height: 10,
              ),
              (isProfessional)
                  ? TextFormField(
                      controller: companyController,
                      decoration: textFieldDecorator.copyWith(
                          label: const Text('Company'),
                          prefixIcon: Icon(Icons.business_sharp),
                          hintText: 'Enter referee company'),
                      validator: (val) => validateTextField(val),
                      // The validator receives the text that the user has entered.
                    )
                  : SizedBox(),
              (isProfessional)
                  ? TextFormField(
                      controller: positionController,
                      decoration: textFieldDecorator.copyWith(
                          label: const Text('Position'),
                          prefixIcon: Icon(Icons.badge_sharp),
                          hintText: 'Enter referee position'),
                      validator: (val) => validateTextField(val),
                      // The validator receives the text that the user has entered.
                    )
                  : SizedBox(),
              const SizedBox(
                height: 10,
              ),
              TextFormField(
                controller: emailController,
                decoration: textFieldDecorator.copyWith(
                    label: const Text('Email'),
                    prefixIcon: Icon(Icons.email_sharp),
                    hintText: 'Enter referee email'),
                validator: (val) => validateTextField(val),
                // The validator receives the text that the user has entered.
              ),
              const SizedBox(
                height: 10,
              ),
              TextFormField(
                controller: phoneController,
                decoration: textFieldDecorator.copyWith(
                    label: const Text('Telephone'),
                    prefixIcon: Icon(Icons.phone_android_sharp),
                    hintText: 'Enter referee phone number'),
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
                    prefixIcon: Icon(Icons.location_city),
                    hintText: 'Enter referee address'),
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
    Map<String, dynamic> body = {};
    body['full_name'] = nameController.text;
    body['company'] = companyController.text;
    body['position'] = positionController.text;
    body['address'] = addressController.text;
    body['telephone'] = phoneController.text;
    body['email'] = emailController.text;
    body['relationship'] = relationshipController.text;
    body['type'] = (isProfessional) ? 'Professional' : 'Character';
    body['permission'] = true;
    body['action'] = 'insert';
    if (!toCreate) {
      body['id'] = updateId;
      body['action'] = 'update';
    }
    await auth.updateReference(body: body, token: auth.token);
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

  void _givePermission(scaffoldState, auth) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Permission'),
        scrollable: true,
        content: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
                'By clicking the continue button you give permission to your agencies to contact this referee.'),
          ],
        ),
        actions: [
          TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: Text(
                'Cancel',
                style: TextStyle(color: Colors.red),
              )),
          TextButton(
              onPressed: () {
                Navigator.pop(context);
                _submitForm(scaffoldState, auth);
              },
              child: Text('Continue'))
        ],
      ),
    );
  }
}
