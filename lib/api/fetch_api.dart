import 'dart:convert';
import 'dart:developer';
import 'dart:io';
import 'package:flutter_secure_storage/flutter_secure_storage.dart' as Storage;
import 'package:get/get.dart' as GetX;
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'package:telemedicine_mobile/Screens/login_screen.dart';
import 'package:telemedicine_mobile/controller/account_controller.dart';
import 'package:telemedicine_mobile/controller/google_login_controller.dart';
import 'package:telemedicine_mobile/controller/patient_profile_controller.dart';
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
import 'package:telemedicine_mobile/models/HealthCheckChangeSTT.dart';
import 'package:telemedicine_mobile/models/HealthCheckPost.dart';
import 'package:telemedicine_mobile/models/Hospital.dart';
import 'package:telemedicine_mobile/models/Major.dart';
import 'package:telemedicine_mobile/models/Patient.dart';
import 'package:telemedicine_mobile/models/Role.dart';
import 'package:telemedicine_mobile/models/Slot.dart';
import 'package:telemedicine_mobile/models/Symptom.dart';
import 'package:telemedicine_mobile/models/TimeFrame.dart';
import 'package:dio/dio.dart';

class FetchAPI {
  static Future<String> loginWithToken(String tokenId) async {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    final storage = new Storage.FlutterSecureStorage();
    data['tokenId'] =
        "eyJhbGciOiJSUzI1NiIsImtpZCI6IjE1MjU1NWEyMjM3MWYxMGY0ZTIyZjFhY2U3NjJmYzUwZmYzYmVlMGMiLCJ0eXAiOiJKV1QifQ.eyJuYW1lIjoiVsSDbiBUw6JtIE5ndXnhu4VuIiwicGljdHVyZSI6Imh0dHBzOi8vbGgzLmdvb2dsZXVzZXJjb250ZW50LmNvbS9hL0FBVFhBSnlxZ3pjYVRhNjlJdWtxZVdkUFh4TC13dExzYnk2UmQ1TTBTOGc0PXM5Ni1jIiwiaXNzIjoiaHR0cHM6Ly9zZWN1cmV0b2tlbi5nb29nbGUuY29tL3RlbGVtZWRpY2luZS1mYzBlZSIsImF1ZCI6InRlbGVtZWRpY2luZS1mYzBlZSIsImF1dGhfdGltZSI6MTYzNTQ1ODUyMiwidXNlcl9pZCI6IlYwY05VbER2OVZoY2tXTGw5RGxnV29HeTFyRjIiLCJzdWIiOiJWMGNOVWxEdjlWaGNrV0xsOURsZ1dvR3kxckYyIiwiaWF0IjoxNjM1NDU4NTIyLCJleHAiOjE2MzU0NjIxMjIsImVtYWlsIjoidmFudGFtMTQxN0BnbWFpbC5jb20iLCJlbWFpbF92ZXJpZmllZCI6dHJ1ZSwiZmlyZWJhc2UiOnsiaWRlbnRpdGllcyI6eyJnb29nbGUuY29tIjpbIjExNjc5ODQ1NDM5NDI4ODgyNzAyOSJdLCJlbWFpbCI6WyJ2YW50YW0xNDE3QGdtYWlsLmNvbSJdfSwic2lnbl9pbl9wcm92aWRlciI6Imdvb2dsZS5jb20ifX0.OX_bAGPiu8j8TzcyslOwX7kFlFdCSFL7vtJT3ROuDc5v5ui1WPVEUrPbYphYYuqR0aeDKDz6n-6EQ-KJYc10z3r49_esmla-m7tl6_ZUooYYRbMKRbWgNEtgTbmV4zYmHo4IDe-l-jGfvEhbzLV-5xGVOqp2MhjhZndCur6RZ5WmxevG9DLjpR_47B8GoPWXLAYZHXItitxEOvCIjnuES_wQXhFyAqhE3jEOnjhFw8JAjFOgzqvXe-1Ng3d0owTsSTdMc6-q4NLknk6PiqpI10ojzZbHiF4ByN7SETMabzb4MFKv1n7kzi8uT3a0loDSPVKQY6vOlm9LI48B-Ua2nw";
    data['loginType'] = 3;
    final accountController = GetX.Get.put(AccountController());
    try {
      final response =
          await http.post(Uri.parse("https://binhtt.tech/api/v1/login"),
              headers: <String, String>{
                HttpHeaders.contentTypeHeader: 'application/json',
              },
              body: jsonEncode(data));
      Map bodyJson = json.decode(utf8.decode(response.bodyBytes));
      String message = "Login Success";
      if (bodyJson.length == 1) {
        bodyJson.values.forEach((value) {
          message = value;
        });
      }
      if (response.statusCode == 200) {
        if (bodyJson.length == 1) {
          accountController.account.value = new Account(
              id: 0,
              email: message,
              firstName: "",
              lastName: "",
              ward: "",
              streetAddress: "",
              locality: "",
              city: "",
              postalCode: "",
              phone: "",
              avatar: "",
              dob: "",
              active: true,
              isMale: true,
              role: new Role(id: 0, name: "", isActive: true));
          return "Create Account";
        }
        var accountJson = json.decode(utf8.decode(response.bodyBytes));
        Account account = Account.fromJson(accountJson['account']);
        storage.write(key: "accessToken", value: accountJson['accessToken']);
        accountController.account.value = account;
        return message;
      } else {
        return message;
      }
    } catch (e) {
      return "";
    }
  }

  static Future<ContentDoctor> fetchContentDoctorWithCondition(
      String condition, int currentPage) async {
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
            "limit=8&page-offset=$currentPage"),
        headers: <String, String>{
          HttpHeaders.contentTypeHeader: 'application/json',
          HttpHeaders.authorizationHeader: 'Bearer $token',
        },
      );
      if (response.statusCode == 200) {
        var contentJSon = json.decode(utf8.decode(response.bodyBytes));
        ContentDoctor contentDoctor = ContentDoctor.fromJson(contentJSon);
        return contentDoctor;
      } else if (response.statusCode == 404) {
        throw Exception("Not found doctor");
      } else if (response.statusCode == 401) {
        throw Exception("Error: Unauthorized");
      } else {
        throw Exception("Internal server error");
      }
    }
  }

  static Future<List<Doctor>> fetchContentAllDoctor() async {
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
  }

  static Future<List<Doctor>> fetchContentTopDoctor() async {
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
            "https://binhtt.tech/api/v1/doctors?order-by=Rating&order-type=desc&is-verify=1&limit=3&page-offset=1"),
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

  static Future<HealthCheck> fetchNearestHealthCheck(int patientID) async {
    final patientProfileController = GetX.Get.put(PatientProfileController());
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
            "https://binhtt.tech/api/v1/health-checks?mode-search=NEAREST&type-role=USER&patient-id=" +
                patientID.toString() +
                "&page-offset=1&limit=1"),
        headers: <String, String>{
          HttpHeaders.contentTypeHeader: 'application/json',
          HttpHeaders.authorizationHeader: 'Bearer $token',
        },
      );
      if (response.statusCode == 200) {
        var contentJSon = json.decode(utf8.decode(response.bodyBytes));
        HealthCheck healthCheck = HealthCheck.fromJson(contentJSon);
        return healthCheck;
      } else if (response.statusCode == 404) {
        patientProfileController.nearestHealthCheck.value = new HealthCheck(
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
        throw Exception("Not found health checks");
      } else if (response.statusCode == 400) {
        throw Exception("Bad requests");
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
          Uri.parse(
              "https://binhtt.tech/api/v1/majors?page-offset=1&limit=100"),
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
          Uri.parse(
              "https://binhtt.tech/api/v1/hospitals?page-offset=1&limit=20"),
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
    String assignedDate = DateFormat("yyyy-MM-dd").format(DateTime.now());
    String startTime = DateFormat("HH").format(DateTime.now());

    String token = await storage.read(key: "accessToken") ?? "";
    if (token.isEmpty) {
      GetX.Get.offAll(LoginScreen(),
          transition: GetX.Transition.leftToRightWithFade,
          duration: Duration(milliseconds: 500));
      throw Exception("Error: UnAuthentication");
    } else {
      final response = await http.get(
          Uri.parse("https://binhtt.tech/api/v1/slots?start-assigned-date=" +
              assignedDate +
              "&doctor-id=" +
              doctorID.toString() +
              "&start-time=" +
              startTime +
              "%3A00%3A00&end-time=00%3A00%3A00&page-offset=1&limit=50"),
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
        return "Update patient successfull";
      } else if (response.statusCode == 400) {
        return "Field is not matched";
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

  static Future<String> cancelHealthCheck(
      HealthCheckChangeSTT healthCheckChangeSTT) async {
    final storage = new Storage.FlutterSecureStorage();
    String token = await storage.read(key: "accessToken") ?? "";
    if (token.isEmpty) {
      GetX.Get.offAll(LoginScreen(),
          transition: GetX.Transition.leftToRightWithFade,
          duration: Duration(milliseconds: 500));
      throw Exception("Error: UnAuthentication");
    } else {
      final response = await http.patch(
          Uri.parse("https://binhtt.tech/api/v1/health-checks/" +
              healthCheckChangeSTT.id.toString()),
          body: jsonEncode(healthCheckChangeSTT.toJson()),
          headers: <String, String>{
            HttpHeaders.contentTypeHeader: 'application/json',
            HttpHeaders.authorizationHeader: 'Bearer $token',
          });
      if (response.statusCode == 200) {
        return "Cancel health check successfull";
      } else if (response.statusCode == 404) {
        return "Not found";
      } else {
        return "Failed to save request";
      }
    }
  }

  static Future<String> ratingHealthCheck(HealthCheck healthCheck) async {
    final storage = new Storage.FlutterSecureStorage();
    String token = await storage.read(key: "accessToken") ?? "";
    if (token.isEmpty) {
      GetX.Get.offAll(LoginScreen(),
          transition: GetX.Transition.leftToRightWithFade,
          duration: Duration(milliseconds: 500));
      throw Exception("Error: UnAuthentication");
    } else {
      final response = await http.put(
          Uri.parse("https://binhtt.tech/api/v1/health-checks?mode=USERS"),
          body: jsonEncode(healthCheck.toJson()),
          headers: <String, String>{
            HttpHeaders.contentTypeHeader: 'application/json',
            HttpHeaders.authorizationHeader: 'Bearer $token',
          });
      if (response.statusCode == 200) {
        return "Update patient successfull";
      } else if (response.statusCode == 400) {
        return "Field is not matched";
      } else if (response.statusCode == 404) {
        return "Not found";
      } else {
        return "Failed to save request";
      }
    }
  }
}
