import 'package:cama/pages/auth/register.dart';
import 'package:cama/pages/auth/signin.dart';
import 'package:flutter/material.dart';

class AuthController extends StatefulWidget {
  const AuthController({Key? key}) : super(key: key);

  @override
  _AuthControllerState createState() => _AuthControllerState();
}

class _AuthControllerState extends State<AuthController> {
  bool showSignIn = true;
  void toggleAuthView() {
    setState(() {
      showSignIn = !showSignIn;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (showSignIn) {
      return SignIn(toggleAuthView: toggleAuthView);
    } else {
      return Register(toggleAuthView: toggleAuthView);
    }
  }
}
