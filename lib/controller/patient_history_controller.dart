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

  getMyHistory() async {
    await FetchAPI.fetchMyHealthCheck(patientID.value).then((dataFromServer) {
      listHealthCheck.value = dataFromServer;
    });
  }
}
// static DateTime date = DateTime.parse("2021-10-06");
// String formattedDate = DateFormat('dd/MM/yyyy').format(date);
//
// static DateTime timeStart = DateTime.parse("20210710 13:27:00");
// String formattedTimeStart = DateFormat('HH:mm:ss').format(timeStart);
//
// static DateTime timeEnd = DateTime.parse("20210710 14:27:00");
// String formattedTimeEnd = DateFormat('HH:mm:ss').format(timeEnd);
