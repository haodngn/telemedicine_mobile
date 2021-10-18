import 'package:telemedicine_mobile/models/SymptomHealthCheck.dart';

class HealthCheckPost {
  late int height;
  late int weight;
  late String token;
  late int patientId;
  late int slotId;
  late List<SymptomHealthCheck> symptomHealthChecks = [];

  HealthCheckPost(
      {required this.height,
      required this.weight,
      required this.token,
      required this.patientId,
      required this.slotId,
      required this.symptomHealthChecks});

  HealthCheckPost.fromJson(Map<String, dynamic> json) {
    height = json['height'];
    weight = json['weight'];
    token = json['token'];
    patientId = json['patientId'];
    slotId = json['slotId'];
    if (json['symptomHealthChecks'] != null) {
      json['symptomHealthChecks'].forEach((v) {
        symptomHealthChecks.add(new SymptomHealthCheck.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['height'] = this.height;
    data['weight'] = this.weight;
    data['token'] = this.token;
    data['patientId'] = this.patientId;
    data['slotId'] = this.slotId;
    if (this.symptomHealthChecks != null) {
      data['symptomHealthChecks'] =
          this.symptomHealthChecks.map((v) => v.toJson()).toList();
    }
    return data;
  }
}
