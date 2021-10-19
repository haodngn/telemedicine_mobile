import 'package:flutter/material.dart';
import 'package:geocoder/geocoder.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:multi_select_flutter/multi_select_flutter.dart';
import 'package:telemedicine_mobile/api/fetch_api.dart';
import 'package:telemedicine_mobile/controller/list_doctor_controller.dart';

class FilterController extends GetxController {
  RxBool searchByLocation = false.obs;
  RxString myAddress = "".obs;
  Rx<DateTime> dateSearch = DateTime.now().subtract(Duration(days: 1)).obs;

  void getMyAddress() async {
    final position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);
    final coordinates = new Coordinates(position.latitude, position.longitude);
    var address =
        await Geocoder.local.findAddressesFromCoordinates(coordinates);
    searchByLocation.value = true;
    myAddress.value = address.first.addressLine;
  }

  Future pickDate(BuildContext context) async {
    final initialDate = DateTime.now();
    final newDate = await showDatePicker(
        context: context,
        initialDate: initialDate,
        firstDate: DateTime(initialDate.year),
        lastDate: DateTime(initialDate.year + 50));

    if (newDate == null) return;
    dateSearch.value = newDate as DateTime;
  }

  RxList<dynamic> listTimeFrame = [].obs;

  getListTimeFrame() {
    FetchAPI.fetchContentTimeFrame().then((dataFromServer) {
      listTimeFrame.value = dataFromServer;
    });
  }

  static List listNull = [];

  RxList<dynamic> listSymptom = [].obs;
  RxList<MultiSelectItem<dynamic>> listSymptomItem =
      listNull.map((e) => MultiSelectItem(e, e.toString())).toList().obs;

  getListSymptom() {
    FetchAPI.fetchContentSymptom().then((dataFromServer) {
      listSymptom.value = dataFromServer;
    });

    new Future.delayed(
        const Duration(seconds: 2),
        () => {
              listSymptomItem.value = listSymptom
                  .map((symptom) => MultiSelectItem(symptom, symptom.name))
                  .toList()
            });
  }

  RxList<dynamic> listMajor = [].obs;
  RxList<MultiSelectItem<dynamic>> listMajorItem =
      listNull.map((e) => MultiSelectItem(e, e.toString())).toList().obs;

  getListMajor() {
    FetchAPI.fetchContentMajor().then((dataFromServer) {
      listMajor.value = dataFromServer;
    });

    new Future.delayed(
        const Duration(seconds: 2),
        () => {
              listMajorItem.value = listMajor
                  .map((major) => MultiSelectItem(major.id, major.name))
                  .toList()
            });
  }

  final listDoctorController = Get.put(ListDoctorController());

  RxList listResultMajor = [].obs;
  setSearchMajor() {
    listResultMajor
        .map((element) =>
            {listDoctorController.searchMajor.value += "major=" + element.toString() + "&"})
        .toList();
  }

}
