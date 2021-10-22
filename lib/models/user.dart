class User {
  String first_name;
  String last_name;
  String email;
  String mobile;
  String telephone;
  String postcode;
  String region;
  String address;
  String nationality;
  String town;
  String highest_qualification;
  String date_of_birth;
  String photo;
  String compulsory_checks;
  String agent_type;
  String email_verified_at;
  List<dynamic> references = [];
  List<dynamic> work_history = [];
  List<dynamic> qualifications = [];
  Map dbs = {};
  Map nextOfKin = {};
  String ProfileStatus = 'Incomplete';

  User({
    required this.first_name,
    required this.last_name,
    required this.email,
    required this.mobile,
    required this.telephone,
    required this.compulsory_checks,
    required this.agent_type,
    required this.email_verified_at,
    required this.nationality,
    required this.address,
    required this.region,
    required this.postcode,
    required this.town,
    required this.highest_qualification,
    required this.photo,
    required this.date_of_birth,
    required this.references,
    required this.work_history,
    required this.qualifications,
    required this.dbs,
    required this.nextOfKin,
    required this.ProfileStatus,
  });

  factory User.fromJson(Map<String, dynamic> data) {
    var json = data['data']['profile_summary'];
    String details = 'Incomplete';
    if (json['date_of_birth'] != null &&
        json['highest_qualification'] != null &&
        json['nationality'] != null &&
        json['address'] != null &&
        json['postcode'] != null &&
        json['region'] != null) {
      details = 'Complete';
    }
    return User(
      agent_type: json['agent_type']['name'],
      compulsory_checks: json['compulsory_checks'],
      email: json['email'],
      first_name: json['first_name'],
      last_name: json['last_name'],
      mobile: json['mobile'],
      email_verified_at: json['email_verified_at'],
      address: json['address'],
      nationality: json['nationality'],
      town: json['town'],
      postcode: json['postcode'],
      region: json['region'],
      telephone: json['telephone'],
      highest_qualification: json['highest_qualification'],
      date_of_birth: json['date_of_birth'],
      photo: json['photo'],
      references: json['reference'],
      dbs: json['dbs'],
      nextOfKin: json['next_of_kin'],
      qualifications: json['qualifications'],
      work_history: json['work_history'],
      ProfileStatus: details,
    );
  }
}
