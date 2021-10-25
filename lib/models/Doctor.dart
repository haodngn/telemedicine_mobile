import 'package:telemedicine_mobile/models/CertificationDoctors.dart';
import 'package:telemedicine_mobile/models/HospitalDoctors.dart';
import 'package:telemedicine_mobile/models/MajorDoctors.dart';

class Doctor {
  late int id;
  late String email;
  late String name;
  late String avatar;
  late String practisingCertificate;
  late String certificateCode;
  late String placeOfCertificate;
  late String dateOfCertificate;
  late String scopeOfPractice;
  late String description;
  late int numberOfConsultants;
  late double rating;
  late bool isVerify;
  late List<CertificationDoctors> certificationDoctors = [];
  late List<HospitalDoctors> hospitalDoctors = [];
  late List<MajorDoctors> majorDoctors = [];

  Doctor(
      {required this.id,
        required this.email,
        required this.name,
        required this.avatar,
        required this.practisingCertificate,
        required this.certificateCode,
        required this.placeOfCertificate,
        required this.dateOfCertificate,
        required this.scopeOfPractice,
        required this.description,
        required this.numberOfConsultants,
        required this.rating,
        required this.isVerify,
        required this.certificationDoctors,
        required this.hospitalDoctors,
        required this.majorDoctors});

  Doctor.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    email = json['email'];
    name = json['name'];
    avatar = json['avatar'];
    practisingCertificate = json['practisingCertificate'];
    certificateCode = json['certificateCode'];
    placeOfCertificate = json['placeOfCertificate'];
    dateOfCertificate = json['dateOfCertificate'];
    scopeOfPractice = json['scopeOfPractice'];
    description = json['description'];
    numberOfConsultants = json['numberOfConsultants'];
    rating = json['rating'];
    isVerify = json['isVerify'];
    if (json['certificationDoctors'] != null) {
      json['certificationDoctors'].forEach((v) {
        certificationDoctors.add(new CertificationDoctors.fromJson(v));
      });
    }
    if (json['hospitalDoctors'] != null) {
      json['hospitalDoctors'].forEach((v) {
        hospitalDoctors.add(new HospitalDoctors.fromJson(v));
      });
    }
    if (json['majorDoctors'] != null) {
      json['majorDoctors'].forEach((v) {
        majorDoctors.add(new MajorDoctors.fromJson(v));
      });
    }
  }




  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['email'] = this.email;
    data['name'] = this.name;
    data['avatar'] = this.avatar;
    data['practisingCertificate'] = this.practisingCertificate;
    data['certificateCode'] = this.certificateCode;
    data['placeOfCertificate'] = this.placeOfCertificate;
    data['dateOfCertificate'] = this.dateOfCertificate;
    data['scopeOfPractice'] = this.scopeOfPractice;
    data['description'] = this.description;
    data['numberOfConsultants'] = this.numberOfConsultants;
    data['rating'] = this.rating;
    data['isVerify'] = this.isVerify;
    if (this.certificationDoctors != null) {
      data['certificationDoctors'] =
          this.certificationDoctors.map((v) => v.toJson()).toList();
    }
    if (this.hospitalDoctors != null) {
      data['hospitalDoctors'] =
          this.hospitalDoctors.map((v) => v.toJson()).toList();
    }
    if (this.majorDoctors != null) {
      data['majorDoctors'] = this.majorDoctors.map((v) => v.toJson()).toList();
    }
    return data;
  }
}
