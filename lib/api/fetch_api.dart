import 'dart:convert';
import 'dart:io';
import 'package:flutter_secure_storage/flutter_secure_storage.dart' as Storage;
import 'package:get/get.dart' as GetX;
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'package:telemedicine_mobile/Screens/login_screen.dart';
import 'package:telemedicine_mobile/controller/account_controller.dart';
import 'package:telemedicine_mobile/controller/patient_profile_controller.dart';
import 'package:telemedicine_mobile/models/Account.dart';
import 'package:telemedicine_mobile/models/AccountPost.dart';
import 'package:telemedicine_mobile/models/ContentDoctor.dart';
import 'package:telemedicine_mobile/models/ContentHealthCheck.dart';
import 'package:telemedicine_mobile/models/ContentHospital.dart';
import 'package:telemedicine_mobile/models/ContentMajor.dart';
import 'package:telemedicine_mobile/models/ContentNews.dart';
import 'package:telemedicine_mobile/models/ContentNotification.dart';
import 'package:telemedicine_mobile/models/ContentSlot.dart';
import 'package:telemedicine_mobile/models/ContentSymptom.dart';
import 'package:telemedicine_mobile/models/ContentTimeFrame.dart';
import 'package:telemedicine_mobile/models/Doctor.dart';
import 'package:telemedicine_mobile/models/HealthCheck.dart';
import 'package:telemedicine_mobile/models/HealthCheckChangeSTT.dart';
import 'package:telemedicine_mobile/models/HealthCheckPost.dart';
import 'package:telemedicine_mobile/models/Hospital.dart';
import 'package:telemedicine_mobile/models/JoinCallModel.dart';
import 'package:telemedicine_mobile/models/Major.dart';
import 'package:telemedicine_mobile/models/News.dart';
import 'package:telemedicine_mobile/models/Notification.dart';
import 'package:telemedicine_mobile/models/Patient.dart';
import 'package:telemedicine_mobile/models/Role.dart';
import 'package:telemedicine_mobile/models/Slot.dart';
import 'package:telemedicine_mobile/models/StatisticCovid/StatisticCovid.dart';
import 'package:telemedicine_mobile/models/Symptom.dart';
import 'package:telemedicine_mobile/models/TimeFrame.dart';
import 'package:dio/dio.dart';

class FetchAPI {
  static Future<String> loginWithToken(String tokenId) async {
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

  static Future<bool> makeConnection() async {
    final storage = new Storage.FlutterSecureStorage();
    final accountController = GetX.Get.put(AccountController());
    String tokenFcm = await storage.read(key: "tokenFCM") ?? "";
    String token = await storage.read(key: "accessToken") ?? "";
    String email = accountController.account.value.email;
    if (tokenFcm != "" && email.isNotEmpty && token != "") {
      final Map<String, String> data = new Map<String, String>();
      data['token'] = tokenFcm;
      data['email'] = email.toLowerCase();
      final response = await http.post(
        Uri.parse("https://binhtt.tech/api/v1/notifications/connection"),
        headers: <String, String>{
          HttpHeaders.contentTypeHeader: 'application/json',
          HttpHeaders.authorizationHeader: 'Bearer $token',
        },
        body: jsonEncode(data),
      );
      if (response.statusCode == 200) {
        return true;
      } else {
        return false;
      }
    }
    return false;
  }

  static Future<void> getCountUnreadNotification() async {
    final storage = new Storage.FlutterSecureStorage();
    final accountController = GetX.Get.put(AccountController());
    String token = await storage.read(key: "accessToken") ?? "";
    int userId = accountController.account.value.id;
    if (userId != 0 && token != "") {
      final response = await http.get(
        Uri.parse("https://binhtt.tech/api/v1/notifications/users/$userId"),
        headers: <String, String>{
          HttpHeaders.contentTypeHeader: 'application/json',
          HttpHeaders.authorizationHeader: 'Bearer $token',
        },
      );
      if (response.statusCode == 200) {
        var contentJSon = json.decode(utf8.decode(response.bodyBytes));
        int numberUnread = contentJSon['countOfUnRead'];
        accountController.countNotificationUnread.value = numberUnread;
      }
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
            "is-verify=1&limit=8&page-offset=$currentPage"),
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

  static Future<List<News>> fetchContentNews() async {
    final response = await http.get(
      Uri.parse(
          "https://api.coronatracker.com/news/trending?limit=5&offset=0&language=vi&fbclid=IwAR2rQ_ijG1GnzHDAH7gkag_A1ljj6d1NVkDC_5CG8QOlV4HYpellcQ8o3Lo"),
      headers: <String, String>{
        HttpHeaders.contentTypeHeader: 'application/json',
      },
    );
    if (response.statusCode == 200) {
      var contentJSon = json.decode(utf8.decode(response.bodyBytes));
      ContentNews contentNews = ContentNews.fromJson(contentJSon);
      return contentNews.news;
    } else {
      throw Exception("Internal server error");
    }
  }

  static Future<dynamic> fetchContentStaticCovid() async {
    final response = await http.get(
      Uri.parse(
          "https://static.pipezero.com/covid/data.json?fbclid=IwAR2-5yMjUCwJVTz2FQRS0v9ll7ggkePfoZbEZQGBOeFbctSqVgf5DP3pa04"),
      headers: <String, String>{
        HttpHeaders.contentTypeHeader: 'application/json',
      },
    );
    if (response.statusCode == 200) {
      var contentJSon = json.decode(utf8.decode(response.bodyBytes));
      StatisticCovid contentCovidTotal =
          StatisticCovid.fromJson(contentJSon["total"]);
      StatisticCovid contentCovidToday =
          StatisticCovid.fromJson(contentJSon["today"]);
      return {'total': contentCovidTotal, 'today': contentCovidToday};
    } else {
      throw Exception("Internal server error");
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
        throw Exception("Bad requests");
      } else {
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
              "&page-offset=1&limit=50"),
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
              }));
      return response.statusCode!;
    } on DioError catch (e) {
      return e.response!.statusCode!;
    }
  }

  static Future<int> createNewPatient(Patient patient) async {
    final response = await http.post(
        Uri.parse("https://binhtt.tech/api/v1/patients"),
        body: jsonEncode(patient.toJson()),
        headers: <String, String>{
          HttpHeaders.contentTypeHeader: 'application/json-patch+json',
        });
    return response.statusCode;
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

  static Future<JoinCallResponse> joinCall(int healthCheckID) async {
    final storage = new Storage.FlutterSecureStorage();
    String token = await storage.read(key: "accessToken") ?? "";
    final accountController = GetX.Get.put(AccountController());
    String email = accountController.account.value.email;
    String displayName = accountController.account.value.firstName +
        " " +
        accountController.account.value.lastName;
    if (token.isEmpty) {
      GetX.Get.offAll(LoginScreen(),
          transition: GetX.Transition.leftToRightWithFade,
          duration: Duration(milliseconds: 500));
      throw Exception("Error: UnAuthentication");
    } else {
      final Map<String, dynamic> data = new Map<String, dynamic>();
      data['healthCheckID'] = healthCheckID;
      data['email'] = email.toLowerCase();
      data['displayName'] = displayName;
      data['isInvited'] = true;
      final response = await http.post(
          Uri.parse("https://binhtt.tech/api/v1/health-checks/join-call"),
          body: jsonEncode(data),
          headers: <String, String>{
            HttpHeaders.contentTypeHeader: 'application/json',
            HttpHeaders.authorizationHeader: 'Bearer $token',
          });
      if (response.statusCode == 200) {
        var contentJSon = json.decode(utf8.decode(response.bodyBytes));
        JoinCallResponse joinCallResponse =
            JoinCallResponse.fromJson(contentJSon);
        return joinCallResponse;
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

  static Future<String> editHealthCheck(HealthCheck healthCheck) async {
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

  static Future<List<NotificationPatient>> fetchContentNotification(
      int userID) async {
    final storage = new Storage.FlutterSecureStorage();
    String token = await storage.read(key: "accessToken") ?? "";
    if (token.isEmpty) {
      GetX.Get.offAll(LoginScreen(),
          transition: GetX.Transition.leftToRightWithFade,
          duration: Duration(milliseconds: 500));
      throw Exception("Error: UnAuthentication");
    } else {
      final accountController = GetX.Get.put(AccountController());
      final response = await http.get(
          Uri.parse(
              "https://binhtt.tech/api/v1/notifications?user-id=${accountController.account.value.id}" +
                  "&page-offset=1&limit=20"),
          headers: <String, String>{
            HttpHeaders.contentTypeHeader: 'application/json',
            HttpHeaders.authorizationHeader: 'Bearer $token',
          });
      if (response.statusCode == 200) {
        var contentJSon = json.decode(utf8.decode(response.bodyBytes));
        ContentNotification contentNotification =
            ContentNotification.fromJson(contentJSon);
        return contentNotification.notify;
      } else if (response.statusCode == 404) {
        throw Exception("Not found notifications");
      } else {
        throw Exception("Internal server error");
      }
    }
  }

  static Future<int> unReadNotification(int userID) async {
    final storage = new Storage.FlutterSecureStorage();
    String token = await storage.read(key: "accessToken") ?? "";
    int countUnread = 0;
    if (token.isEmpty) {
      GetX.Get.offAll(LoginScreen(),
          transition: GetX.Transition.leftToRightWithFade,
          duration: Duration(milliseconds: 500));
      throw Exception("Error: UnAuthentication");
    } else {
      final response = await http.get(
          Uri.parse("https://binhtt.tech/api/v1/notifications/users/33"),
          headers: <String, String>{
            HttpHeaders.contentTypeHeader: 'application/json',
            HttpHeaders.authorizationHeader: 'Bearer $token',
          });
      if (response.statusCode == 200) {
        Map contentJSon = json.decode(utf8.decode(response.bodyBytes));
        contentJSon.values.forEach((value) {
          countUnread = value;
        });
        return countUnread;
      } else if (response.statusCode == 404) {
        return countUnread;
      } else {
        return countUnread;
      }
    }
  }

  static Future<String> readNotification(
      NotificationPatient notificationPatient) async {
    final storage = new Storage.FlutterSecureStorage();
    String token = await storage.read(key: "accessToken") ?? "";
    if (token.isEmpty) {
      GetX.Get.offAll(LoginScreen(),
          transition: GetX.Transition.leftToRightWithFade,
          duration: Duration(milliseconds: 500));
      throw Exception("Error: UnAuthentication");
    } else {
      final response = await http.put(
          Uri.parse("https://binhtt.tech/api/v1/notifications"),
          body: jsonEncode(notificationPatient.toJson()),
          headers: <String, String>{
            HttpHeaders.contentTypeHeader: 'application/json',
            HttpHeaders.authorizationHeader: 'Bearer $token',
          });
      if (response.statusCode == 200) {
        return "Update notification successfull";
      } else if (response.statusCode == 400) {
        return "Field is not matched";
      } else if (response.statusCode == 404) {
        return "Not found";
      } else {
        return "Failed to save request";
      }
    }
  }

  static Future<bool> userLogout() async {
    final storage = new Storage.FlutterSecureStorage();
    final accountController = GetX.Get.put(AccountController());
    String token = await storage.read(key: "accessToken") ?? "";
    if (token.isEmpty) {
      GetX.Get.offAll(LoginScreen(),
          transition: GetX.Transition.leftToRightWithFade,
          duration: Duration(milliseconds: 500));
      throw Exception("Error: UnAuthentication");
    } else {
      String tokenFcm = await storage.read(key: "tokenFCM") ?? "";
      String token = await storage.read(key: "accessToken") ?? "";
      String email = accountController.account.value.email;
      if (tokenFcm != "" && email.isNotEmpty && token != "") {
        final Map<String, String> data = new Map<String, String>();
        data['token'] = tokenFcm;
        data['email'] = email.toLowerCase();
        final response = await http.post(
          Uri.parse("https://binhtt.tech/api/v1/logout"),
          headers: <String, String>{
            HttpHeaders.contentTypeHeader: 'application/json',
            HttpHeaders.authorizationHeader: 'Bearer $token',
          },
          body: jsonEncode(data),
        );
        if (response.statusCode == 200) {
          storage.deleteAll();
          return true;
        }
      }
      return false;
    }
  }

  static Future<ContentHospital> getListNearHospital(
      double lat, double lng) async {
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
            "https://binhtt.tech/api/v1/hospitals?latitude=$lat&longitude=$lng&limit=3&page-offset=1"),
        headers: <String, String>{
          HttpHeaders.contentTypeHeader: 'application/json',
          HttpHeaders.authorizationHeader: 'Bearer $token',
        },
      );
      if (response.statusCode == 200) {
        var contentJSon = json.decode(utf8.decode(response.bodyBytes));
        ContentHospital contentHospital = ContentHospital.fromJson(contentJSon);

        return contentHospital;
      } else if (response.statusCode == 404) {
        throw Exception("Not found doctor");
      } else if (response.statusCode == 401) {
        throw Exception("Error: Unauthorized");
      } else {
        throw Exception("Internal server error");
      }
    }
  }
}
