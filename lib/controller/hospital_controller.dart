import 'package:get/get.dart';
import 'package:get/get_rx/src/rx_types/rx_types.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:telemedicine_mobile/Screens/list_doctor_screen.dart';
import 'package:telemedicine_mobile/api/fetch_api.dart';
import 'package:telemedicine_mobile/controller/filter_controller.dart';
import 'package:telemedicine_mobile/models/ContentHospital.dart';

class HospitalController extends GetxController {
  RxList<dynamic> listHospital = [].obs;
  RxList<Marker> listMarkers = RxList();

  FilterController filterController = Get.put(FilterController());

  @override
  void onInit() {
    super.onInit();
    getNearHospital(10.848425114854084, 106.79768431248772);
  }

  Future<ContentHospital?> getNearHospital(double lat, double lng) async {
    ContentHospital contentHospital =
        await FetchAPI.getListNearHospital(lat, lng);
    listHospital.value = contentHospital.hospital;
    List<Marker> listMarker = [];
    contentHospital.hospital.forEach((e) => {
          listMarker.add(new Marker(
              markerId: MarkerId(e.id.toString()),
              position: LatLng(e.lat, e.long),
              icon: BitmapDescriptor.defaultMarkerWithHue(
                BitmapDescriptor.hueViolet,
              ),
              infoWindow: InfoWindow(
                  title: e.name,
                  onTap: () {
                    filterController.hospitalId.value = e.id;
                    filterController.searchDoctorByCondition(1);
                    Get.to(ListDoctorScreen());
                  },
                  snippet: e.address)))
        });
    listMarkers.value = listMarker;
    print(listMarkers.toString());
  }
}
