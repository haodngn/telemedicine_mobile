import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:telemedicine_mobile/api/fetch_api.dart';
import 'package:telemedicine_mobile/models/HealthCheck.dart';
import 'package:telemedicine_mobile/models/Patient.dart';

class PatientHistoryController extends GetxController {
  RxInt patientID = 1.obs;
  RxString dobDoctor = "".obs;
  RxBool genderDoctor = true.obs;

  RxList<dynamic> listHealthCheck = [].obs;
  RxInt index = 0.obs;
  RxList<dynamic> listPrescriptions = [].obs;

  getMyHistory() async {
    await FetchAPI.fetchMyHealthCheck(patientID.value).then((dataFromServer) {
      listHealthCheck.value = dataFromServer;
    });
  }

  getPrescription() {
    listPrescriptions.value = listHealthCheck[index.value].prescriptions;
  }
}
