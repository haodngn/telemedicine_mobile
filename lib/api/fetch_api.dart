import 'dart:convert';
import 'dart:developer';
import 'dart:io';
import 'package:flutter_secure_storage/flutter_secure_storage.dart' as Storage;
import 'package:get/get.dart' as GetX;
import 'package:http/http.dart' as http;
import 'package:telemedicine_mobile/Screens/login_screen.dart';
import 'package:telemedicine_mobile/controller/account_controller.dart';
import 'package:telemedicine_mobile/controller/google_login_controller.dart';
import 'package:telemedicine_mobile/models/Account.dart';
import 'package:telemedicine_mobile/models/AccountPost.dart';
import 'package:telemedicine_mobile/models/ContentDoctor.dart';
import 'package:telemedicine_mobile/models/ContentHealthCheck.dart';
import 'package:telemedicine_mobile/models/ContentHospital.dart';
import 'package:telemedicine_mobile/models/ContentMajor.dart';
import 'package:telemedicine_mobile/models/ContentSlot.dart';
import 'package:telemedicine_mobile/models/ContentSymptom.dart';
import 'package:telemedicine_mobile/models/ContentTimeFrame.dart';
import 'package:telemedicine_mobile/models/Doctor.dart';
import 'package:telemedicine_mobile/models/HealthCheck.dart';
import 'package:telemedicine_mobile/models/HealthCheckPost.dart';
import 'package:telemedicine_mobile/models/Hospital.dart';
import 'package:telemedicine_mobile/models/Major.dart';
import 'package:telemedicine_mobile/models/Patient.dart';
import 'package:telemedicine_mobile/models/Slot.dart';
import 'package:telemedicine_mobile/models/Symptom.dart';
import 'package:telemedicine_mobile/models/TimeFrame.dart';
import 'package:dio/dio.dart';

class FetchAPI {
  static Future<void> loginWithToken(String tokenId) async {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    final storage = new Storage.FlutterSecureStorage();
    data['tokenId'] = tokenId;
    data['loginType'] = 3;
    final accountController = GetX.Get.put(AccountController());
    try {
      final response =
          await http.post(Uri.parse("https://binhtt.tech/api/v1/login"),
              headers: <String, String>{
                HttpHeaders.contentTypeHeader: 'application/json',
              },
              body: jsonEncode(data));
      print(response.statusCode);
      if (response.statusCode == 200) {
        var accountJson = json.decode(utf8.decode(response.bodyBytes));
        Account account = Account.fromJson(accountJson['account']);
        storage.write(key: "accessToken", value: accountJson['accessToken']);
        accountController.account.value = account;
      } else {
        throw Exception("Internal server error");
      }
    } catch (e) {
      print(e);
    }
  }

  static Future<List<Doctor>> fetchContentDoctorWithCondition(String condition) async {
    final storage = new Storage.FlutterSecureStorage();
    String token = await storage.read(key: "accessToken") ?? "";
    if (token.isEmpty) {
      GetX.Get.offAll(LoginScreen(),
          transition: GetX.Transition.leftToRightWithFade,
          duration: Duration(milliseconds: 500));
      throw Exception("Error: UnAuthentication");
    } else {
      final response = await http.get(
        Uri.parse("https://binhtt.tech/api/v1/doctors?" +
            condition +
            "is-verify=1&limit=50&page-offset=1"),
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
  }


  static Future<List<TimeFrame>> fetchContentTimeFrame() async {
    final storage = new Storage.FlutterSecureStorage();
    String token = await storage.read(key: "accessToken") ?? "";
    if (token.isEmpty) {
      GetX.Get.offAll(LoginScreen(),
          transition: GetX.Transition.leftToRightWithFade,
          duration: Duration(milliseconds: 500));
      throw Exception("Error: UnAuthentication");
    } else {
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
  }

  static Future<List<Symptom>> fetchContentSymptom() async {
    final storage = new Storage.FlutterSecureStorage();
    String token = await storage.read(key: "accessToken") ?? "";
    if (token.isEmpty) {
      GetX.Get.offAll(LoginScreen(),
          transition: GetX.Transition.leftToRightWithFade,
          duration: Duration(milliseconds: 500));
      throw Exception("Error: UnAuthentication");
    } else {
        final response = await http.get(
            Uri.parse(
                "https://binhtt.tech/api/v1/symptoms?limit=20&page-offset=1"),
            headers: <String, String>{
              HttpHeaders.contentTypeHeader: 'application/json',
              HttpHeaders.authorizationHeader: 'Bearer $token',
            });
        if (response.statusCode == 200) {
          var contentJSon = json.decode(utf8.decode(response.bodyBytes));
          ContentSymptom contentSymptom = ContentSymptom.fromJson(contentJSon);
          return contentSymptom.symptom;
        } else {
          print(response.statusCode);
          throw Exception("Internal server error");
        }
    }
  }

  static Future<List<Major>> fetchContentMajor() async {
    final storage = new Storage.FlutterSecureStorage();
    String token = await storage.read(key: "accessToken") ?? "";
    if (token.isEmpty) {
      GetX.Get.offAll(LoginScreen(),
          transition: GetX.Transition.leftToRightWithFade,
          duration: Duration(milliseconds: 500));
      throw Exception("Error: UnAuthentication");
    } else {
      final response = await http.get(
          Uri.parse("https://binhtt.tech/api/v1/majors?page-offset=1&limit=100"),
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
  }

  static Future<List<Hospital>> fetchContentHospital() async {
    final storage = new Storage.FlutterSecureStorage();
    String token = await storage.read(key: "accessToken") ?? "";
    if (token.isEmpty) {
      GetX.Get.offAll(LoginScreen(),
          transition: GetX.Transition.leftToRightWithFade,
          duration: Duration(milliseconds: 500));
      throw Exception("Error: UnAuthentication");
    } else {
      final response = await http.get(
          Uri.parse("https://binhtt.tech/api/v1/hospitals?page-offset=1&limit=20"),
          headers: <String, String>{
            HttpHeaders.contentTypeHeader: 'application/json',
            HttpHeaders.authorizationHeader: 'Bearer $token',
          });
      if (response.statusCode == 200) {
        var contentJSon = json.decode(utf8.decode(response.bodyBytes));
        ContentHospital contentHospital = ContentHospital.fromJson(contentJSon);
        return contentHospital.hospital;
      } else if (response.statusCode == 404) {
        throw Exception("Not found hospitals");
      } else {
        throw Exception("Internal server error");
      }
    }
  }

  static Future<Patient> fetchMyPatient(String email) async {
    final storage = new Storage.FlutterSecureStorage();
    String token = await storage.read(key: "accessToken") ?? "";
    if (token.isEmpty) {
      GetX.Get.offAll(LoginScreen(),
          transition: GetX.Transition.leftToRightWithFade,
          duration: Duration(milliseconds: 500));
      throw Exception("Error: UnAuthentication");
    } else {
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
  }

  static Future<Account> fetchAccountDetail(String email) async {
    final storage = new Storage.FlutterSecureStorage();
    String token = await storage.read(key: "accessToken") ?? "";
    if (token.isEmpty) {
      GetX.Get.offAll(LoginScreen(),
          transition: GetX.Transition.leftToRightWithFade,
          duration: Duration(milliseconds: 500));
      throw Exception("Error: UnAuthentication");
    } else {
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
  }

  static Future<List<HealthCheck>> fetchMyHealthCheck(int patientID) async {
    final storage = new Storage.FlutterSecureStorage();
    String token = await storage.read(key: "accessToken") ?? "";
    if (token.isEmpty) {
      GetX.Get.offAll(LoginScreen(),
          transition: GetX.Transition.leftToRightWithFade,
          duration: Duration(milliseconds: 500));
      throw Exception("Error: UnAuthentication");
    } else {
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
  }

  static Future<List<Slot>> fetchContentSlot(int doctorID) async {
    final storage = new Storage.FlutterSecureStorage();
    String token = await storage.read(key: "accessToken") ?? "";
    if (token.isEmpty) {
      GetX.Get.offAll(LoginScreen(),
          transition: GetX.Transition.leftToRightWithFade,
          duration: Duration(milliseconds: 500));
      throw Exception("Error: UnAuthentication");
    } else {
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
  }

  static Future<int> createNewAccount(
      AccountPost accountPost, String filePath) async {
    final storage = new Storage.FlutterSecureStorage();
    String token = await storage.read(key: "accessToken") ?? "";
    if (token.isEmpty) {
      GetX.Get.offAll(LoginScreen(),
          transition: GetX.Transition.leftToRightWithFade,
          duration: Duration(milliseconds: 500));
      throw Exception("Error: UnAuthentication");
    } else {
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
        Response response =
            await Dio().post("https://binhtt.tech/api/v1/accounts",
                data: formData,
                options: Options(headers: <String, String>{
                  HttpHeaders.contentTypeHeader: 'multipart/form-data',
                  HttpHeaders.authorizationHeader: 'Bearer $token',
                }));
        return response.statusCode!;
      } on DioError catch (e) {
        return e.response!.statusCode!;
      }
    }
  }

  static Future<int> createNewPatient(Patient patient) async {
    final storage = new Storage.FlutterSecureStorage();
    String token = await storage.read(key: "accessToken") ?? "";
    if (token.isEmpty) {
      throw Exception("Error: UnAuthentication");
    } else {
      final response = await http.post(
          Uri.parse("https://binhtt.tech/api/v1/patients"),
          body: jsonEncode(patient.toJson()),
          headers: <String, String>{
            HttpHeaders.contentTypeHeader: 'application/json-patch+json',
            HttpHeaders.authorizationHeader: 'Bearer $token',
          });
      return response.statusCode;
    }
  }

  static Future<String> createNewHealthCheck(
      HealthCheckPost healthCheckPost) async {
    final storage = new Storage.FlutterSecureStorage();
    String token = await storage.read(key: "accessToken") ?? "";
    if (token.isEmpty) {
      GetX.Get.offAll(LoginScreen(),
          transition: GetX.Transition.leftToRightWithFade,
          duration: Duration(milliseconds: 500));
      throw Exception("Error: UnAuthentication");
    } else {
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
  }

  static Future<int> updateMyAccountInfo(
      Account account, String filePath) async {
    try {
      final storage = new Storage.FlutterSecureStorage();
      String token = await storage.read(key: "accessToken") ?? "";
      if (token.isEmpty) {
        GetX.Get.offAll(LoginScreen(),
            transition: GetX.Transition.leftToRightWithFade,
            duration: Duration(milliseconds: 500));
        throw Exception("Error: UnAuthentication");
      } else {
        FormData formData;
        if (filePath.isEmpty) {
          formData = new FormData.fromMap({
            "id": account.id,
            "firstName": account.firstName,
            "lastName": account.lastName,
            "ward": account.ward,
            "streetAddress": account.streetAddress,
            "locality": account.locality,
            "city": account.city,
            "postalCode": "000000",
            "phone": account.phone,
            "dob": account.dob,
            "isMale": account.isMale,
          });
        } else {
          formData = new FormData.fromMap({
            "id": account.id,
            "image": await MultipartFile.fromFile(filePath, filename: "avatar"),
            "firstName": account.firstName,
            "lastName": account.lastName,
            "ward": account.ward,
            "streetAddress": account.streetAddress,
            "locality": account.locality,
            "city": account.city,
            "postalCode": "000000",
            "phone": account.phone,
            "dob": account.dob,
            "isMale": account.isMale,
          });
        }
        Response response =
            await Dio().put("https://binhtt.tech/api/v1/accounts",
                data: formData,
                options: Options(headers: <String, String>{
                  HttpHeaders.contentTypeHeader: 'multipart/form-data',
                  HttpHeaders.authorizationHeader: 'Bearer $token',
                }));
        return response.statusCode!;
      }
    } on DioError catch (e) {
      return e.response!.statusCode!;
    }
  }

  static Future<String> updateMyPatientInfo(Patient patient) async {
    final storage = new Storage.FlutterSecureStorage();
    String token = await storage.read(key: "accessToken") ?? "";
    if (token.isEmpty) {
      GetX.Get.offAll(LoginScreen(),
          transition: GetX.Transition.leftToRightWithFade,
          duration: Duration(milliseconds: 500));
      throw Exception("Error: UnAuthentication");
    } else {
      final response = await http.put(
          Uri.parse("https://binhtt.tech/api/v1/patients"),
          body: jsonEncode(patient.toJson()),
          headers: <String, String>{
            HttpHeaders.contentTypeHeader: 'application/json',
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

  static Future<HealthCheck> getTokenHealthCheck(int healthCheckID) async {
    final storage = new Storage.FlutterSecureStorage();
    String token = await storage.read(key: "accessToken") ?? "";
    if (token.isEmpty) {
      GetX.Get.offAll(LoginScreen(),
          transition: GetX.Transition.leftToRightWithFade,
          duration: Duration(milliseconds: 500));
      throw Exception("Error: UnAuthentication");
    } else {
      final response = await http.get(
          Uri.parse("https://binhtt.tech/api/v1/health-checks/" +
              healthCheckID.toString() +
              "?mode=CALL"),
          headers: <String, String>{
            HttpHeaders.contentTypeHeader: 'application/json',
            HttpHeaders.authorizationHeader: 'Bearer $token',
          });
      if (response.statusCode == 200) {
        var contentJSon = json.decode(utf8.decode(response.bodyBytes));
        HealthCheck healthCheck = HealthCheck.fromJson(contentJSon);
        return healthCheck;
      } else if (response.statusCode == 404) {
        throw Exception("No health check found with the specified id");
      } else {
        throw Exception("Internal server error");
      }
    }
  }
}
