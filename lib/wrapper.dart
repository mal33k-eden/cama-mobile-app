import 'package:cama/pages/auth/auth_controller.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Wrapper extends StatelessWidget {
  const Wrapper({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    //return Container();
    //final user = Provider.of<Owner?>(context);
    final user = null;
    if (user == null) {
      return const AuthController();
    } else {
      return Container();
    }
  }
}
