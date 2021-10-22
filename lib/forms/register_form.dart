import 'package:cama/api/auth.dart';
import 'package:cama/pages/auth/staffcategory.dart';
import 'package:cama/providers/provider_auth.dart';
import 'package:cama/shared/flavors.dart';
import 'package:cama/shared/form_kits.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class RegisterForm extends StatefulWidget {
  const RegisterForm({Key? key}) : super(key: key);

  @override
  _RegisterFormState createState() => _RegisterFormState();
}

class _RegisterFormState extends State<RegisterForm> {
  // final AuthService _authService = AuthService();
  late AuthProvider _auth;
  final _registerFormKey = GlobalKey<FormState>();
  final firstNameController = TextEditingController();
  final lastNameController = TextEditingController();
  final emailController = TextEditingController();
  final mobileController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmPasswordController = TextEditingController();
  String _selectedField = 'Click Select Your Field';
  int _selectedIndex = 0;
  bool _policy = false;

  // Pass this method to the child page.
  void _updateField(String selectedField, int index) {
    setState(() {
      _selectedField = selectedField;
      _selectedIndex = index;
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  void dispose() {
    // Clean up the controller when the widget is removed from the
    // widget tree.
    firstNameController.dispose();
    emailController.dispose();
    lastNameController.dispose();
    mobileController.dispose();
    passwordController.dispose();
    confirmPasswordController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    _auth = Provider.of<AuthProvider>(context);
    return Form(
      key: _registerFormKey,
      child: ListView(
        primary: false,
        shrinkWrap: true,
        children: [
          InkWell(
            onTap: () {
              showStaffCategory();
            },
            child: Card(
              color: _selectedIndex == 0
                  ? Flavor.secondaryToDark
                  : Flavor.primaryToDark,
              margin: EdgeInsets.all(20),
              child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Icon(
                      Icons.local_hospital_sharp,
                      color: _selectedIndex == 0 ? Colors.black : Colors.white,
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    Text(
                      _selectedField,
                      style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
                        color:
                            _selectedIndex == 0 ? Colors.black : Colors.white,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          TextFormField(
            decoration: textFieldDecorator.copyWith(
                label: const Text('First Name'),
                prefixIcon: Icon(Icons.person_sharp),
                hintText: 'e.g John'),
            validator: (val) => validateTextField(val),
            controller: firstNameController,
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
            controller: lastNameController,
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
                hintText: 'e.g johndoe@example.com'),
            validator: (input) =>
                input!.isValidEmail() ? null : "enter a valid email",
            controller: emailController,
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
            controller: mobileController,
            // The validator receives the text that the user has entered.
          ),
          const SizedBox(
            height: 10,
          ),
          TextFormField(
            decoration: textFieldDecorator.copyWith(
                label: const Text('Password'),
                prefixIcon: Icon(Icons.lock_sharp),
                hintText: 'Enter your password'),
            obscureText: true,
            validator: (val) => validatePasswordField(val),
            controller: passwordController,
          ),
          const SizedBox(
            height: 10,
          ),
          TextFormField(
            decoration: textFieldDecorator.copyWith(
                label: const Text('Re-Password'),
                prefixIcon: Icon(Icons.lock_sharp),
                hintText: 'Re-type your password'),
            obscureText: true,
            validator: (val) =>
                validateRePasswordField(val, passwordController),
            controller: confirmPasswordController,
          ),
          Row(
            children: [
              Checkbox(
                value: _policy,
                checkColor: Flavor.primaryToDark,
                activeColor: Flavor.secondaryToDark,
                onChanged: (value) {
                  setState(() {
                    _policy = value!;
                  });
                },
              ), //SizedBox
              Text(
                'I agree to terms and conditions',
                style: TextStyle(fontSize: 15.0),
              ),
              //Checkbox
            ], //<Widget>[]
          ),
          ElevatedButton(
            style: btnStyle,
            onPressed: () {
              //Navigator.pushNamed(context, 'profile-summary');
              if (_registerFormKey.currentState!.validate()) {
                _registerUser();
              }
            },
            child: const Text(
              'Register',
              style: TextStyle(color: Colors.white),
            ),
          ),
        ],
      ),
    );
  }

  void _registerUser() async {
    if (_selectedField == 'Click Select Your Field') {
      showSnackBar(context: context, message: 'select your field of operation');
    } else if (!_policy) {
      showSnackBar(
          context: context,
          message: 'kindly read and agree to terms and conditions of C.A.M.A');
    } else {
      //showSnackBar(context: context, message: 'processing');
      //print(_selectedField);

      _auth.createUser(
          firstName: firstNameController.text,
          lastName: lastNameController.text,
          email: emailController.text,
          mobile: mobileController.text,
          password: passwordController.text,
          confirmPassword: confirmPasswordController.text,
          staffType: _selectedField);
      if (!_auth.isRegistered()) {
        if (_auth.getErrMsgEmail() != null) {
          showSnackBar(context: context, message: _auth.getErrMsgEmail()!);
        }
      } else {
        Navigator.pushReplacementNamed(context, '/');
      }
    }
  }

  void showStaffCategory() {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return StaffCategory(
            categoryUpdater: _updateField,
            selectedIndex: _selectedIndex,
          );
        });
  }
}
