import 'package:get/get.dart';
import 'package:telemedicine_mobile/api/fetch_api.dart';
import 'package:telemedicine_mobile/models/HealthCheck.dart';
import 'package:telemedicine_mobile/models/HealthCheckChangeSTT.dart';
import 'package:telemedicine_mobile/models/Patient.dart';

class PatientHistoryController extends GetxController {
  RxInt patientID = 1.obs;
  RxString dobDoctor = "".obs;
  RxBool genderDoctor = true.obs;

  RxList<dynamic> listHealthCheck = [].obs;
  RxInt index = 0.obs;
  RxString sttHistory = "upcoming".obs;
  RxList<dynamic> listHistorySTT = [].obs;

  getMyHistory() {
    FetchAPI.fetchMyHealthCheck(patientID.value).then((dataFromServer) {
      listHealthCheck.value = dataFromServer;
    });
  }

  RxList<dynamic> listTopDoctor = [].obs;

  getTopDoctor() {
    FetchAPI.fetchContentTopDoctor().then((dataFromServer) {
      listTopDoctor.value = dataFromServer;
      print("SSSSSSS: " + listTopDoctor.length.toString());
    });
  }

  RxBool emptyComment = false.obs;
  RxBool emptyReason = false.obs;

  cancelHealthCheck(int id, String reason) {
    HealthCheckChangeSTT healthCheckChangeSTT = new HealthCheckChangeSTT(
        id: id, reasonCancel: reason, status: "CANCELED");
    FetchAPI.cancelHealthCheck(healthCheckChangeSTT)
        .then((value) => getMyHistory());
  }

  ratingHealthCheck(int rating, String comment, HealthCheck healthCheck) {
    HealthCheck newHealthCheck = new HealthCheck(
        id: healthCheck.id,
        height: healthCheck.height,
        weight: healthCheck.weight,
        reasonCancel: healthCheck.reasonCancel,
        rating: rating,
        comment: comment,
        advice: healthCheck.advice,
        token: healthCheck.token,
        patientId: healthCheck.patientId,
        createdTime: healthCheck.createdTime,
        canceledTime: healthCheck.canceledTime,
        status: healthCheck.status,
        patient: healthCheck.patient,
        healthCheckDiseases: healthCheck.healthCheckDiseases,
        prescriptions: healthCheck.prescriptions,
        slots: healthCheck.slots,
        symptomHealthChecks: healthCheck.symptomHealthChecks);
    FetchAPI.ratingHealthCheck(newHealthCheck).then((value) => getMyHistory());
  }

  RxString sttDrug = "morning".obs;
}
