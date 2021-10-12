import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:telemedicine_mobile/models/Account.dart';
import 'package:telemedicine_mobile/models/ContentDoctor.dart';
import 'package:telemedicine_mobile/models/ContentMajor.dart';
import 'package:telemedicine_mobile/models/ContentSymptom.dart';
import 'package:telemedicine_mobile/models/ContentTimeFrame.dart';
import 'package:telemedicine_mobile/models/Doctor.dart';
import 'package:telemedicine_mobile/models/Major.dart';
import 'package:telemedicine_mobile/models/Patient.dart';
import 'package:telemedicine_mobile/models/Symptom.dart';
import 'package:telemedicine_mobile/models/TimeFrame.dart';

class FetchAPI {
  static String token =
      "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJuYW1laWQiOiIzIiwiZ2l2ZW5fbmFtZSI6IlRhbSBOZ3V5ZW4iLCJyb2xlIjoiMiIsIm5iZiI6MTYzMzc3NzA5MiwiZXhwIjoxNjM4OTYxMDkyLCJpYXQiOjE2MzM3NzcwOTIsImlzcyI6Imh0dHA6Ly9zZXJ2ZXIuY29tIiwiYXVkIjoiaHR0cDovL2NsaWVudC5jb20ifQ.gMm_MsqHEVX3Xj6cXKUcBq1ed0HYoRxDUFPjwYNy2L8";

  static Future<List<Doctor>> fetchContentDoctor({int page = 1}) async {
    final response = await http.get(
        Uri.parse(
            "http://52.221.193.237/api/v1/doctors?limit=50&page-offset=1"),
        headers: <String, String>{
          HttpHeaders.contentTypeHeader: 'application/json',
          HttpHeaders.authorizationHeader: 'Bearer $token',
        },
    );
    if (response.statusCode == 200) {
      var contentJSon = json.decode(utf8.decode(response.bodyBytes));
      ContentDoctor contentDoctor = ContentDoctor.fromJson(contentJSon);
      return contentDoctor.doctor;
    } else if (response.statusCode == 404) {
      throw Exception("Not found doctor");
    } else if (response.statusCode == 401) {
      throw Exception("Error: Unauthorized");
    } else {
      throw Exception("Internal server error");
    }
  }

  static Future<List<TimeFrame>> fetchContentTimeFrame({int page = 1}) async {
    final response = await http.get(
        Uri.parse(
            "http://52.221.193.237/api/v1/time-frames?startTime=00%3A00%3A00&endTime=00%3A00%3A00&page-offset=1&limit=20"),
        headers: <String, String>{
          HttpHeaders.contentTypeHeader: 'application/json',
          HttpHeaders.authorizationHeader: 'Bearer $token',
        });
    if (response.statusCode == 200) {
      var contentJSon = json.decode(utf8.decode(response.bodyBytes));
      ContentTimeFrame contentTimeFrame =
          ContentTimeFrame.fromJson(contentJSon);
      return contentTimeFrame.timeFrame;
    } else {
      throw Exception("Internal server error");
    }
  }

  static Future<List<Symptom>> fetchContentSymptom({int page = 1}) async {
    final response = await http.get(
        Uri.parse(
            "http://52.221.193.237/api/v1/symptoms?limit=20&page-offset=1"),
        headers: <String, String>{
          HttpHeaders.contentTypeHeader: 'application/json',
          HttpHeaders.authorizationHeader: 'Bearer $token',
        });
    if (response.statusCode == 200) {
      var contentJSon = json.decode(utf8.decode(response.bodyBytes));
      ContentSymptom contentSymptom = ContentSymptom.fromJson(contentJSon);
      return contentSymptom.symptom;
    } else {
      throw Exception("Internal server error");
    }
  }

  static Future<List<Major>> fetchContentMajor({int page = 1}) async {
    final response = await http.get(
        Uri.parse(
            "http://52.221.193.237/api/v1/majors?page-offset=1&limit=20"),
        headers: <String, String>{
          HttpHeaders.contentTypeHeader: 'application/json',
          HttpHeaders.authorizationHeader: 'Bearer $token',
        });
    if (response.statusCode == 200) {
      var contentJSon = json.decode(utf8.decode(response.bodyBytes));
      ContentMajor contentMajor = ContentMajor.fromJson(contentJSon);
      return contentMajor.major;
    } else if (response.statusCode == 404) {
      throw Exception("Not found majors");
    } else {
      throw Exception("Internal server error");
    }
  }

  static Future<Patient> fetchMyPatient({int page = 1}) async {
    final response = await http.get(
      Uri.parse(
          "http://52.221.193.237/api/v1/patients/tamnv1007%40gmail.com?search-type=Email"),
      headers: <String, String>{
        HttpHeaders.contentTypeHeader: 'application/json',
        HttpHeaders.authorizationHeader: 'Bearer $token',
      },
    );
    if (response.statusCode == 200) {
      var contentJSon = json.decode(utf8.decode(response.bodyBytes));
      Patient patient = Patient.fromJson(contentJSon);
      return patient;
    } else if (response.statusCode == 404) {
      throw Exception("No account found with the type");
    } else {
      throw Exception("Internal server error");
    }
  }

  static Future<Account> fetchMyAccount({int page = 1}) async {
    final response = await http.get(
      Uri.parse(
          "http://52.221.193.237/api/v1/accounts/tamnv1007%40gmail.com?search-type=Email"),
      headers: <String, String>{
        HttpHeaders.contentTypeHeader: 'application/json',
        HttpHeaders.authorizationHeader: 'Bearer $token',
      },
    );
    if (response.statusCode == 200) {
      var contentJSon = json.decode(utf8.decode(response.bodyBytes));
      Account account = Account.fromJson(contentJSon);
      return account;
    } else if (response.statusCode == 404) {
      throw Exception("No account found with the type");
    } else {
      throw Exception("Internal server error");
    }
  }
}
