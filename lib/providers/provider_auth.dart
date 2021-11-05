import 'dart:convert';
import 'package:cama/api/auth.dart';
import 'package:cama/api/profile.dart';
import 'package:cama/models/user.dart';
import 'package:cama/providers/provider_agency.dart';
import 'package:cama/providers/provider_dashboard.dart';
import 'package:cama/services/push_config.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthProvider extends ChangeNotifier {
  bool loading = false;
  String? _errMsgEmail;
  String _token = 'unset';
  User? _user;
  bool isVerify = false;
  bool isResent = false;
  bool isProfileUpdate = false;
  bool isFetchProfile = false;
  bool isLoggedout = false;
  PushNotifyConfig push = new PushNotifyConfig();
  DashBoardProvider dp = new DashBoardProvider();

  AuthProvider() {
    getToken();
  }

  Future<bool> createUser({required Map<String, String> body}) async {
    isProfileUpdate = false;
    await Auth().register(body).then((data) {
      if (data.statusCode == 201) {
        Map<String, dynamic> result = json.decode(data.body);

        isProfileUpdate = true;
        _saveToken(result['token']);
        push.notifyEasyLogin('register');
      } else {
        isProfileUpdate = false;
        Map<String, dynamic> result = json.decode(data.body);
        setErrorMessages(result['errors']);
      }
    });
    return isProfileUpdate;
  }

  Future<bool> loginUser(
      {required String email, required String password}) async {
    isProfileUpdate = false;

    final Map<String, String> body = {
      'email': email,
      'password': password,
    };
    await Auth().login(body).then((data) {
      if (data.statusCode == 201) {
        Map<String, dynamic> result = json.decode(data.body);
        _saveToken(result['token']);
        dp.fetchDashBoard(result['token']);
        push.notifyEasyLogin('login');
        isProfileUpdate = true;
        setLoading(false);
      } else {
        Map<String, dynamic> result = json.decode(data.body);
        isProfileUpdate = false;
        setErrorLoginMessages(result['email']);
      }
    });
    return isProfileUpdate;
  }

  Future<bool> fetchUserProfile(String token) async {
    isFetchProfile = false;
    await Profile(token: token).profile().then((data) {
      if (data.statusCode == 201) {
        setUser(User.fromJson(jsonDecode(data.body)));
        isFetchProfile = true;
      }
    });
    return isFetchProfile;
  }

  Future<bool> OTPVerify({required String otp}) async {
    setLoading(true);
    final Map<String, String> body = {'otp': otp};

    await Auth()
        .verifyOTP(
      body: body,
      token: _token,
    )
        .then((data) {
      setLoading(false);
      if (data.statusCode == 201) {
        var response = jsonDecode(data.body);
        if (response['msg'] == 'user verified') {
          isVerify = true;
          fetchUserProfile(_token);
        }
      }
    });
    notifyListeners();
    return true;
  }

  Future<bool> OTPResend() async {
    setLoading(true);
    await Auth()
        .resendOTP(
      token: _token,
    )
        .then((data) {
      setLoading(false);
      if (data.statusCode == 201) {
        var response = jsonDecode(data.body);
        print(response);
        if (response['msg'] == 'OTP sent') {
          isResent = true;
        }
      }
    });
    notifyListeners();
    return true;
  }

  Future<bool> logout({required String token}) async {
    await Auth()
        .logout(
      token: _token,
    )
        .then((data) {
      setLoading(false);
      if (data.statusCode == 201) {
        _saveToken('unset');
        isLoggedout = true;
        push.notifyEasyLogin('logout');
      }
    });
    notifyListeners();
    return true;
  }

  Future<bool> updateUser(
      {required Map<String, dynamic> body, required String token}) async {
    setLoading(true);
    isProfileUpdate = false;
    await Profile(token: token).profileUpdate(body: body).then((data) {
      print(data.statusCode);
      setLoading(false);
      if (data.statusCode == 201) {
        isProfileUpdate = true;
        fetchUserProfile(token);
      } else {
        isProfileUpdate = false;
        print(data.body);
        Map<String, dynamic> result = json.decode(data.body);
        setErrorMessages(result['errors']);
      }
    });
    notifyListeners();
    return isProfileUpdate;
  }

  Future<bool> updateUserDBS(
      {required Map<String, dynamic> body, required String token}) async {
    setLoading(true);
    isProfileUpdate = false;
    await Profile(token: token).dbsUpdate(body: body).then((data) {
      setLoading(false);
      if (data.statusCode == 201) {
        isProfileUpdate = true;
        fetchUserProfile(token);
      } else {
        isProfileUpdate = false;
        print(data.body);
        Map<String, dynamic> result = json.decode(data.body);
        setErrorMessages(result['errors']);
      }
    });
    notifyListeners();
    return isProfileUpdate;
  }

  Future<bool> updateWorkHistory(
      {required Map<String, dynamic> body, required String token}) async {
    setLoading(true);
    isProfileUpdate = false;
    await Profile(token: token).workHistoryUpdate(body: body).then((data) {
      setLoading(false);
      if (data.statusCode == 201) {
        isProfileUpdate = true;
        fetchUserProfile(token);
      } else {
        isProfileUpdate = false;
        print(data.body);
        Map<String, dynamic> result = json.decode(data.body);
        setErrorMessages(result['errors']);
      }
    });
    notifyListeners();
    return isProfileUpdate;
  }

  Future<bool> updateQualification(
      {required Map<String, dynamic> body, required String token}) async {
    setLoading(true);
    isProfileUpdate = false;
    await Profile(token: token).qualificationUpdate(body: body).then((data) {
      setLoading(false);
      if (data.statusCode == 201) {
        isProfileUpdate = true;
        fetchUserProfile(token);
      } else {
        isProfileUpdate = false;
        print(data.body);
        Map<String, dynamic> result = json.decode(data.body);
        setErrorMessages(result['errors']);
      }
    });
    notifyListeners();
    return isProfileUpdate;
  }

  Future<bool> updateNextOfKin(
      {required Map<String, dynamic> body, required String token}) async {
    setLoading(true);
    isProfileUpdate = false;
    await Profile(token: token).nokUpdate(body: body).then((data) {
      setLoading(false);
      if (data.statusCode == 201) {
        isProfileUpdate = true;
        fetchUserProfile(token);
      } else {
        isProfileUpdate = false;
        print(data.body);
        Map<String, dynamic> result = json.decode(data.body);
        setErrorMessages(result['errors']);
      }
    });
    notifyListeners();
    return isProfileUpdate;
  }

  Future<bool> updateReference(
      {required Map<String, dynamic> body, required String token}) async {
    setLoading(true);
    isProfileUpdate = false;
    await Profile(token: token).refereesUpdate(body: body).then((data) {
      setLoading(false);
      if (data.statusCode == 201) {
        isProfileUpdate = true;
        fetchUserProfile(token);
      } else {
        isProfileUpdate = false;
        print(data.body);
        Map<String, dynamic> result = json.decode(data.body);
        setErrorMessages(result['errors']);
      }
    });
    notifyListeners();
    return isProfileUpdate;
  }

  void _saveToken(String _tk) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('token', _tk);
    _token = _tk;

    notifyListeners();
  }

  Future getToken() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    _token = preferences.getString('token') ?? 'unset';
    if (_token != 'unset' || _token != null) {
      await fetchUserProfile(_token);
    }

    notifyListeners();
  }

  String? get token => _token;

  void setErrorMessages(errors) {
    if (errors['email'] != null) {
      return _errMsgEmail = errors['email'][0];
    }
    if (errors['mobile'] != null) {
      return _errMsgEmail = errors['mobile'][0];
    }
    notifyListeners();
  }

  void setErrorLoginMessages(errors) {
    if (errors != null) {
      _errMsgEmail = errors;
    }
    notifyListeners();
  }

  String? getErrMsgEmail() {
    return _errMsgEmail;
  }

  void setLoading(value) {
    loading = value;
    notifyListeners();
  }

  bool isLoading() {
    return loading;
  }

  bool isRegistered() {
    return _token != 'unset' ? true : false;
  }

  void setUser(value) {
    _user = value;
    notifyListeners();
  }

  User? getUser() {
    return _user;
  }
}
