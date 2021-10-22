import 'package:cama/providers/provider_auth.dart';
import 'package:cama/shared/flavors.dart';
import 'package:cama/shared/form_kits.dart';
import 'package:flutter/material.dart';
import 'package:flutter_otp_text_field/flutter_otp_text_field.dart';
import 'package:provider/provider.dart';

class ChangePhoneNumber extends StatefulWidget {
  ChangePhoneNumber({Key? key}) : super(key: key);

  @override
  _ChangePhoneNumberState createState() => _ChangePhoneNumberState();
}

class _ChangePhoneNumberState extends State<ChangePhoneNumber> {
  // final AuthService _authService = AuthService();
  late AuthProvider _auth;
  final _chnageNumFormKey = GlobalKey<FormState>();
  final mobileNumberController = TextEditingController();
  @override
  void dispose() {
    mobileNumberController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    _auth = Provider.of<AuthProvider>(context);
    return Scaffold(
      backgroundColor: Colors.white,
      resizeToAvoidBottomInset: false,
      body: Container(
        padding: const EdgeInsets.symmetric(vertical: 30, horizontal: 35),
        margin: EdgeInsets.symmetric(horizontal: 0, vertical: 30),
        child: Column(
          children: [
            Image.asset("assets/logos/logo.png"),
            const SizedBox(
              height: 20,
            ),
            const Text(
              'Change Your Phone Number',
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 30, fontWeight: FontWeight.w300),
            ),
            const Divider(),
            const SizedBox(
              height: 20,
            ),
            const Text(
              'Enter your new mobile number',
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
            ),
            const SizedBox(
              height: 5,
            ),
            const Text(
              'we will send your verification code to this number',
              textAlign: TextAlign.center,
            ),
            TextButton.icon(
                onPressed: () async {
                  await _auth.OTPResend();
                  if (_auth.isResent) {
                    showSnackBar(context: context, message: 'OTP sent.');
                    Navigator.pushReplacementNamed(context, 'verify-otp');
                  }
                },
                icon: const Icon(Icons.swap_horiz),
                label: const Text('send to old number')),
            const SizedBox(
              height: 20,
            ),
            SingleChildScrollView(
              child: ListView(shrinkWrap: true, children: [
                Form(
                  key: _chnageNumFormKey,
                  child: Column(
                    children: [
                      const SizedBox(
                        height: 20,
                      ),
                      TextFormField(
                        keyboardType: TextInputType.number,
                        decoration: textFieldDecorator.copyWith(
                            label: const Text('Mobile Number'),
                            prefixIcon: Icon(Icons.phone_android_sharp),
                            hintText: 'enter new number'),
                        controller: mobileNumberController,
                        validator: (val) => validateTextField(val),
                      ),
                      const SizedBox(
                        height: 40,
                      ),
                      ElevatedButton(
                        style: btnStyle,
                        onPressed: () async {
                          if (_chnageNumFormKey.currentState!.validate()) {
                            _updateMobileNumber();
                          }
                        },
                        child: const Text(
                          'Update Your Number',
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                    ],
                  ),
                ),
              ]),
            ),
            SizedBox(
              height: 90,
            ),
          ],
        ),
      ),
    );
  }

  void _updateMobileNumber() async {
    final Map<String, dynamic> body = {};
    body['mobile'] = mobileNumberController.text;
    await _auth.updateUser(body: body, token: _auth.token!);
    bool res = _auth.isProfileUpdate;
    if (res) {
      await _auth.OTPResend();
      Navigator.pushReplacementNamed(context, 'verify-otp');
    } else {
      showSnackBar(
          context: context, message: 'unable to update profile. Try again');
    }
  }
}
