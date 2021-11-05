import 'package:cama/shared/flavors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class Loader extends StatelessWidget {
  const Loader({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Flavor.primaryToDark.shade400,
      child: Center(
        child: SpinKitChasingDots(
          color: Flavor.secondaryToDark,
          size: 50,
        ),
      ),
    );
  }
}
