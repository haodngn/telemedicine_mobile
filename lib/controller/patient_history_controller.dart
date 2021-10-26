import 'package:get/get.dart';
import 'package:telemedicine_mobile/api/fetch_api.dart';
import 'package:telemedicine_mobile/models/HealthCheck.dart';
import 'package:telemedicine_mobile/models/Patient.dart';

class PatientHistoryController extends GetxController {
  RxInt patientID = 1.obs;
  RxString dobDoctor = "".obs;
  RxBool genderDoctor = true.obs;

  RxList<dynamic> listHealthCheck = [].obs;
  RxInt index = 0.obs;

  getMyHistory() async {
    await FetchAPI.fetchMyHealthCheck(patientID.value).then((dataFromServer) {
      listHealthCheck.value = dataFromServer;
    });
  }

  RxList<dynamic> listTopDoctor = [].obs;

  getTopDoctor() {
    FetchAPI.fetchContentTopDoctor().then((dataFromServer) {
      listTopDoctor.value = dataFromServer;
    });
  }

  Rx<HealthCheck> nearestHealthCheck = new HealthCheck(
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

  getNearestHealthCheck() {
    FetchAPI.fetchNearestHealthCheck(33).then((dataFromServer) {
      nearestHealthCheck.value = dataFromServer;
    });
  }
}
