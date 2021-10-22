import 'package:cama/models/user.dart';
import 'package:cama/pages/auth/auth_controller.dart';
import 'package:cama/pages/auth/otp.dart';
import 'package:cama/pages/dashboard/dashboard.dart';
import 'package:cama/pages/profile/details.dart';
import 'package:cama/pages/profile/summary.dart';
import 'package:cama/providers/provider_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Wrapper extends StatefulWidget {
  const Wrapper({Key? key}) : super(key: key);

  @override
  State<Wrapper> createState() => _WrapperState();
}

class _WrapperState extends State<Wrapper> {
  User? user;

  @override
  @override
  Widget build(BuildContext context) {
    //return Container();

    final _auth = Provider.of<AuthProvider>(context);
    final user = context.watch<AuthProvider>().getUser();
    if (user != this.user) {
      this.user = user;
    }
    //print(user?.first_name);
    if (_auth.token == 'unset') {
      return AuthController();
    } else if (user?.email_verified_at == null) {
      //OTP
      return OTPPage();
    } else if (user?.compulsory_checks == 'In-complete') {
      return Summary();
      // return Container();
    } else {
      return DashBoard();
    }
  }
}
