import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:telemedicine_mobile/models/Doctor.dart';

class GetDoctorDetail {
  static String token =
      "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJuYW1laWQiOiIzIiwiZ2l2ZW5fbmFtZSI6IlRhbSBOZ3V5ZW4iLCJyb2xlIjoiMiIsIm5iZiI6MTYzMzc3NzA5MiwiZXhwIjoxNjM4OTYxMDkyLCJpYXQiOjE2MzM3NzcwOTIsImlzcyI6Imh0dHA6Ly9zZXJ2ZXIuY29tIiwiYXVkIjoiaHR0cDovL2NsaWVudC5jb20ifQ.gMm_MsqHEVX3Xj6cXKUcBq1ed0HYoRxDUFPjwYNy2L8";

  static Future<List<Doctor>> fetchDoctorDetail({int page = 1}) async {
    final response = await http.get(
        Uri.parse(
            "http://52.221.193.237/api/v1/doctors/nhanle16235%40gmail.com?search-type=Email"),
        headers: <String, String>{
          HttpHeaders.contentTypeHeader: 'application/json',
          HttpHeaders.authorizationHeader: 'Bearer $token',
        });
    if (response.statusCode == 200) {
      Map<String, dynamic> list =
          json.decode(utf8.decode(response.bodyBytes)); // as List<dynamic>;
      List<Doctor> doctor = []; //list.map((e) => Doctor.fromJson(e)).toList();
      return doctor;
    } else if (response.statusCode == 404) {
      throw Exception("No doctor found with the type");
    } else {
      throw Exception("Internal server error");
    }
  }
}
