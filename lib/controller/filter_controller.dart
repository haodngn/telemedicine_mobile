import 'package:flutter/material.dart';
import 'package:geocoder/geocoder.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:multi_select_flutter/multi_select_flutter.dart';
import 'package:telemedicine_mobile/api/fetch_api.dart';
import 'package:telemedicine_mobile/controller/list_doctor_controller.dart';

class FilterController extends GetxController {
  RxBool searchByLocation = false.obs;
  RxString myAddress = "".obs;
  Rx<DateTime> dateSearch = DateTime.now().obs;
  RxString nameDoctor = "".obs;
  RxString startTime = "00:00".obs;
  RxString endTime = "00:00".obs;
  RxString parseSearchMajor = "".obs;
  RxString parseSearchHospital = "".obs;

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
    final initialDate = dateSearch.value;
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
      listMajorItem.value = listMajor
          .map((major) => MultiSelectItem(major.id, major.name))
          .toList();
    });
  }

  RxList<dynamic> listHospital = [].obs;
  RxList<MultiSelectItem<dynamic>> listHospitalItem =
      listNull.map((e) => MultiSelectItem(e, e.toString())).toList().obs;

  getListHospital() {
    FetchAPI.fetchContentHospital().then((dataFromServer) {
      listHospital.value = dataFromServer;
      listHospitalItem.value = listHospital
          .map((hospital) => MultiSelectItem(hospital.id, hospital.name))
          .toList();
    });
  }

  final listDoctorController = Get.put(ListDoctorController());

  RxList<dynamic> listResultMajor = [].obs;

  setSearchMajor() {
    parseSearchMajor.value = "";
    listResultMajor.value = listResultMajor.sublist(1);
    listResultMajor
        .map((element) =>
            parseSearchMajor.value += "majors=" + element.toString() + "&")
        .toList();
  }

  RxList<dynamic> listResultHospital = [].obs;
  setSearchHospital() {
    parseSearchHospital.value = "";
    listResultHospital
        .map((element) =>
    parseSearchHospital.value += "hospitals=" + element.toString() + "&")
        .toList();
  }


  //TypeSearch: 1, search with condition, 2: search all
  searchDoctorByCondition(int typeSearch) {
    String condition = "";
    switch(typeSearch)
    {
      case 1: {
        if (listResultMajor.length > 1) {
          setSearchMajor();
          condition += parseSearchMajor.value;
        }
        if (listResultHospital.length != 0) {
          setSearchHospital();
          condition += parseSearchHospital.value;
        }
        if (startTime.value != "00:00") {
          condition += ("time-start=${startTime.value}&");
        }
        if (endTime.value != "00:00") {
          condition += ("time-end=${endTime.value}&");
        }
        String formattedDate = DateFormat('yyyy-MM-dd').format(dateSearch.value);
        condition += ("date-health-check=$formattedDate&");
        if (nameDoctor.isNotEmpty) {
          condition += ("name-doctor=${nameDoctor.value}&");
        }
        listDoctorController.condition.value = condition;
        break;
      }
      case 2: {
        listDoctorController.condition.value = "";
        break;
      }
    }
    listDoctorController.getListDoctor();
  }
}
