import 'package:cama/models/user.dart';
import 'package:cama/pages/auth/auth_controller.dart';
import 'package:cama/pages/auth/otp.dart';
import 'package:cama/pages/dashboard/dashboard.dart';
import 'package:cama/pages/profile/details.dart';
import 'package:cama/pages/profile/summary.dart';
import 'package:cama/providers/provider_auth.dart';
import 'package:cama/widgets/loader.dart';
import 'package:cama/widgets/onboarding.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

int? isViewed;

class Wrapper extends StatefulWidget {
  const Wrapper({Key? key}) : super(key: key);

  @override
  State<Wrapper> createState() => _WrapperState();
}

class _WrapperState extends State<Wrapper> {
  User? user;
  late final AuthProvider _auth;
  var tk = 'unset';
  bool isSet = false;
  bool showLoader = true;

  @override
  void initState() {
    setState(() {
      showLoader = true;
    });
    // TODO: implement initState
    getOnBoardingStatus();
    super.initState();
    WidgetsBinding.instance?.addPostFrameCallback((timeStamp) {
      _auth = Provider.of<AuthProvider>(this.context, listen: false);
      _getProfile();
    });
  }

  @override
  @override
  Widget build(BuildContext context) {
    //final showLoader = context.watch<AuthProvider>().loading;
    print(showLoader);
    if (showLoader) {
      return Loader();
    }

    if (isViewed == 0) {
      if (tk == 'unset') {
        return AuthController();
      } else {
        if (isSet) {
          if (user?.email_verified_at == null) {
            //OTP
            return OTPPage();
          }
          if (user?.compulsory_checks == 'In-complete') {
            return Summary();
          }
          return DashBoard();
        } else {
          return Loader();
        }
      }
    } else {
      return Onboard();
    }
  }

  void _getProfile() async {
    await _auth.getToken();
    var _user = await _auth.getUser();
    if (mounted) {
      setState(() {
        user = _user;
        tk = _auth.token!;
        if (_user?.email != null) {
          isSet = true;
          showLoader = false;
        }
      });
    }
  }

  void getOnBoardingStatus() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    isViewed = preferences.getInt('onBoard');
    setState(() {
      showLoader = false;
    });
  }
}
