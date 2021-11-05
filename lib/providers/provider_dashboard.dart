import 'dart:convert';

import 'package:cama/api/dashboard_api.dart';
import 'package:cama/api/shift_api.dart';
import 'package:cama/models/my_dashboard.dart';
import 'package:cama/models/shift.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class DashBoardProvider extends ChangeNotifier {
  MyDashBoard? dashBoard;
  bool isDashBoardLoaded = false;

  Future<bool> fetchDashBoard(String token) async {
    isDashBoardLoaded = false;
    await DashboardApi(token: token).dashboard().then((data) async {
      if (data.statusCode == 201) {
        await setDashBoard(jsonDecode(data.body));
        isDashBoardLoaded = true;
      }
    });
    return isDashBoardLoaded;
  }

  Future<void> setDashBoard(jsonDecode) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    var data = jsonDecode['data'];
    await preferences.setString('dashboard', jsonEncode(data));
  }

  Future<MyDashBoard?> getDashBoard() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    String? result = preferences.getString('dashboard');
    if (result != null) {
      dashBoard = MyDashBoard.fromJson(jsonDecode(result));
    }
    return dashBoard;
  }
}
