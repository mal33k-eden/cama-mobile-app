import 'package:cama/pages/auth/staffcategory.dart';
import 'package:cama/shared/flavors.dart';
import 'package:cama/shared/form_kits.dart';
import 'package:flutter/material.dart';

class Register extends StatefulWidget {
  final Function toggleAuthView;
  const Register({required this.toggleAuthView, Key? key}) : super(key: key);

  @override
  _RegisterState createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  // final AuthService _authService = AuthService();
  final _registerFormKey = GlobalKey<FormState>();
  final nickNameController = TextEditingController();
  final emailController = TextEditingController();
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
  void dispose() {
    // Clean up the controller when the widget is removed from the
    // widget tree.
    nickNameController.dispose();
    emailController.dispose();
    passwordController.dispose();
    confirmPasswordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      resizeToAvoidBottomInset: false,
      body: Container(
        padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 35),
        child: ListView(
          children: [
            Image.asset("assets/logos/logo.png"),
            const SizedBox(
              height: 10,
            ),
            const Text(
              'Register',
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 30, fontWeight: FontWeight.w300),
            ),
            const Divider(),
            SingleChildScrollView(
              child: ListView(shrinkWrap: true, children: [
                Form(
                  key: _registerFormKey,
                  child: Column(
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
                            padding: const EdgeInsets.all(18.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Icon(
                                  Icons.local_hospital_sharp,
                                  color: _selectedIndex == 0
                                      ? Colors.black
                                      : Colors.white,
                                ),
                                SizedBox(
                                  width: 10,
                                ),
                                Text(
                                  _selectedField,
                                  style: TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                    color: _selectedIndex == 0
                                        ? Colors.black
                                        : Colors.white,
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
                        controller: nickNameController,
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
                        controller: nickNameController,
                        // The validator receives the text that the user has entered.
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      TextFormField(
                        decoration: textFieldDecorator.copyWith(
                            label: const Text('E-mail'),
                            prefixIcon: Icon(Icons.mail_sharp),
                            hintText: 'e.g pokinated@example.com'),
                        validator: (input) => input!.isValidEmail()
                            ? null
                            : "enter a valid email",
                        controller: emailController,
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
                          Navigator.pushNamed(context, 'profile-summary');
                          // if (_registerFormKey.currentState!.validate()) {
                          //   showSnackBar(
                          //       context: context, message: 'processing data');
                          //   _registerUser();
                          // }
                        },
                        child: const Text(
                          'Register',
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                Container(
                  child: Align(
                    alignment: FractionalOffset.bottomCenter,
                    child: Row(
                      children: [
                        const Text('Already have an account? '),
                        TextButton.icon(
                            onPressed: () {
                              widget.toggleAuthView();
                            },
                            icon: const Icon(Icons.login),
                            label: const Text('Sign In'))
                      ],
                    ),
                  ),
                )
              ]),
            ),
          ],
        ),
      ),
    );
  }

  void _registerUser() async {}

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
