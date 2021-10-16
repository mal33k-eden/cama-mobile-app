import 'package:cama/shared/form_kits.dart';
import 'package:flutter/material.dart';

class SignIn extends StatefulWidget {
  final Function toggleAuthView;
  const SignIn({required this.toggleAuthView, Key? key}) : super(key: key);

  @override
  _SignInState createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  // final AuthService _authService = AuthService();
  final _siginInFormKey = GlobalKey<FormState>();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  @override
  void dispose() {
    // Clean up the controller when the widget is removed from the
    // widget tree.
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      resizeToAvoidBottomInset: false,
      body: Container(
        padding: const EdgeInsets.symmetric(vertical: 30, horizontal: 35),
        child: ListView(
          children: [
            Image.asset("assets/logos/logo.png"),
            const SizedBox(
              height: 10,
            ),
            const Text(
              'Sign In',
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 30, fontWeight: FontWeight.w300),
            ),
            const Divider(),
            SingleChildScrollView(
              child: ListView(shrinkWrap: true, children: [
                Form(
                  key: _siginInFormKey,
                  child: Column(
                    children: [
                      const SizedBox(
                        height: 20,
                      ),
                      TextFormField(
                        decoration: textFieldDecorator.copyWith(
                            label: const Text('E-mail'),
                            prefixIcon: Icon(Icons.mail_sharp),
                            hintText: 'Enter a valid email'),
                        controller: emailController,
                        validator: (val) => validateTextField(val),
                        // The validator receives the text that the user has entered.
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      TextFormField(
                        decoration: textFieldDecorator.copyWith(
                            label: const Text('Password'),
                            prefixIcon: Icon(Icons.lock_sharp),
                            hintText: 'Enter your password'),
                        obscureText: true,
                        controller: passwordController,
                        validator: (val) => validateTextField(val),
                      ),
                      const SizedBox(
                        height: 40,
                      ),
                      ElevatedButton(
                        style: btnStyle,
                        onPressed: () async {
                          Navigator.pushNamed(context, 'agencies');
                          // if (_siginInFormKey.currentState!.validate()) {
                          //   showSnackBar(
                          //       context: context, message: 'processing data');
                          //   _signinUser();
                          // }
                        },
                        child: const Text(
                          'Sign In',
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
            Expanded(
              child: Align(
                alignment: FractionalOffset.bottomCenter,
                child: Row(
                  children: [
                    const Text('Don\'t have an account? '),
                    TextButton.icon(
                        onPressed: () {
                          widget.toggleAuthView();
                        },
                        icon: const Icon(Icons.login),
                        label: const Text('Register'))
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  void _signinUser() async {
    // dynamic result = await _authService.signinUser(
    //   email: emailController.text,
    //   password: passwordController.text,
    // );
    // print(result);
    // if (result is String) {
    //   showSnackBar(context: context, message: result);
    // }
  }
}
