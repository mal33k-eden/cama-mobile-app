import 'dart:convert';

import 'package:cama/api/agency_api.dart';
import 'package:cama/models/agency.dart';

import 'package:flutter/material.dart';

class AgencyProvider extends ChangeNotifier {
  bool loading = false;
  String? _errMsg;

  bool isSetMyAgencies = false;
  bool isResent = false;
  bool isProfileUpdate = false;
  List<MyAgency>? _allAgencies = [];

  Future<bool> fetchMyAgencies(String token) async {
    _allAgencies = [];
    setLoading(true);
    await Agency(token: token).myAgencies().then((data) {
      setLoading(false);
      //print(data.body);
      if (data.statusCode == 201) {
        setAllAgency(jsonDecode(data.body));
      }
    });
    return true;
  }

  Future<bool> attacheDoc(
      {required Map<String, dynamic> body, required String token}) async {
    isSetMyAgencies = false;
    await Agency(token: token).attachDoc(body: body).then((data) {
      setLoading(false);
      if (data.statusCode == 201) {
        isSetMyAgencies = true;
      } else {
        isSetMyAgencies = false;
        print(data.body);
        Map<String, dynamic> result = json.decode(data.body);
      }
    });
    notifyListeners();
    return isProfileUpdate;
  }

  Future<bool> attacheTraining(
      {required Map<String, dynamic> body, required String token}) async {
    isSetMyAgencies = false;
    await Agency(token: token).attachTraining(body: body).then((data) {
      setLoading(false);
      if (data.statusCode == 201) {
        isSetMyAgencies = true;
      } else {
        isSetMyAgencies = false;
        print(data.body);
        Map<String, dynamic> result = json.decode(data.body);
      }
    });
    notifyListeners();
    return isProfileUpdate;
  }

  Future<bool> profileActions(
      {required Map<String, dynamic> body, required String token}) async {
    isSetMyAgencies = false;
    await Agency(token: token).profileActions(body: body).then((data) {
      setLoading(false);
      if (data.statusCode == 201) {
        isSetMyAgencies = true;
      } else {
        isSetMyAgencies = false;
        print(data.body);
        Map<String, dynamic> result = json.decode(data.body);
      }
    });
    notifyListeners();
    return isProfileUpdate;
  }

  void setLoading(bool value) {
    loading = value;
    notifyListeners();
  }

  bool isLoading() {
    return loading;
  }

  List<MyAgency>? myAgencies() {
    return _allAgencies;
  }

  void setAllAgency(allAgencies) {
    var all = allAgencies['data'];
    all.forEach((data) => _allAgencies?.add(MyAgency.fromJson(data)));
    isSetMyAgencies = true;
    notifyListeners();
  }
}
