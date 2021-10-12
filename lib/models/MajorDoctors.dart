import 'package:telemedicine_mobile/models/Major.dart';

class MajorDoctors {
  late int id;
  late int doctorId;
  late int majorId;
  late Major major;

  MajorDoctors({
    required this.id,
    required this.doctorId,
    required this.majorId,
    required this.major,
  });

  MajorDoctors.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    doctorId = json['doctorId'];
    majorId = json['majorId'];
    if (json['major'] != null) {
      major = new Major.fromJson(json['major']);
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['doctorId'] = this.doctorId;
    data['majorId'] = this.majorId;
    if (this.major != null) {
      data['major'] = this.major.toJson();
    }
    return data;
  }
}
