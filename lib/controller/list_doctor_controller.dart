import 'package:get/get.dart';
import 'package:telemedicine_mobile/api/fetch_api.dart';

class ListDoctorController extends GetxController {
  RxList<dynamic> listDoctor = [].obs;

  getListDoctor() {
    FetchAPI.fetchContentDoctor().then((dataFromServer) {
      listDoctor.value = dataFromServer;
    });
  }
}
