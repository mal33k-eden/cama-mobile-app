import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:path/path.dart';

class ShiftApi {
  var baseUrl = dotenv.env['BASE_URL']! + 'shifts/';
  var headers = null;
  final String token;

  ShiftApi({required this.token});

  Future<http.Response> calendar({required Map<String, dynamic> body}) async {
    return await http.post(
      Uri.parse(baseUrl + 'calendar'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'Accept': 'application/json',
        'Authorization': 'Bearer $token',
      },
      body: jsonEncode(body),
    );
  }

  Future<http.Response> pool(page) async {
    return await http.get(
      Uri.parse(baseUrl + 'pool?page=${page}'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'Accept': 'application/json',
        'Authorization': 'Bearer $token',
      },
    );
  }

  Future<http.Response> unconfirmed() async {
    return await http.get(
      Uri.parse(baseUrl + 'unconfirmed'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'Accept': 'application/json',
        'Authorization': 'Bearer $token',
      },
    );
  }

  Future<http.Response> decline({required Map<String, dynamic> body}) async {
    return http.post(
      Uri.parse(baseUrl + 'decline'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'Accept': 'application/json',
        'Authorization': 'Bearer $token',
      },
      body: jsonEncode(body),
    );
  }

  Future<http.Response> poolPick({required Map<String, dynamic> body}) async {
    return http.post(
      Uri.parse(baseUrl + 'pool/pick'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'Accept': 'application/json',
        'Authorization': 'Bearer $token',
      },
      body: jsonEncode(body),
    );
  }

  Future<http.Response> confirm({required Map<String, dynamic> body}) async {
    return http.post(
      Uri.parse(baseUrl + 'confirm'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'Accept': 'application/json',
        'Authorization': 'Bearer $token',
      },
      body: jsonEncode(body),
    );
  }

  Future<http.Response> timesheets() async {
    return await http.get(
      Uri.parse(baseUrl + 'timesheets'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'Accept': 'application/json',
        'Authorization': 'Bearer $token',
      },
    );
  }

  Future<http.Response> timesheetUpload(
      {required Map<String, dynamic> body}) async {
    final Map<String, String> _headers = {
      'Accept': 'application/json',
      'Authorization': 'Bearer $token',
    };
    // string to uri
    var uri = Uri.parse(baseUrl + 'timesheets/upload');
    var request = http.MultipartRequest('POST', uri);
    request.headers.addAll(_headers);

    if (body.containsKey('timesheet')) {
      File? image = body['timesheet'];
      var stream = new http.ByteStream(image!.openRead());
      stream.cast();
      var length = await image.length();
      var file = new http.MultipartFile("timesheet", stream, length,
          filename: basename(image.path));
      request.files.add(file);
      // body.remove('certificate');
      body.remove('timesheet');
    }

    final Map<String, String> newBody =
        body.map((key, value) => MapEntry(key, value.toString()));
    request.fields.addAll(newBody);
    var streamedResponse = await request.send();
    return await http.Response.fromStream(streamedResponse);
  }
}
