import 'dart:convert';
import 'dart:io';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:telemedicine_mobile/api/fetch_api.dart';
import 'package:telemedicine_mobile/models/Account.dart';
import 'package:telemedicine_mobile/models/Doctor.dart';
import 'package:telemedicine_mobile/models/Role.dart';

class DoctorDetailController extends GetxController {
  Rx<Account> doctorDetail = new Account(
          id: 0,
          email: "",
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
          role: new Role(id: 0, name: "", isActive: true))
      .obs;

  getDoctorDetail(String emailDoctor) {
    FetchAPI.fetchAccountDetail(emailDoctor).then((dataFromServer) {
      doctorDetail.value = dataFromServer;
    });
  }
}
