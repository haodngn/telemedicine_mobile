import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:telemedicine_mobile/models/Account.dart';
import 'package:telemedicine_mobile/models/AccountPost.dart';
import 'package:telemedicine_mobile/models/ContentDoctor.dart';
import 'package:telemedicine_mobile/models/ContentHealthCheck.dart';
import 'package:telemedicine_mobile/models/ContentMajor.dart';
import 'package:telemedicine_mobile/models/ContentSlot.dart';
import 'package:telemedicine_mobile/models/ContentSymptom.dart';
import 'package:telemedicine_mobile/models/ContentTimeFrame.dart';
import 'package:telemedicine_mobile/models/Doctor.dart';
import 'package:telemedicine_mobile/models/HealthCheck.dart';
import 'package:telemedicine_mobile/models/HealthCheckPost.dart';
import 'package:telemedicine_mobile/models/Major.dart';
import 'package:telemedicine_mobile/models/Patient.dart';
import 'package:telemedicine_mobile/models/Slot.dart';
import 'package:telemedicine_mobile/models/Symptom.dart';
import 'package:telemedicine_mobile/models/TimeFrame.dart';
import 'package:dio/dio.dart';

class FetchAPI {
  static String token =
      "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJuYW1laWQiOiIzIiwiZ2l2ZW5fbmFtZSI6IlRhbSBOZ3V5ZW4iLCJyb2xlIjoiMiIsIm5iZiI6MTYzMzc3NzA5MiwiZXhwIjoxNjM4OTYxMDkyLCJpYXQiOjE2MzM3NzcwOTIsImlzcyI6Imh0dHA6Ly9zZXJ2ZXIuY29tIiwiYXVkIjoiaHR0cDovL2NsaWVudC5jb20ifQ.gMm_MsqHEVX3Xj6cXKUcBq1ed0HYoRxDUFPjwYNy2L8";

  static Future<List<Doctor>> fetchContentDoctor() async {
    final response = await http.get(
      Uri.parse(
          "https://binhtt.tech/api/v1/doctors?is-verify=1&limit=50&page-offset=1"),
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

  static Future<List<TimeFrame>> fetchContentTimeFrame() async {
    final response = await http.get(
        Uri.parse(
            "https://binhtt.tech/api/v1/time-frames?startTime=00%3A00%3A00&endTime=00%3A00%3A00&page-offset=1&limit=20"),
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

  static Future<List<Symptom>> fetchContentSymptom() async {
    final response = await http.get(
        Uri.parse("https://binhtt.tech/api/v1/symptoms?limit=20&page-offset=1"),
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

  static Future<List<Major>> fetchContentMajor() async {
    final response = await http.get(
        Uri.parse("https://binhtt.tech/api/v1/majors?page-offset=1&limit=20"),
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

  static Future<Patient> fetchMyPatient(String email) async {
    final response = await http.get(
      Uri.parse("https://binhtt.tech/api/v1/patients/" +
          email +
          "?search-type=Email"),
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

  static Future<Account> fetchAccountDetail(String email) async {
    final response = await http.get(
      Uri.parse("https://binhtt.tech/api/v1/accounts/" +
          email +
          "?search-type=Email"),
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

  static Future<List<HealthCheck>> fetchMyHealthCheck(int patientID) async {
    final response = await http.get(
      Uri.parse("https://binhtt.tech/api/v1/health-checks?patient-id=" +
          patientID.toString() +
          "&page-offset=1&limit=50"),
      headers: <String, String>{
        HttpHeaders.contentTypeHeader: 'application/json',
        HttpHeaders.authorizationHeader: 'Bearer $token',
      },
    );
    if (response.statusCode == 200) {
      var contentJSon = json.decode(utf8.decode(response.bodyBytes));
      ContentHealthCheck contentHealthCheck =
          ContentHealthCheck.fromJson(contentJSon);
      return contentHealthCheck.healthCheck;
    } else if (response.statusCode == 404) {
      throw Exception("Not found health checks");
    } else if (response.statusCode == 400) {
      throw Exception("Bad requests");
    } else {
      throw Exception("Internal server error");
    }
  }

  static Future<List<Slot>> fetchContentSlot(int doctorID) async {
    final response = await http.get(
        Uri.parse("https://binhtt.tech/api/v1/slots?doctor-id=" +
            doctorID.toString() +
            "&start-time=00%3A00%3A00&end-time=00%3A00%3A00&page-offset=1&limit=50"),
        headers: <String, String>{
          HttpHeaders.contentTypeHeader: 'application/json',
          HttpHeaders.authorizationHeader: 'Bearer $token',
        });
    if (response.statusCode == 200) {
      var contentJSon = json.decode(utf8.decode(response.bodyBytes));
      ContentSlot contentSlot = ContentSlot.fromJson(contentJSon);
      return contentSlot.slot;
    } else if (response.statusCode == 404) {
      throw Exception("Not found slots");
    } else {
      throw Exception("Internal server error");
    }
  }

  static Future<String> createNewAccount(
      AccountPost accountPost, String filePath) async {
    print("SSS: " + filePath);
    try {
      FormData formData = new FormData.fromMap({
        "image": await MultipartFile.fromFile(filePath, filename: "avatar"),
        "email": accountPost.email,
        "firstName": accountPost.firstName,
        "lastName": accountPost.lastName,
        "ward": accountPost.ward,
        "streetAddress": accountPost.streetAddress,
        "locality": accountPost.locality,
        "city": accountPost.city,
        "postalCode": "000000",
        "phone": accountPost.phone,
        "dob": accountPost.dob,
        "isMale": accountPost.isMale,
        "roleId": 3,
      });
      print("fff: " + formData.fields.first.key);
      Response response =
          await Dio().post("https://binhtt.tech/api/v1/accounts",
              data: formData,
              options: Options(headers: <String, String>{
                HttpHeaders.contentTypeHeader: 'multipart/form-data',
                HttpHeaders.authorizationHeader: 'Bearer $token',
              }));
      print("SS: " + response.statusCode.toString());
    } on DioError catch (e) {
      print("aaaaaaaaaa: " + e.response!.statusCode!.toString());
            print("bbbbbb: " + e.response!.data.toString());
    }

    // final response = await http.post(
    //     Uri.parse("https://binhtt.tech/api/v1/accounts"),
    //     body: jsonEncode(accountPost.toJson()),
    //     headers: <String, String>{
    // HttpHeaders.contentTypeHeader: 'multipart/form-data',
    // HttpHeaders.authorizationHeader: 'Bearer $token',
    //     });
    // print("account: " + response.statusCode.toString());
    // if (response.statusCode == 201) {
    //   return "Created new patient successfull";
    // } else if (response.statusCode == 400) {
    //   return "Field is not matched or duplicated";
    // } else {
    //   return "Failed to save request";
    // }
    return "true";
  }

  static Future<String> createNewPatient(Patient patient) async {
    final response = await http.put(
        Uri.parse("https://binhtt.tech/api/v1/patients"),
        body: jsonEncode(patient.toJson()),
        headers: <String, String>{
          HttpHeaders.contentTypeHeader: 'application/json-patch+json',
          HttpHeaders.authorizationHeader: 'Bearer $token',
        });
    print("patient: " + response.statusCode.toString());
    if (response.statusCode == 201) {
      return "Created new patient successfull";
    } else if (response.statusCode == 400) {
      return "Field is not matched or duplicated";
    } else {
      return "Failed to save request";
    }
  }

  static Future<String> createNewHealthCheck(
      HealthCheckPost healthCheckPost) async {
    final response = await http.post(
        Uri.parse("https://binhtt.tech/api/v1/health-checks"),
        body: jsonEncode(healthCheckPost.toJson()),
        headers: <String, String>{
          HttpHeaders.contentTypeHeader: 'application/json',
          HttpHeaders.authorizationHeader: 'Bearer $token',
        });
    if (response.statusCode == 201) {
      return "Created new health check successfull";
    } else if (response.statusCode == 400) {
      return "Field is not matched or duplicated";
    } else if (response.statusCode == 404) {
      return "Not found";
    } else {
      return "Failed to save request";
    }
  }

  static Future<String> updateMyAccountInfo(Account account) async {
    final response = await http.put(
        Uri.parse("https://binhtt.tech/api/v1/accounts"),
        body: account.toJson(),
        headers: <String, String>{
          HttpHeaders.contentTypeHeader: 'multipart/form-data',
          HttpHeaders.authorizationHeader: 'Bearer $token',
        });
    if (response.statusCode == 201) {
      return "Created new patient successfull";
    } else if (response.statusCode == 400) {
      return "Field is not matched";
    } else if (response.statusCode == 401) {
      return "Unauthorized";
    } else if (response.statusCode == 403) {
      return "Forbidden";
    } else if (response.statusCode == 404) {
      return "Not found";
    } else {
      return "Failed to save request";
    }
  }

  static Future<String> updateMyPatientInfo(Patient patient) async {
    final response = await http.put(
        Uri.parse("https://binhtt.tech/api/v1/patients"),
        body: patient.toJson(),
        headers: <String, String>{
          HttpHeaders.contentTypeHeader: 'application/json-patch+json',
          HttpHeaders.authorizationHeader: 'Bearer $token',
        });
    if (response.statusCode == 201) {
      return "Created new health check successfull";
    } else if (response.statusCode == 400) {
      return "Field is not matched";
    } else if (response.statusCode == 401) {
      return "Unauthorized";
    } else if (response.statusCode == 403) {
      return "Forbidden";
    } else if (response.statusCode == 404) {
      return "Not found";
    } else {
      return "Failed to save request";
    }
  }
}
