import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:telemedicine_mobile/api/fetch_address_api.dart';
import 'package:telemedicine_mobile/api/fetch_api.dart';
import 'package:telemedicine_mobile/controller/patient_profile_controller.dart';
import 'package:telemedicine_mobile/models/Account.dart';
import 'package:telemedicine_mobile/models/AccountPost.dart';
import 'package:telemedicine_mobile/models/Patient.dart';
import 'package:telemedicine_mobile/models/Role.dart';

class FormAfterLoginController extends GetxController {
  final patientProfileController = Get.put(PatientProfileController());

  RxString selectedGender = "".obs;
  Rx<DateTime> dob = DateTime.now().obs;
  RxList<dynamic> provinceData = [].obs;
  RxList<dynamic> districtData = [].obs;
  RxList<dynamic> wardData = [].obs;
  RxString provinceOrCity = "".obs;
  RxString district = "".obs;
  RxString ward = "".obs;
  RxBool provinceIsSelect = false.obs;
  RxBool districtIsSelect = false.obs;

  setListDistrict(value) {
    provinceData
        .map((element) => {
              if (element.name == value)
                {districtData.value = element.districts}
            })
        .toList();
  }

  setListWard(value) {
    districtData
        .map((element) => {
              if (element.name == value) {wardData.value = element.wards}
            })
        .toList();
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

  Rx<File> image = new File("").obs;
  Future pickImage(ImageSource source) async {
    try {
      final pImage = await ImagePicker().pickImage(source: source);
      if (pImage == null) return;

      final imageTemp = File(pImage.path);
      image.value = imageTemp;
    } on PlatformException catch (e) {
      throw Exception("Fail to pick image: $e");
    }
  }

  RxBool selectDOB = true.obs;

  RxBool emptyFName = false.obs;
  RxBool emptyLName = false.obs;
  RxBool emptyGender = false.obs;
  RxBool emptyDOB = false.obs;
  RxBool emptyPhone = false.obs;
  RxBool emptyCity = false.obs;
  RxBool emptyDistrict = false.obs;
  RxBool emptyWard = false.obs;
  RxBool emptyStreet = false.obs;

  RxBool done = false.obs;

  Future pickDate(BuildContext context) async {
    final initialDate = DateTime.parse("2000-01-01");
    final newDate = await showDatePicker(
        context: context,
        initialDate: initialDate,
        firstDate: DateTime(1900),
        lastDate: DateTime(initialDate.year + 20));

    if (newDate == null) return;
    selectDOB.value = false;
    dob.value = newDate as DateTime;
  }

  createAccountPatient(
      String fName,
      String lName,
      String phoneNumber,
      String street,
      String allergy,
      String bloodGroup,
      String backgroundDisease) {
    if (fName.isEmpty) {
      emptyFName.value = true;
    } else {
      emptyFName.value = false;
    }
    if (lName.isEmpty) {
      emptyLName.value = true;
    } else {
      emptyLName.value = false;
    }
    if (selectedGender.isEmpty) {
      emptyGender.value = true;
    } else {
      emptyGender.value = false;
    }
    if (selectDOB.value) {
      emptyDOB.value = true;
    } else {
      emptyDOB.value = false;
    }
    if (phoneNumber.isEmpty) {
      emptyPhone.value = true;
    } else {
      emptyPhone.value = false;
    }
    if (provinceOrCity.isEmpty) {
      emptyCity.value = true;
    } else {
      emptyCity.value = false;
    }
    if (district.isEmpty) {
      emptyDistrict.value = true;
    } else {
      emptyDistrict.value = false;
    }
    if (ward.isEmpty) {
      emptyWard.value = true;
    } else {
      emptyWard.value = false;
    }
    if (street.isEmpty) {
      emptyStreet.value = true;
    } else {
      emptyStreet.value = false;
    }
    if (emptyFName.isFalse &&
        emptyLName.isFalse &&
        emptyGender.isFalse &&
        emptyDOB.isFalse &&
        emptyPhone.isFalse &&
        emptyCity.isFalse &&
        emptyDistrict.isFalse &&
        emptyWard.isFalse &&
        emptyStreet.isFalse) {
      AccountPost newAccount = new AccountPost(
        email: patientProfileController.myEmail.value,
        firstName: fName,
        lastName: lName,
        image: "",
        ward: ward.value,
        streetAddress: street,
        locality: district.value,
        city: provinceOrCity.value,
        postalCode: "000000",
        phone: phoneNumber,
        dob: DateFormat("yyyy-MM-dd").format(dob.value),
        isMale: selectedGender.value.endsWith("Nam") ? true : false,
        roleId: 3,
      );

      Patient newPatient = new Patient(
          id: 0,
          email: patientProfileController.myEmail.value,
          name: fName + " " + lName,
          avatar: "",
          backgroundDisease: backgroundDisease,
          allergy: allergy,
          bloodGroup: bloodGroup,
          isActive: true,
          healthChecks: []);
      FetchAPI.createNewAccount(newAccount, image.value.path).then((value) {
        if (value == 201) {
          FetchAPI.createNewPatient(newPatient);
        }
      });

      done.value = true;
    }
  }
}
