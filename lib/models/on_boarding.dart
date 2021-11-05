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
      title: 'Organised Documents',
      des:
          'Conviniently organise your files and share them with your agencies all in one place.',
      bg: Colors.white,
      button: Colors.black),
  Onboarding(
      img: 'assets/images/org_shifts.svg',
      title: 'Organized Bookings',
      des:
          'Accept your shifts and submit your timesheets faster and conviniently.',
      bg: Colors.white,
      button: Colors.black),
  Onboarding(
      img: 'assets/images/nurse_home.svg',
      title: 'Focus On Work',
      des:
          'C.A.M.A brings you all the basic and advanced tools you need as an agency staff.',
      bg: Colors.white,
      button: Colors.black)
];
