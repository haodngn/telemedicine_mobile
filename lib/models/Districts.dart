import 'package:telemedicine_mobile/models/Wards.dart';

class Districts {
  late String name;
  late int code;
  late String codename;
  late String divisionType;
  late String shortCodename;
  late List<Wards> wards = [];

  Districts(
      {required this.name,
        required this.code,
        required this.codename,
        required this.divisionType,
        required this.shortCodename,
        required this.wards});

  Districts.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    code = json['code'];
    codename = json['codename'];
    divisionType = json['division_type'];
    shortCodename = json['short_codename'];
    if (json['wards'] != null) {
      json['wards'].forEach((v) {
        wards.add(new Wards.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    data['code'] = this.code;
    data['codename'] = this.codename;
    data['division_type'] = this.divisionType;
    data['short_codename'] = this.shortCodename;
    if (this.wards != null) {
      data['wards'] = this.wards.map((v) => v.toJson()).toList();
    }
    return data;
  }
}