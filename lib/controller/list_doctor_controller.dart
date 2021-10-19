import 'package:get/get.dart';
import 'package:telemedicine_mobile/Screens/call_screen/videocall_screen.dart';
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

  RxString searchMajor = "".obs;

  getListDoctor() {
    FetchAPI.fetchContentDoctor(searchMajor.value).then((dataFromServer) {
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

  bookHealthCheck(int height, int weight, Patient patient, Slot slot) {
    HealthCheckPost healthCheckPost = new HealthCheckPost(
        height: height,
        weight: weight,
        patientId: patient.id,
        slotId: slot.id,
        symptomHealthChecks: []);

    FetchAPI.createNewHealthCheck(healthCheckPost);
  }

  Rx<Slot> slot = new Slot(
      id: 0,
      assignedDate: "",
      doctorId: 0,
      doctor: new Doctor(
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
          majorDoctors: []),
      startTime: "",
      endTime: "",
      isActive: true,
      healthCheckID: 0,
      healthCheck: new HealthCheck(
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
          symptomHealthChecks: [])).obs;

  Rx<HealthCheck> healthCheckToken = new HealthCheck(
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
      symptomHealthChecks: []).obs;

  getTokenHealthCheck(int healthCheckID) {
    FetchAPI.getTokenHealthCheck(healthCheckID).then((value) => {
          healthCheckToken.value = value,
          Get.to(CallScreen()),
        });
  }
}
