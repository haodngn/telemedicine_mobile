import 'package:telemedicine_mobile/models/HealthCheck.dart';

class Patient {
  late int id;
  late String email;
  late String name;
  late String avatar;
  late String backgroundDisease;
  late String allergy;
  late String bloodGroup;
  late bool isActive;
  late List<HealthCheck> healthChecks = [];

  Patient(
      {required this.id,
      required this.email,
      required this.name,
      required this.avatar,
      required this.backgroundDisease,
      required this.allergy,
      required this.bloodGroup,
      required this.isActive,
      required this.healthChecks});

  Patient.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    email = json['email'];
    name = json['name'];
    avatar = json['avatar'];
    backgroundDisease = json['backgroundDisease'];
    allergy = json['allergy'];
    bloodGroup = json['bloodGroup'];
    isActive = json['isActive'];
    if (json['healthChecks'] != null) {
      json['healthChecks'].forEach((v) {
        healthChecks.add(new HealthCheck.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['email'] = this.email;
    data['name'] = this.name;
    data['avatar'] = this.avatar;
    data['backgroundDisease'] = this.backgroundDisease;
    data['allergy'] = this.allergy;
    data['bloodGroup'] = this.bloodGroup;
    data['isActive'] = this.isActive;
    if (this.healthChecks != null) {
      data['healthChecks'] = this.healthChecks.map((v) => v.toJson()).toList();
    }
    return data;
  }
}
