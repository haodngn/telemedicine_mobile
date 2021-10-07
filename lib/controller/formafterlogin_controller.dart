import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'address_controller.dart';

class FormAfterLoginController extends GetxController {
  var selectedGender = "".obs;
  var dob = DateTime.now().obs;
  var provinceData = [].obs;
  var districtData = [].obs;
  var wardData = [].obs;
  var provinceOrCity = "Thành phố Hà Nội".obs;
  var district = "".obs;
  var ward = "".obs;
  var provinceIsSelect = false.obs;
  var districtIsSelect = false.obs;

  Future pickDate(BuildContext context) async {
    final initialDate = DateTime.parse("1990-01-01");
    final newDate = await showDatePicker(
        context: context,
        initialDate: initialDate,
        firstDate: DateTime(1900),
        lastDate: DateTime(initialDate.year + 30));

    if (newDate == null) return;
    dob.value = newDate as DateTime;
  }

  setSelectedGender(String value) {
    selectedGender.value = value;
  }

  selectCityOrProvince(value) {
    provinceOrCity.value = value;
  }

  selectDistrict(value) {
    district.value = value;
  }

  selectWard(value) {
    ward.value = value;
  }

  getAddress() {
    GetAddress.fetchProvinces().then((dataFromServer) {
      provinceData.value = dataFromServer;
    });
  }

  provinceIsSelected() {
    provinceIsSelect.value = true;
  }

  districtIsSelected() {
    districtIsSelect.value = true;
  }

  changeProvinceSelect() {
    districtIsSelect.value = false;
  }

  setDistricts(value) {
    provinceData
        .map((element) => {
      if(element.name == value) {districtData.value = element.districts}
    }).toList();
    district.value = districtData[0].name;
  }

  setWards(value) {
    districtData
        .map((element) => {
      if(element.name == value) {wardData.value = element.wards}
    }).toList();
    ward.value = wardData[0].name;
  }
}
