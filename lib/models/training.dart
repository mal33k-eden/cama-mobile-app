class MyTraining {
  int id;
  String name;
  String expires_on;
  String file;
  String file_extension;

  MyTraining(
      {required this.id,
      required this.name,
      required this.expires_on,
      required this.file,
      required this.file_extension});
  factory MyTraining.fromJson(Map<String, dynamic> json) {
    return MyTraining(
        name: json['name'],
        expires_on: json['expires_on'],
        file: json['certificate'],
        file_extension: json['file_extension'],
        id: json['id']);
  }
}
