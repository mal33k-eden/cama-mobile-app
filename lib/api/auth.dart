import 'dart:convert';
import 'package:cama/models/user.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_dotenv/flutter_dotenv.dart';

class Auth {
  var baseUrl = dotenv.env['BASE_URL'];
  var headers = null;

  Future<http.Response> register(Map<String, String> body) {
    return http.post(
      Uri.parse(baseUrl! + 'register'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'Accept': 'application/json',
      },
      body: jsonEncode(body),
    );
  }

  Future<http.Response> login(Map<String, String> body) async {
    return await http.post(
      Uri.parse(baseUrl! + 'login'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'Accept': 'application/json',
      },
      body: jsonEncode(body),
    );
  }

  Future<http.Response> resendOTP({required String token}) async {
    return await http.post(
      Uri.parse(baseUrl! + 'verify/resend'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'Accept': 'application/json',
        'Authorization': 'Bearer $token',
      },
    );
  }

  Future<http.Response> verifyOTP(
      {required Map<String, String> body, required String token}) {
    print(body);
    return http.post(
      Uri.parse(baseUrl! + 'verify'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'Accept': 'application/json',
        'Authorization': 'Bearer $token',
      },
      body: jsonEncode(body),
    );
  }

  Future<http.Response> logout({required String token}) {
    return http.post(
      Uri.parse(baseUrl! + 'logout'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'Accept': 'application/json',
        'Authorization': 'Bearer $token',
      },
    );
  }
}
