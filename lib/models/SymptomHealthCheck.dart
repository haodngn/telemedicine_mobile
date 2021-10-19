import 'package:telemedicine_mobile/models/Symptom.dart';

class SymptomHealthCheck {
  late int id;
  late int symptomId;
  late int healthCheckId;
  late String evidence;
  late bool isActive;
  late Symptom symptom;

  SymptomHealthCheck(
      {required this.id,
      required this.symptomId,
      required this.healthCheckId,
      required this.evidence,
      required this.isActive,
      required this.symptom});

  SymptomHealthCheck.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    symptomId = json['symptomId'];
    healthCheckId = json['healthCheckId'];
    evidence = json['evidence'];
    isActive = json['isActive'];
    if (json['symptom'] != null) {
      symptom = new Symptom.fromJson(json['symptom']);
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['symptomId'] = this.symptomId;
    data['healthCheckId'] = this.healthCheckId;
    data['evidence'] = this.evidence;
    data['isActive'] = this.isActive;
    if (this.symptom != null) {
      data['symptom'] = this.symptom.toJson();
    }
    return data;
  }
}
