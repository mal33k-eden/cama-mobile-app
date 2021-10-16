import 'package:flutter/material.dart';

class Onboarding {
  String img;
  String title;
  String des;
  Color bg;
  Color button;

  Onboarding(
      {required this.img,
      required this.title,
      required this.des,
      required this.bg,
      required this.button});
}

List<Onboarding> screens = <Onboarding>[
  Onboarding(
      img: 'assets/images/org_doc.svg',
      title: 'Organized Documents',
      des: 'Description 1',
      bg: Colors.white,
      button: Colors.black),
  Onboarding(
      img: 'assets/images/org_shifts.svg',
      title: 'Organized Bookings',
      des: 'Description 2',
      bg: Colors.white,
      button: Colors.black),
  Onboarding(
      img: 'assets/images/nurse_home.svg',
      title: 'Focus On Work',
      des: 'Description 3',
      bg: Colors.white,
      button: Colors.black)
];
