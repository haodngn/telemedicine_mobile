import 'package:telemedicine_mobile/models/Doctor.dart';
import 'package:telemedicine_mobile/models/HealthCheck.dart';
import 'package:telemedicine_mobile/models/Patient.dart';

class Slot {
  late int id;
  late String assignedDate;
  late int doctorId;
  late Doctor doctor;
  late String startTime;
  late String endTime;
  late bool isActive;
  late int? healthCheckID;
  late HealthCheck healthCheck;

  Slot({
    required this.id,
    required this.assignedDate,
    required this.doctorId,
    required this.doctor,
    required this.startTime,
    required this.endTime,
    required this.isActive,
    required this.healthCheckID,
    required this.healthCheck,
  });

  Slot.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    assignedDate = json['assignedDate'];
    doctorId = json['doctorId'];
    if (json['doctor'] != null) {
      doctor = new Doctor.fromJson(json['doctor']);
    }
    startTime = json['startTime'];
    endTime = json['endTime'];
    isActive = json['isActive'];
    if (json['healthCheckId'] == null) {
      healthCheckID = 0;
    } else {
      healthCheckID = json['healthCheckId'];
    }
    if (json['healthCheck'] != null) {
      healthCheck = new HealthCheck.fromJson(json['healthCheck']);
    } else {
      healthCheck = new HealthCheck(
          id: 0,
          height: 0,
          weight: 0,
          reasonCancel: "",
          rating: 0,
          comment: "",
          advice: "",
          token: "",
          patientId: 0,
          createdTime: "",
          canceledTime: "",
          status: "",
          patient: new Patient(
              id: 0,
              email: "",
              name: "",
              avatar: "",
              backgroundDisease: "",
              allergy: "",
              bloodGroup: "",
              isActive: true,
              healthChecks: []),
          healthCheckDiseases: [],
          prescriptions: [],
          slots: [],
          symptomHealthChecks: []);
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['assignedDate'] = this.assignedDate;
    data['doctorId'] = this.doctorId;
    if (this.doctor != null) {
      data['doctor'] = this.doctor.toJson();
    }
    data['startTime'] = this.startTime;
    data['endTime'] = this.endTime;
    data['isActive'] = this.isActive;
    data['healthCheckId'] = this.healthCheckID;
    if (this.healthCheck != null) {
      data['healthCheck'] = this.healthCheck.toJson();
    }
    return data;
  }
}
