import 'package:cama/shared/avart_icon.dart';
import 'package:cama/shared/flavors.dart';

import 'package:flutter/material.dart';
import 'package:flutter_overlay_loader/flutter_overlay_loader.dart';

const textFieldDecorator = InputDecoration(
    focusedBorder: UnderlineInputBorder(
      borderSide: BorderSide(color: Flavor.secondaryToDark),
    ),
    enabledBorder: UnderlineInputBorder(
      borderSide: BorderSide(color: Flavor.primaryToDark),
    ),
    border: UnderlineInputBorder());

final ButtonStyle btnStyle = ElevatedButton.styleFrom(
    primary: Flavor.primaryToDark,
    textStyle: const TextStyle(fontSize: 20),
    padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 20));
final ButtonStyle btnStyleLight = ElevatedButton.styleFrom(
    primary: Colors.white,
    textStyle: const TextStyle(fontSize: 20),
    padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 20));

extension EmailValidator on String {
  bool isValidEmail() {
    return RegExp(
            r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$')
        .hasMatch(this);
  }
}

//validations
String? validateTextField(String? value) {
  if (value!.isEmpty) {
    return "field cannot be empty";
  }
  return null;
}

String? validatePasswordField(String? value) {
  if (value!.isEmpty) {
    return "field cannot be empty";
  } else if (value.length < 8) {
    return 'password is less';
  }
  return null;
}

String? validateRePasswordField(
    String? value, TextEditingController passController) {
  if (value!.isEmpty) {
    return "field cannot be empty";
  } else if (value.length < 8) {
    return 'password too short';
  } else if (value != passController.text) {
    return 'passwords do not match';
  }
  return null;
}

void showSnackBar({required BuildContext context, required String message}) {
  ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(message)));
}

Future showCustomAlert(
    {required var scaffoldState,
    required String title,
    required String message}) {
  BuildContext mainContext = scaffoldState.currentContext;
  return showDialog(
      context: mainContext,
      builder: (_) {
        return AlertDialog(
          title: Text(title),
          content: Text(message),
          actions: [
            TextButton(
                onPressed: () {
                  Navigator.of(mainContext, rootNavigator: true)
                      .pop(showCustomAlert);
                },
                child: Text('close'))
          ],
        );
      });
}

void showCustomActivityAlert({required context}) {
  Loader.show(context,
      isSafeAreaOverlay: true,
      isAppbarOverlay: true,
      isBottomBarOverlay: true,
      progressIndicator: CustomActivityIndicator(size: 18),
      overlayColor: Colors.black.withOpacity(0.2));
}
