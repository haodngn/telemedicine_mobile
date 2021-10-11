class HealthCheckDisease {
  late int id;
  late int healthCheckId;
  late int diseaseId;
  late bool isActive;

  // late Disease disease;

  HealthCheckDisease(
      {required this.id,
      required this.healthCheckId,
      required this.diseaseId,
      required this.isActive,
      // required this.disease
      });

  HealthCheckDisease.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    healthCheckId = json['healthCheckId'];
    diseaseId = json['diseaseId'];
    isActive = json['isActive'];
    // disease =
    //     json['disease'] != null ? new Disease.fromJson(json['disease']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['healthCheckId'] = this.healthCheckId;
    data['diseaseId'] = this.diseaseId;
    data['isActive'] = this.isActive;
    // if (this.disease != null) {
    //   data['disease'] = this.disease.toJson();
    // }
    return data;
  }
}
