import 'package:telemedicine_mobile/models/Districts.dart';

class Province {
  late String name;
  late int code;
  late String codename;
  late String divisionType;
  late int phoneCode;
  late List<Districts> districts = [];

  Province(
      {required this.name,
        required this.code,
        required this.codename,
        required this.divisionType,
        required this.phoneCode,
        required this.districts});

  Province.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    code = json['code'];
    codename = json['codename'];
    divisionType = json['division_type'];
    phoneCode = json['phone_code'];
    if (json['districts'] != null) {
      json['districts'].forEach((v) {
        districts.add(new Districts.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    data['code'] = this.code;
    data['codename'] = this.codename;
    data['division_type'] = this.divisionType;
    data['phone_code'] = this.phoneCode;
    if (this.districts != null) {
      data['districts'] = this.districts.map((v) => v.toJson()).toList();
    }
    return data;
  }
}