import 'package:cama/shared/flavors.dart';
import 'package:flutter/material.dart';

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
