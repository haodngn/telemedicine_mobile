import 'package:get/get.dart';
import 'package:telemedicine_mobile/api/fetch_api.dart';
import 'package:telemedicine_mobile/controller/patient_profile_controller.dart';
import 'package:telemedicine_mobile/models/HealthCheck.dart';
import 'package:telemedicine_mobile/models/HealthCheckChangeSTT.dart';
import 'package:telemedicine_mobile/models/Symptom.dart';
import 'package:telemedicine_mobile/models/SymptomHealthCheck.dart';

class PatientHistoryController extends GetxController {
  RxInt patientID = 0.obs;
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

  editHealthCheckInfo(int rating, String comment, HealthCheck healthCheck,
      int height, int weight) {
    HealthCheck newHealthCheck = rating >= 0
        ? new HealthCheck(
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
            symptomHealthChecks: healthCheck.symptomHealthChecks)
        : new HealthCheck(
            id: healthCheck.id,
            height: height,
            weight: weight,
            reasonCancel: healthCheck.reasonCancel,
            rating: healthCheck.rating,
            comment: healthCheck.comment,
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
            symptomHealthChecks: listNewSymptom.cast<SymptomHealthCheck>());
    FetchAPI.editHealthCheck(newHealthCheck).then((value) {
      getMyHistory();
    });
  }

  RxList<dynamic> listMySymptom = [].obs;
  RxList<dynamic> listNewSymptom = [].obs;

  getListMySymptom() {
    listMySymptom.clear();
    listHealthCheck[index.value].symptomHealthChecks.map((element) {
      listMySymptom.add(element.symptomId);
    }).toList();
  }

  getListNewSymptom() {
    listNewSymptom.clear();
    listMySymptom.map((element) {
      listNewSymptom.add(new SymptomHealthCheck(
          id: 1,
          symptomId: element,
          healthCheckId: 0,
          evidence: "string",
          isActive: true,
          symptom: new Symptom(
              id: element,
              symptomCode: "string",
              name: "string",
              description: "string",
              isActive: true)));
    }).toList();
  }
}
