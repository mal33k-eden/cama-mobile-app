class MyAgency {
  String name;
  String short_name;
  String email;
  String mobile;
  String telephone;
  String status;
  String policy_status;
  String profile_code;
  int profile_update_permission;
  String postcode;
  String address;
  String town;
  String logo;
  List<dynamic> required_docs = [];
  List<dynamic> required_trainings = [];

  MyAgency(
      {required this.name,
      required this.short_name,
      required this.email,
      required this.mobile,
      required this.telephone,
      required this.status,
      required this.policy_status,
      required this.profile_code,
      required this.profile_update_permission,
      required this.address,
      required this.postcode,
      required this.logo,
      required this.required_docs,
      required this.required_trainings,
      required this.town});

  factory MyAgency.fromJson(Map<String, dynamic> data) {
    var json = data['agency'];

    return MyAgency(
        name: json['name'],
        short_name: json['short_name'],
        email: json['email'],
        mobile: json['mobile'],
        telephone: json['telephone'],
        status: json['status'],
        policy_status: json['policy_status'],
        profile_code: json['profile_code'],
        profile_update_permission: json['profile_update_permission'],
        address: json['address'],
        postcode: json['postcode'],
        logo: json['logo'],
        required_docs: json['required-docs'],
        required_trainings: json['required-trainings'],
        town: json['town']);
  }
}
