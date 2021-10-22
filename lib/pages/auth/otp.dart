import 'package:cama/providers/provider_auth.dart';
import 'package:cama/shared/flavors.dart';
import 'package:cama/shared/form_kits.dart';
import 'package:flutter/material.dart';
import 'package:flutter_otp_text_field/flutter_otp_text_field.dart';
import 'package:provider/provider.dart';

class OTPPage extends StatefulWidget {
  OTPPage({Key? key}) : super(key: key);

  @override
  _OTPPageState createState() => _OTPPageState();
}

class _OTPPageState extends State<OTPPage> {
  // final AuthService _authService = AuthService();
  late AuthProvider _auth;
  final _otpFormKey = GlobalKey<FormState>();
  final otpController = TextEditingController();
  @override
  void dispose() {
    otpController.dispose();
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
              'Verify Account',
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 30, fontWeight: FontWeight.w300),
            ),
            const Divider(),
            const SizedBox(
              height: 20,
            ),
            const Text(
              'Enter your verification code',
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
            ),
            const SizedBox(
              height: 5,
            ),
            const Text(
              'we sent a verification code to 07786982012',
              textAlign: TextAlign.center,
            ),
            TextButton.icon(
                onPressed: () {
                  Navigator.pushReplacementNamed(context, 'change-otp-phone');
                },
                icon: const Icon(Icons.swap_horiz),
                label: const Text('change your number')),
            const SizedBox(
              height: 20,
            ),
            SingleChildScrollView(
              child: ListView(shrinkWrap: true, children: [
                Form(
                  key: _otpFormKey,
                  child: Column(
                    children: [
                      const SizedBox(
                        height: 20,
                      ),
                      OtpTextField(
                        keyboardType: TextInputType.number,
                        numberOfFields: 4,
                        borderColor: Flavor.secondaryToDark,
                        enabledBorderColor: Flavor.secondaryToDark,
                        focusedBorderColor: Flavor.primaryToDark,
                        showFieldAsBox: false,
                        onCodeChanged: (String code) {
                          //handle validation or checks here
                        },
                        //runs when every textfield is filled
                        onSubmit: (String verificationCode) async {
                          _verifyOtp(verificationCode);
                          // showDialog(
                          //     context: context,
                          //     builder: (context) {
                          //       return AlertDialog(
                          //         title: Text("Verification Code"),
                          //         content:
                          //             Text('Code entered is $verificationCode'),
                          //       );
                          //     });
                        }, // end onSubmit
                      ),
                      // TextFormField(
                      //   keyboardType: TextInputType.number,
                      //   decoration: textFieldDecorator.copyWith(
                      //       label: const Text('OTP Code'),
                      //       prefixIcon: Icon(Icons.lock_sharp),
                      //       hintText: 'Enter the 4 digit Otp'),
                      //   controller: otpController,
                      //   validator: (val) => validateTextField(val),
                      // ),
                      const SizedBox(
                        height: 40,
                      ),
                      // ElevatedButton(
                      //   style: btnStyle,
                      //   onPressed: () async {
                      //     if (_otpFormKey.currentState!.validate()) {
                      //       _verifyOtp();
                      //     }
                      //   },
                      //   child: const Text(
                      //     'Verify Your Number',
                      //     style: TextStyle(color: Colors.white),
                      //   ),
                      // ),
                    ],
                  ),
                ),
              ]),
            ),
            SizedBox(
              height: 90,
            ),
            Expanded(
              child: Align(
                alignment: FractionalOffset.bottomCenter,
                child: Row(
                  children: [
                    const Text('Didn\'t receive your code? '),
                    TextButton.icon(
                        onPressed: () async {
                          await _auth.OTPResend();
                          if (_auth.isResent) {
                            showSnackBar(
                                context: context, message: 'OTP sent.');
                          }
                        },
                        icon: const Icon(Icons.sms),
                        label: const Text('Resend Code'))
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  void _verifyOtp(verificationCode) async {
    await _auth.OTPVerify(otp: verificationCode);
    bool res = _auth.isVerify;
    if (res) {
      Navigator.pushReplacementNamed(context, 'profile-summary');
    } else {
      showSnackBar(context: context, message: 'OTP invalid. Try again');
    }
  }
}
