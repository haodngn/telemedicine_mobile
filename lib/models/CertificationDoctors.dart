import 'package:telemedicine_mobile/models/Certification.dart';

class CertificationDoctors {
  late int id;
  late int doctorId;
  late int certificationId;
  late String evidence;
  late String dateOfIssue;
  late Certification certification;

  CertificationDoctors(
      {required this.id,
      required this.doctorId,
      required this.certificationId,
      required this.evidence,
      required this.dateOfIssue,
      required this.certification});

  CertificationDoctors.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    doctorId = json['doctorId'];
    certificationId = json['certificationId'];
    evidence = json['evidence'];
    dateOfIssue = json['dateOfIssue'];
    if (json['certification'] != null) {
      certification = new Certification.fromJson(json['certification']);
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['doctorId'] = this.doctorId;
    data['certificationId'] = this.certificationId;
    data['evidence'] = this.evidence;
    data['dateOfIssue'] = this.dateOfIssue;
    if (this.certification != null) {
      data['certification'] = this.certification.toJson();
    }
    return data;
  }
}