class District {
  late String name;
  late int code;
  late String codename;
  late String division_type;
  late int province_code;
  late String wards;

  District(
      {required this.name,
      required this.code,
      required this.codename,
      required this.division_type,
      required this.province_code,
      required this.wards});

  // District.fromJSon(Map<String, dynamic> json) {
  //   name = json['name'];
  //   code = json['code'];
  //   division_type = json['division_type'];
  //   phone_code = json['phone_code'];
  //   codename = json['codename'];
  //   districts = json['districts'];
  // }
  //
  // Map<String, dynamic> toJson() {
  //   final Map<String, dynamic> data = new Map<String, dynamic>();
  //   data['name'] = this.name;
  //   data['code'] = this.code;
  //   data['division_type'] = this.division_type;
  //   data['phone_code'] = this.phone_code;
  //   data['codename'] = this.codename;
  //   data['districts'] = this.districts;
  //   return data;
  // }
}
