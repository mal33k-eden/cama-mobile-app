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
      des:
          'Lorem Ipsum is simply dummy text of the printing and typesetting industry',
      bg: Colors.white,
      button: Colors.black),
  Onboarding(
      img: 'assets/images/org_shifts.svg',
      title: 'Organized Bookings',
      des:
          'Lorem Ipsum is simply dummy text of the printing and typesetting industry',
      bg: Colors.white,
      button: Colors.black),
  Onboarding(
      img: 'assets/images/nurse_home.svg',
      title: 'Focus On Work',
      des:
          'Lorem Ipsum is simply dummy text of the printing and typesetting industry',
      bg: Colors.white,
      button: Colors.black)
];
