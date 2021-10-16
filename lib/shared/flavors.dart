import 'package:flutter/material.dart';

class Flavor {
  static const MaterialColor primaryToDark = MaterialColor(
    0xff07a2c6, // 0% comes in here, this will be color picked if no shade is selected when defining a Color property which doesn’t require a swatch.
    <int, Color>{
      50: Color(0xff0692b2), //10%
      100: Color(0xff06829e), //20%
      200: Color(0xff05718b), //30%
      300: Color(0xff046177), //40%
      400: Color(0xff045163), //50%
      500: Color(0xff03414f), //60%
      600: Color(0xff02313b), //70%
      700: Color(0xff012028), //80%
      800: Color(0xff011014), //90%
      900: Color(0xff000000), //100%
    },
  );
  static const MaterialColor secondaryToDark = MaterialColor(
    0xff52fae4, // 0% comes in here, this will be color picked if no shade is selected when defining a Color property which doesn’t require a swatch.
    <int, Color>{
      50: Color(0xff4ae1cd), //10%
      100: Color(0xff42c8b6), //20%
      200: Color(0xff39afa0), //30%
      300: Color(0xff319689), //40%
      400: Color(0xff297d72), //50%
      500: Color(0xff21645b), //60%
      600: Color(0xff194b44), //70%
      700: Color(0xff10322e), //80%
      800: Color(0xff081917), //90%
      900: Color(0xff000000), //100%
    },
  );
}
