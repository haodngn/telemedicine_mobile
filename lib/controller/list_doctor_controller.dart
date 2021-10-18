import 'package:get/get.dart';
import 'package:telemedicine_mobile/api/fetch_api.dart';
import 'package:telemedicine_mobile/models/Doctor.dart';
import 'package:telemedicine_mobile/models/HealthCheck.dart';
import 'package:telemedicine_mobile/models/HealthCheckPost.dart';
import 'package:telemedicine_mobile/models/Patient.dart';
import 'package:telemedicine_mobile/models/Slot.dart';

class ListDoctorController extends GetxController {
  RxList<dynamic> listDoctor = [].obs;
  Rx<Doctor> doctorDetail = new Doctor(
      id: 0,
      email: "",
      name: "",
      avatar: "",
      practisingCertificate: "",
      certificateCode: "",
      placeOfCertificate: "",
      dateOfCertificate: "",
      scopeOfPractice: "",
      description: "",
      numberOfConsultants: 0,
      rating: 0,
      isVerify: true,
      certificationDoctors: [],
      hospitalDoctors: [],
      majorDoctors: []).obs;

  RxList<dynamic> listSlot = [].obs;

  getListDoctor() {
    FetchAPI.fetchContentDoctor().then((dataFromServer) {
      listDoctor.value = dataFromServer;
    });
  }

  getListDoctorSlot(int doctorID) {
    FetchAPI.fetchContentSlot(doctorID).then((dataFromServer) {
      listSlot.value = dataFromServer;
    });
  }

  RxInt healthCheckID = 0.obs;
  int getHealthCheckID(int id) {
    healthCheckID.value = id;
    return healthCheckID.value;
  }

  getDoctorDetailByEmail(String emailDoctor) {
    listDoctor.map((e) {
      if (e.email == emailDoctor) doctorDetail.value = e;
    }).toList();
  }

  bookHealthCheck(String token, Patient patient, Slot slot) {
    HealthCheckPost healthCheckPost = new HealthCheckPost(
        height: 0,
        weight: 0,
        token: token,
        patientId: patient.id,
        slotId: slot.id,
        symptomHealthChecks: []);

    FetchAPI.createNewHealthCheck(healthCheckPost);
  }
}
