import 'dart:convert';

import 'package:intl/intl.dart';

class MyShift {
  int id;
  String agency;
  String key;
  String date;
  String pickup;
  String start;
  String end;
  String home;
  String address;
  String postcode;
  String note;
  String shift_status;
  List<dynamic> rates;

  MyShift(
      {required this.id,
      required this.agency,
      required this.key,
      required this.date,
      required this.end,
      required this.start,
      required this.address,
      required this.postcode,
      required this.note,
      required this.shift_status,
      required this.home,
      required this.pickup,
      required this.rates});

  factory MyShift.fromJson(Map<dynamic, dynamic> data) {
    var shift = data['shift'];
    var rate = data['shift']['shift_rate_wage'];
    var home = data['shift']['client']['home'];

    return MyShift(
      home: home['name'],
      address: home['address'],
      postcode: home['postcode'],
      agency: shift['user']['name'],
      date: shift['date'],
      end: DateFormat('HH:mm a')
          .format(DateTime.parse('2021-01-02 ' + shift['end_time'])),
      start: DateFormat('HH:mm a')
          .format(DateTime.parse('2021-01-02 ' + shift['start_time'])),
      id: shift['id'],
      pickup: (shift['pickup_time'] != '00:00:00')
          ? DateFormat('HH:mm a')
              .format(DateTime.parse('2021-01-02 ' + shift['pickup_time']))
          : '----',
      note: shift['note'],
      rates: rate,
      shift_status: shift['status'],
      key: shift['visible_key'],
    );
  }
  factory MyShift.forCalendarfromJson(Map<dynamic, dynamic> data) {
    var shift = data;

    var rate = data['shift_rate_wage'];
    var home = data['client']['home'];
    return MyShift(
      home: home['name'],
      address: home['address'],
      postcode: home['postcode'],
      agency: shift['user']['name'],
      date: shift['date'],
      end: shift['end_time'],
      start: shift['start_time'],
      id: shift['id'],
      pickup: shift['pickup_time'],
      note: shift['note'],
      rates: rate,
      shift_status: shift['status'],
      key: shift['visible_key'],
    );
  }
}
