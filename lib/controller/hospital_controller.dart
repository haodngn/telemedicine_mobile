import 'dart:typed_data';

import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:get/get_rx/src/rx_types/rx_types.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:telemedicine_mobile/Screens/list_doctor_screen.dart';
import 'package:telemedicine_mobile/api/fetch_api.dart';
import 'package:telemedicine_mobile/controller/filter_controller.dart';
import 'package:telemedicine_mobile/models/ContentHospital.dart';
import 'dart:ui' as ui;

class HospitalController extends GetxController {
  RxList<dynamic> listHospital = [].obs;
  RxList<Marker> listMarkers = RxList();

  FilterController filterController = Get.put(FilterController());

  @override
  void onInit() {
    super.onInit();
    getNearHospital(10.848425114854084, 106.79768431248772);
  }

  Future<Uint8List> getBytesFromAsset(String path, int width) async {
    ByteData data = await rootBundle.load(path);
    ui.Codec codec = await ui.instantiateImageCodec(data.buffer.asUint8List(),
        targetWidth: width);
    ui.FrameInfo fi = await codec.getNextFrame();
    return (await fi.image.toByteData(format: ui.ImageByteFormat.png))!
        .buffer
        .asUint8List();
  }

  Future<ContentHospital?> getNearHospital(double lat, double lng) async {
    ContentHospital contentHospital =
        await FetchAPI.getListNearHospital(lat, lng);
    listHospital.value = contentHospital.hospital;
    List<Marker> listMarker = [];
    Uint8List markerIcon =
        await getBytesFromAsset('assets/icons/hospital.png', 50);
    contentHospital.hospital.forEach((e) => {
          listMarker.add(new Marker(
              markerId: MarkerId(e.id.toString()),
              position: LatLng(e.lat, e.long),
              icon: BitmapDescriptor.fromBytes(markerIcon),
              infoWindow: InfoWindow(
                  title: e.name,
                  onTap: () {
                    filterController.hospitalId.value = e.id;
                    filterController.searchDoctorByNearest();
                    Get.to(ListDoctorScreen());
                  },
                  snippet: e.address)))
        });
    listMarkers.value = listMarker;
  }
}
