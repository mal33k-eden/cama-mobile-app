import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:path/path.dart';

class FilesApi {
  var baseUrl = dotenv.env['BASE_URL']! + 'files/';
  var headers = null;
  final String token;

  FilesApi({required this.token});

  Future<http.Response> docs() async {
    return await http.get(
      Uri.parse(baseUrl + 'allDocuments'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'Accept': 'application/json',
        'Authorization': 'Bearer $token',
      },
    );
  }

  Future<http.Response> trainings() async {
    return await http.get(
      Uri.parse(baseUrl + 'allTrainings'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'Accept': 'application/json',
        'Authorization': 'Bearer $token',
      },
    );
  }

  Future<http.Response> documentUpload(
      {required Map<String, dynamic> body}) async {
    final Map<String, String> _headers = {
      'Accept': 'application/json',
      'Authorization': 'Bearer $token',
    };
    // string to uri
    var uri = Uri.parse(baseUrl + 'updateDoc');
    var request = http.MultipartRequest('POST', uri);
    request.headers.addAll(_headers);

    if (body.containsKey('file')) {
      File? image = body['file'];
      var stream = new http.ByteStream(image!.openRead());
      stream.cast();
      var length = await image.length();
      var file = new http.MultipartFile("file", stream, length,
          filename: basename(image.path));
      request.files.add(file);
      // body.remove('certificate');
      body.remove('file');
    }

    final Map<String, String> newBody =
        body.map((key, value) => MapEntry(key, value.toString()));
    request.fields.addAll(newBody);
    var streamedResponse = await request.send();
    return await http.Response.fromStream(streamedResponse);
  }

  Future<http.Response> trainingUpload(
      {required Map<String, dynamic> body}) async {
    final Map<String, String> _headers = {
      'Accept': 'application/json',
      'Authorization': 'Bearer $token',
    };
    // string to uri
    var uri = Uri.parse(baseUrl + 'updateTraining');
    var request = http.MultipartRequest('POST', uri);
    request.headers.addAll(_headers);

    if (body.containsKey('certificate')) {
      File? image = body['certificate'];
      var stream = new http.ByteStream(image!.openRead());
      stream.cast();
      var length = await image.length();
      var file = new http.MultipartFile("certificate", stream, length,
          filename: basename(image.path));
      request.files.add(file);
      // body.remove('certificate');
      body.remove('certificate');
    }

    final Map<String, String> newBody =
        body.map((key, value) => MapEntry(key, value.toString()));
    request.fields.addAll(newBody);
    var streamedResponse = await request.send();
    return await http.Response.fromStream(streamedResponse);
  }
}
