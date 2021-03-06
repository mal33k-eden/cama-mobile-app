import 'dart:io';

import 'package:cama/shared/flavors.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

Widget editImageIcon() {
  return ClipOval(
    child: Container(
      padding: EdgeInsets.all(8),
      color: Flavor.secondaryToDark,
      child: Icon(
        Icons.edit_sharp,
        size: 20,
        color: Colors.white,
      ),
    ),
  );
}

Widget removeImageIcon() {
  return ClipOval(
    child: Container(
      padding: EdgeInsets.all(8),
      color: Flavor.secondaryToDark,
      child: Icon(
        Icons.cancel_sharp,
        size: 20,
        color: Colors.red,
      ),
    ),
  );
}

Widget ImageSelectorDisplay(imagePath, isLocal, isasset) {
  return Container(
    height: 200.0,
    width: 200.0,
    decoration: BoxDecoration(
        image: (!isasset)
            ? (isLocal)
                ? DecorationImage(
                    image: FileImage(imagePath), fit: BoxFit.cover)
                : DecorationImage(
                    image: NetworkImage(imagePath), fit: BoxFit.cover)
            : DecorationImage(image: AssetImage(imagePath), fit: BoxFit.cover),
        borderRadius: BorderRadius.circular(25),
        color: Flavor.primaryToDark,
        boxShadow: [
          BoxShadow(
              offset: Offset(4.0, 4.0),
              blurRadius: 25,
              color: Colors.grey.shade300,
              spreadRadius: 8),
          BoxShadow(
              offset: Offset(-4.0, -4.0),
              blurRadius: 25,
              color: Colors.white10,
              spreadRadius: 8),
        ]),
  );
}

Widget CustomActivityIndicator({required double size}) {
  if (Platform.isIOS) {
    return CupertinoActivityIndicator(animating: true, radius: size);
  } else {
    return Center(
      child: SizedBox(
        child: CircularProgressIndicator(
          backgroundColor: Flavor.primaryToDark,
          color: Flavor.secondaryToDark,
        ),
        height: 80.0,
        width: 80.0,
      ),
    );
  }
}
