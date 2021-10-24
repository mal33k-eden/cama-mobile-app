import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'dart:convert';
import 'dart:io';
import 'package:path/path.dart';
import 'package:http/http.dart' as http;

class Agency {
  var baseUrl = dotenv.env['BASE_URL']! + 'agency/';
  var headers = null;
  final String token;

  Agency({required this.token});

  Future<http.Response> myAgencies() async {
    return await http.get(
      Uri.parse(baseUrl + 'all'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'Accept': 'application/json',
        'Authorization': 'Bearer $token',
      },
    );
  }

  Future<http.Response> submitDoc({required Map<String, dynamic> body}) async {
    final Map<String, String> _headers = {
      // 'Content-Type': 'application/json; charset=UTF-8',
      'Accept': 'application/json',
      'Authorization': 'Bearer $token',
    };
    // string to uri
    var uri = Uri.parse(baseUrl + 'submitDoc');
    var request = http.MultipartRequest('POST', uri);
    request.headers.addAll(_headers);

    if (body.containsKey('file')) {
      File? image = body['file'];
      var stream = new http.ByteStream(image!.openRead());
      stream.cast();
      var length = await image.length();
      var photo = new http.MultipartFile("file", stream, length,
          filename: basename(image.path));
      request.files.add(photo);
      body.remove('file');
    }
    final Map<String, String> newBody =
        body.map((key, value) => MapEntry(key, value.toString()));
    request.fields.addAll(newBody);

    var streamedResponse = await request.send();
    return await http.Response.fromStream(streamedResponse);
  }

  Future<http.Response> submitTraining(
      {required Map<String, dynamic> body}) async {
    final Map<String, String> _headers = {
      // 'Content-Type': 'application/json; charset=UTF-8',
      'Accept': 'application/json',
      'Authorization': 'Bearer $token',
    };
    // string to uri
    var uri = Uri.parse(baseUrl + 'submitTraining');
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
      body.remove('certificate');
    }
    final Map<String, String> newBody =
        body.map((key, value) => MapEntry(key, value.toString()));
    request.fields.addAll(newBody);

    var streamedResponse = await request.send();
    return await http.Response.fromStream(streamedResponse);
  }

  Future<http.Response> attachDoc({required Map<String, dynamic> body}) async {
    return http.post(
      Uri.parse(baseUrl + 'attachDoc'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'Accept': 'application/json',
        'Authorization': 'Bearer $token',
      },
      body: jsonEncode(body),
    );
  }

  Future<http.Response> profileActions(
      {required Map<String, dynamic> body}) async {
    return http.post(
      Uri.parse(baseUrl + 'profile-action'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'Accept': 'application/json',
        'Authorization': 'Bearer $token',
      },
      body: jsonEncode(body),
    );
  }

  Future<http.Response> attachTraining(
      {required Map<String, dynamic> body}) async {
    return http.post(
      Uri.parse(baseUrl + 'attachTraining'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'Accept': 'application/json',
        'Authorization': 'Bearer $token',
      },
      body: jsonEncode(body),
    );
  }
}
