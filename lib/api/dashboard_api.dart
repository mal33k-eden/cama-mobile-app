import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:path/path.dart';

class DashboardApi {
  var baseUrl = dotenv.env['BASE_URL']! + 'dashboard';
  var headers = null;
  final String token;

  DashboardApi({required this.token});

  Future<http.Response> dashboard() async {
    return await http.get(
      Uri.parse(baseUrl),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'Accept': 'application/json',
        'Authorization': 'Bearer $token',
      },
    );
  }
}
