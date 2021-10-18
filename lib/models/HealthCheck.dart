import 'package:telemedicine_mobile/models/HealthCheckDisease.dart';
import 'package:telemedicine_mobile/models/Patient.dart';
import 'package:telemedicine_mobile/models/Prescription.dart';
import 'package:telemedicine_mobile/models/Slot.dart';
import 'package:telemedicine_mobile/models/SymptomHealthCheck.dart';

class HealthCheck {
  late int id;
  late int height;
  late int weight;
  late String reasonCancel;
  late int rating;
  late String comment;
  late String advice;
  late String token;
  late int patientId;
  late String createdTime;
  late String canceledTime;
  late String status;
  late Patient patient;
  late List<HealthCheckDisease> healthCheckDiseases = [];
  late List<Prescription> prescriptions = [];
  late List<Slot> slots = [];
  late List<SymptomHealthCheck> symptomHealthChecks = [];

  HealthCheck(
      {required this.id,
      required this.height,
      required this.weight,
      required this.reasonCancel,
      required this.rating,
      required this.comment,
      required this.advice,
      required this.token,
      required this.patientId,
      required this.createdTime,
      required this.canceledTime,
      required this.status,
      required this.patient,
      required this.healthCheckDiseases,
      required this.prescriptions,
      required this.slots,
      required this.symptomHealthChecks
      });

  HealthCheck.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    height = json['height'];
    weight = json['weight'];
    reasonCancel = json['reasonCancel'];
    rating = json['rating'];
    comment = json['comment'];
    advice = json['advice'];
    token = json['token'];
    patientId = json['patientId'];
    createdTime = json['createdTime'];
    canceledTime = json['canceledTime'];
    status = json['status'];
    if (json['patient'] != null) {
      patient = new Patient.fromJson(json['patient']);
    }
    if (json['healthCheckDiseases'] != null) {
      json['healthCheckDiseases'].forEach((v) {
        healthCheckDiseases.add(new HealthCheckDisease.fromJson(v));
      });
    }
    if (json['prescriptions'] != null) {
      json['prescriptions'].forEach((v) {
        prescriptions.add(new Prescription.fromJson(v));
      });
    }
    if (json['slots'] != null) {
      json['slots'].forEach((v) {
        slots.add(new Slot.fromJson(v));
      });
    }
    if (json['symptomHealthChecks'] != null) {
      json['symptomHealthChecks'].forEach((v) {
        symptomHealthChecks.add(new SymptomHealthCheck.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['height'] = this.height;
    data['weight'] = this.weight;
    data['reasonCancel'] = this.reasonCancel;
    data['rating'] = this.rating;
    data['comment'] = this.comment;
    data['advice'] = this.advice;
    data['token'] = this.token;
    data['patientId'] = this.patientId;
    data['createdTime'] = this.createdTime;
    data['canceledTime'] = this.canceledTime;
    data['status'] = this.status;
    if (this.patient != null) {
      data['patient'] = this.patient.toJson();
    }
    if (this.healthCheckDiseases != null) {
      data['healthCheckDiseases'] =
          this.healthCheckDiseases.map((v) => v.toJson()).toList();
    }
    if (this.prescriptions != null) {
      data['prescriptions'] =
          this.prescriptions.map((v) => v.toJson()).toList();
    }
    if (this.slots != null) {
      data['slots'] = this.slots.map((v) => v.toJson()).toList();
    }
    if (this.symptomHealthChecks != null) {
      data['symptomHealthChecks'] =
          this.symptomHealthChecks.map((v) => v.toJson()).toList();
    }
    return data;
  }
}
