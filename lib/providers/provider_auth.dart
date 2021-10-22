import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:cama/api/auth.dart';
import 'package:cama/api/profile.dart';
import 'package:cama/models/user.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthProvider extends ChangeNotifier {
  bool loading = false;
  String? _errMsgEmail;
  String _token = 'unset';
  User? _user;
  bool isVerify = false;
  bool isResent = false;
  bool isProfileUpdate = false;

  AuthProvider() {
    getToken();
  }

  Future<bool> createUser(
      {required String firstName,
      required String lastName,
      required String email,
      required String mobile,
      required String password,
      required String confirmPassword,
      required String staffType}) async {
    setLoading(true);
    final Map<String, String> body = {
      'first_name': firstName,
      'last_name': lastName,
      'email': email,
      'mobile': mobile,
      'password': password,
      'password_confirmation': confirmPassword,
      'staff_type': staffType,
    };
    await Auth().register(body).then((data) {
      setLoading(false);

      if (data.statusCode == 201) {
        Map<String, dynamic> result = json.decode(data.body);

        _saveToken(result['token']);
      } else {
        Map<String, dynamic> result = json.decode(data.body);
        setErrorMessages(result['errors']);
      }
    });
    return isRegistered();
  }

  Future<bool> loginUser(
      {required String email, required String password}) async {
    setLoading(true);
    final Map<String, String> body = {
      'email': email,
      'password': password,
    };
    await Auth().login(body).then((data) {
      setLoading(false);

      if (data.statusCode == 201) {
        Map<String, dynamic> result = json.decode(data.body);

        _saveToken(result['token']);
      } else {
        Map<String, dynamic> result = json.decode(data.body);
        print(result['email']);
        setErrorLoginMessages(result['email']);
      }
    });
    return isRegistered();
  }

  Future<bool> fetchUserProfile(String token) async {
    setLoading(true);
    bool status = false;
    await Profile(token: token).profile().then((data) {
      setLoading(false);
      if (data.statusCode == 201) {
        setUser(User.fromJson(jsonDecode(data.body)));
        status = true;
      }
    });
    return status;
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
    setLoading(true);

    await Auth()
        .logout(
      token: _token,
    )
        .then((data) {
      setLoading(false);
      if (data.statusCode == 201) {
        _saveToken('unset');
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

  void _saveToken(String _tk) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('token', _tk);
    _token = _tk;
    notifyListeners();
  }

  Future getToken() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    _token = preferences.getString('token') ?? 'unset';

    await fetchUserProfile(_token);
    notifyListeners();
  }

  String? get token => _token;

  void setErrorMessages(errors) {
    if (errors['email'] != null) {
      _errMsgEmail = errors['email'][0];
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
