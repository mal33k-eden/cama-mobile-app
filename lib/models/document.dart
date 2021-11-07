import 'package:flutter_dotenv/flutter_dotenv.dart';

class MyDocument {
  int id;
  String name;
  String expires_on;
  String file;
  String file_extension;

  MyDocument(
      {required this.id,
      required this.name,
      required this.expires_on,
      required this.file,
      required this.file_extension});
  factory MyDocument.fromJson(Map<String, dynamic> json) {
    return MyDocument(
      name: json['name'],
      expires_on: json['expires_on'],
      file: dotenv.env['STAFF_DOC_URL']! + json['file'],
      file_extension: json['file_extension'],
      id: json['id'],
    );
  }
}
