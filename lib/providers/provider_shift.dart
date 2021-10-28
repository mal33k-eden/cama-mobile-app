import 'dart:convert';

import 'package:cama/api/shift_api.dart';
import 'package:cama/models/shift.dart';
import 'package:flutter/material.dart';

class ShiftProvider extends ChangeNotifier {
  List<MyShift> _shifts = [];

  List<Map<String, MyShift>> _calendarShifts = [];

  bool isShiftLoaded = false;
  int poolCurPage = 0;
  int poolPageLen = 0;

  Future<bool> getPool(String token, page) async {
    _shifts = [];
    isShiftLoaded = false;
    await ShiftApi(token: token).pool(page).then((data) {
      if (data.statusCode == 201) {
        isShiftLoaded = true;
        //print(jsonDecode(data.body));
        setPoolShifts(jsonDecode(data.body));
      }
    });
    return isShiftLoaded;
  }

  Future<bool> getUnconfirmed(String token) async {
    _shifts = [];
    isShiftLoaded = false;
    await ShiftApi(token: token).unconfirmed().then((data) {
      if (data.statusCode == 201) {
        isShiftLoaded = true;
        setShifts(jsonDecode(data.body));
      }
    });
    return isShiftLoaded;
  }

  Future<bool> confirmShift(
      {required Map<String, dynamic> body, required String token}) async {
    isShiftLoaded = false;
    await ShiftApi(token: token).confirm(body: body).then((data) {
      if (data.statusCode == 201) {
        isShiftLoaded = true;
      } else {
        isShiftLoaded = false;
        Map<String, dynamic> result = json.decode(data.body);
      }
    });
    notifyListeners();
    return isShiftLoaded;
  }

  Future<bool> pickPoolShift(
      {required Map<String, dynamic> body, required String token}) async {
    isShiftLoaded = false;
    await ShiftApi(token: token).poolPick(body: body).then((data) {
      if (data.statusCode == 201) {
        isShiftLoaded = true;
      } else {
        isShiftLoaded = false;
        Map<String, dynamic> result = json.decode(data.body);
      }
    });
    notifyListeners();
    return isShiftLoaded;
  }

  Future<bool> timesheets(String token) async {
    _shifts = [];
    isShiftLoaded = false;
    await ShiftApi(token: token).timesheets().then((data) {
      if (data.statusCode == 201) {
        isShiftLoaded = true;
        setShifts(jsonDecode(data.body));
      }
    });
    return isShiftLoaded;
  }

  Future<bool> timesheetsUpload(
      {required Map<String, dynamic> body, required String token}) async {
    isShiftLoaded = false;
    await ShiftApi(token: token).timesheetUpload(body: body).then((data) {
      if (data.statusCode == 201) {
        isShiftLoaded = true;
      } else {
        isShiftLoaded = false;

        Map<String, dynamic> result = json.decode(data.body);
      }
    });
    notifyListeners();
    return isShiftLoaded;
  }

  Future<bool> calendar(
      {required Map<String, dynamic> body, required String token}) async {
    _calendarShifts = [];
    isShiftLoaded = false;
    await ShiftApi(token: token).calendar(body: body).then((data) {
      if (data.statusCode == 201) {
        isShiftLoaded = true;
        setCalendarShifts(jsonDecode(data.body));
      } else {
        isShiftLoaded = false;

        Map<String, dynamic> result = json.decode(data.body);
      }
    });
    notifyListeners();
    return isShiftLoaded;
  }

  Future<bool> declineShift(
      {required Map<String, dynamic> body, required String token}) async {
    isShiftLoaded = false;
    await ShiftApi(token: token).decline(body: body).then((data) {
      if (data.statusCode == 201) {
        isShiftLoaded = true;
      } else {
        isShiftLoaded = false;

        Map<String, dynamic> result = json.decode(data.body);
      }
    });
    notifyListeners();
    return isShiftLoaded;
  }

  void setShifts(_data) {
    var all = _data['data'];
    all.forEach((data) => _shifts.add(MyShift.fromJson(data)));
    isShiftLoaded = true;

    notifyListeners();
  }

  List<MyShift>? myShifts() {
    return _shifts;
  }

  void setCalendarShifts(_data) {
    var all = _data['data'];
    all.forEach((data) {
      Map<String, MyShift> d = {};
      var i = MyShift.fromJson(data);
      d[data['shift']['date']] = i;
      _calendarShifts.add(d);
    });
    isShiftLoaded = true;
    notifyListeners();
  }

  List<Map<String, MyShift>>? myCalendarShifts() {
    return _calendarShifts;
  }

  void setPoolShifts(jsonDecode) {
    var data = jsonDecode['data'];
    List<dynamic> temp = [];
    poolCurPage = data['current_page'];
    poolPageLen = data['last_page'];
    var all = data['data'];
    if (poolCurPage < 2) {
      all.forEach((data) => _shifts.add(MyShift.forCalendarfromJson(data)));
    } else {
      temp.add(all);
      temp.forEach((element) {
        element.forEach((key, val) {
          _shifts.add(MyShift.forCalendarfromJson(element[key]));
        });
      });
    }

    // isShiftLoaded = true;
    // notifyListeners();
  }
}
