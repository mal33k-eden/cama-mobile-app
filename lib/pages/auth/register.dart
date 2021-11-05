import 'package:cama/forms/register_form.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class Register extends StatefulWidget {
  final Function toggleAuthView;
  const Register({required this.toggleAuthView, Key? key}) : super(key: key);

  @override
  _RegisterState createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  @override
  Widget build(BuildContext context) {
    final bottom = MediaQuery.of(context).viewInsets.bottom;

    return Scaffold(
      backgroundColor: Colors.white,
      resizeToAvoidBottomInset: false,
      body: Padding(
        padding: EdgeInsets.only(bottom: bottom),
        child: Container(
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
                child: Column(children: [
                  RegisterForm(),
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
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                ]),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
