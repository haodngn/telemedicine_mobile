import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:telemedicine_mobile/api/fetch_address_api.dart';

class FormAfterLoginController extends GetxController {
  RxString firstName = "".obs;
  RxString lastName = "".obs;
  RxString selectedGender = "".obs;
  Rx<DateTime> dob = DateTime.now().obs;
  RxString phone = "".obs;
  RxList<dynamic> provinceData = [].obs;
  RxList<dynamic> districtData = [].obs;
  RxList<dynamic> wardData = [].obs;
  RxString provinceOrCity = "".obs;
  RxString district = "".obs;
  RxString ward = "".obs;
  RxString street = "".obs;
  RxBool provinceIsSelect = false.obs;
  RxBool districtIsSelect = false.obs;

  Future pickDate(BuildContext context) async {
    final initialDate = DateTime.parse("2000-01-01");
    final newDate = await showDatePicker(
        context: context,
        initialDate: initialDate,
        firstDate: DateTime(1900),
        lastDate: DateTime(initialDate.year + 20));

    if (newDate == null) return;
    dob.value = newDate as DateTime;
  }

  setListDistrict(value) {
    provinceData
        .map((element) => {
      if(element.name == value) {districtData.value = element.districts}
    }).toList();
  }

  setListWard(value) {
    districtData
        .map((element) => {
      if(element.name == value) {wardData.value = element.wards}
    }).toList();
  }

  changeProvinceSelect() {
    districtIsSelect.value = false;
    district.value = "";
    ward.value = "";
    wardData.value = [];
  }

  getAddress() {
    FetchAddressAPI.fetchProvinces().then((dataFromServer) {
      provinceData.value = dataFromServer;
    });

    setListDistrict(provinceOrCity.value);
  }
}
