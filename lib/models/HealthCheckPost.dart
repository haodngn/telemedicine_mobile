import 'package:telemedicine_mobile/models/SymptomHealthCheckPost.dart';

class HealthCheckPost {
  late int height;
  late int weight;
  late int patientId;
  late int slotId;
  late List<SymptomHealthCheckPost> symptomHealthChecks = [];

  HealthCheckPost(
      {required this.height,
      required this.weight,
      required this.patientId,
      required this.slotId,
      required this.symptomHealthChecks});

  HealthCheckPost.fromJson(Map<String, dynamic> json) {
    height = json['height'];
    weight = json['weight'];
    patientId = json['patientId'];
    slotId = json['slotId'];
    if (json['symptomHealthChecks'] != null) {
      json['symptomHealthChecks'].forEach((v) {
        symptomHealthChecks.add(new SymptomHealthCheckPost.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['height'] = this.height;
    data['weight'] = this.weight;
    data['patientId'] = this.patientId;
    data['slotId'] = this.slotId;
    data['symptomHealthChecks'] =
        this.symptomHealthChecks.map((v) => v.toJson()).toList();

    return data;
  }
}
