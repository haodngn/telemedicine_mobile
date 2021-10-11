import 'dart:convert';
import 'dart:io';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:telemedicine_mobile/api/get_doctor_detail_api.dart';
import 'package:telemedicine_mobile/models/Doctor.dart';

class DoctorDetailController extends GetxController {
  var doctorDetail = [].obs;

  getDoctorDetail() {
    GetDoctorDetail.fetchDoctorDetail().then((dataFromServer) {
      doctorDetail.value = dataFromServer;
    });
  }


}
