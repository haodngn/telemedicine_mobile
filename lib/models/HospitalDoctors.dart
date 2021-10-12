import 'package:telemedicine_mobile/models/Hospital.dart';

class HospitalDoctors {
  late int id;
  late int doctorId;
  late int hospitalId;
  late bool isWorking;
  late Hospital hospital;

  HospitalDoctors(
      {required this.id,
      required this.doctorId,
      required this.hospitalId,
      required this.isWorking,
      required this.hospital
      });

  HospitalDoctors.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    doctorId = json['doctorId'];
    hospitalId = json['hospitalId'];
    isWorking = json['isWorking'];
    if (json['hospital'] != null) {
      hospital = new Hospital.fromJson(json['hospital']);
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['doctorId'] = this.doctorId;
    data['hospitalId'] = this.hospitalId;
    data['isWorking'] = this.isWorking;
    if (this.hospital != null) {
      data['hospital'] = this.hospital.toJson();
    }
    return data;
  }
}
