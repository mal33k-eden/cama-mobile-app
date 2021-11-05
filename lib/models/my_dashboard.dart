import 'package:cama/models/shift.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class MyDashBoard {
  String full_name;
  String photo;
  int calendar;
  int unconfirmed;
  int timesheet;
  int files;
  int agencies;
  int pool;
  bool hasShiftToday;
  List<Map<String, dynamic>> shift = [];

  MyDashBoard(
      {required this.full_name,
      required this.photo,
      required this.calendar,
      required this.unconfirmed,
      required this.timesheet,
      required this.files,
      required this.agencies,
      required this.pool,
      required this.shift,
      required this.hasShiftToday});

  factory MyDashBoard.fromJson(Map<String, dynamic> json) {
    Map<String, dynamic> t = {};
    List<Map<String, dynamic>> tArr = [];
    bool ist = false;

    if (json['today'].length > 0) {
      var shift = json['today'].elementAt(0);
      String date = shift['shift']['date'];
      String st = shift['shift']['start_time'];
      String et = shift['shift']['start_time'];
      t['date1'] = DateFormat('EEE').format(DateTime.parse(date));
      t['date2'] = DateFormat('dd').format(DateTime.parse(date));
      t['home'] = shift['shift']['client']['home']['name'];
      t['agency'] = shift['shift']['user']['name'];
      t['period'] =
          DateFormat('HH:mm a').format(DateTime.parse('2021-01-02 ' + st)) +
              ' - ' +
              DateFormat('HH:mm a').format(DateTime.parse('2021-01-02 ' + et));
      ist = true;
    }
    print(ist);
    tArr.add(t);
    return MyDashBoard(
        full_name: json['full_name'],
        photo: json['photo'],
        calendar: json['calendar'],
        unconfirmed: json['unconfirmed'],
        timesheet: json['timesheets'],
        files: json['files'],
        agencies: json['agencies'],
        pool: json['pool'],
        shift: tArr,
        hasShiftToday: ist);
  }

  // Map<String, dynamic> toJson() => {
  //       'full_name': full_name,
  //       'photo': photo,
  //       'calendar': calendar,
  //       'unconfirmed': unconfirmed,
  //       'timesheet': timesheet,
  //       'files': files,
  //       'agencies': agencies,
  //       'pool': pool,
  //       'today': today
  //     };
}
