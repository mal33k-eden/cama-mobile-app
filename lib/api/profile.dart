import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:path/path.dart';

class Profile {
  var baseUrl = dotenv.env['BASE_URL']! + 'profile/';
  var headers = null;
  final String token;

  Profile({required this.token});

  Future<http.Response> profile() async {
    return await http.get(
      Uri.parse(baseUrl + 'summary'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'Accept': 'application/json',
        'Authorization': 'Bearer $token',
      },
    );
  }

  Future<http.Response> profileUpdate(
      {required Map<String, dynamic> body}) async {
    final Map<String, String> _headers = {
      // 'Content-Type': 'application/json; charset=UTF-8',
      'Accept': 'application/json',
      'Authorization': 'Bearer $token',
    };
    // string to uri
    var uri = Uri.parse(baseUrl + 'update');
    var request = http.MultipartRequest('POST', uri);
    request.headers.addAll(_headers);

    if (body.containsKey('photo')) {
      File? image = body['photo'];
      var stream = new http.ByteStream(image!.openRead());
      stream.cast();
      var length = await image.length();
      var photo = new http.MultipartFile("photo", stream, length,
          filename: basename(image.path));
      request.files.add(photo);
      body.remove('photo');
    }
    request.fields['formdata'] = jsonEncode(body);

    var streamedResponse = await request.send();
    return await http.Response.fromStream(streamedResponse);
  }

  Future<http.Response> dbsUpdate({required Map<String, dynamic> body}) async {
    final Map<String, String> _headers = {
      // 'Content-Type': 'application/json; charset=UTF-8',
      'Accept': 'application/json',
      'Authorization': 'Bearer $token',
    };
    // string to uri
    var uri = Uri.parse(baseUrl + 'dbs/update');
    var request = http.MultipartRequest('POST', uri);
    request.headers.addAll(_headers);

    if (body.containsKey('certificate')) {
      File? image = body['certificate'];
      var stream = new http.ByteStream(image!.openRead());
      stream.cast();
      var length = await image.length();
      var photo = new http.MultipartFile("certificate", stream, length,
          filename: basename(image.path));
      request.files.add(photo);
      // body.remove('certificate');
      body.remove('certificate');
    }

    final Map<String, String> newBody =
        body.map((key, value) => MapEntry(key, value.toString()));
    request.fields.addAll(newBody);
    //request.fields['formdata'] = jsonEncode(body);

    var streamedResponse = await request.send();
    return await http.Response.fromStream(streamedResponse);
  }

  Future<http.Response> workHistoryUpdate(
      {required Map<String, dynamic> body}) async {
    return http.post(
      Uri.parse(baseUrl + 'work-history/update'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'Accept': 'application/json',
        'Authorization': 'Bearer $token',
      },
      body: jsonEncode(body),
    );
  }

  Future<http.Response> qualificationUpdate(
      {required Map<String, dynamic> body}) async {
    return http.post(
      Uri.parse(baseUrl + 'qualification/update'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'Accept': 'application/json',
        'Authorization': 'Bearer $token',
      },
      body: jsonEncode(body),
    );
  }

  Future<http.Response> nokUpdate({required Map<String, dynamic> body}) async {
    return http.post(
      Uri.parse(baseUrl + 'nok/update'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'Accept': 'application/json',
        'Authorization': 'Bearer $token',
      },
      body: jsonEncode(body),
    );
  }

  Future<http.Response> refereesUpdate(
      {required Map<String, dynamic> body}) async {
    return http.post(
      Uri.parse(baseUrl + 'referee/update'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'Accept': 'application/json',
        'Authorization': 'Bearer $token',
      },
      body: jsonEncode(body),
    );
  }
}
