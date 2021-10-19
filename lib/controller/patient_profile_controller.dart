import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:telemedicine_mobile/api/fetch_address_api.dart';
import 'package:telemedicine_mobile/api/fetch_api.dart';
import 'package:telemedicine_mobile/controller/patient_history_controller.dart';
import 'package:telemedicine_mobile/models/Account.dart';
import 'package:telemedicine_mobile/models/Patient.dart';
import 'package:telemedicine_mobile/models/Role.dart';

class PatientProfileController extends GetxController {
  final patientHistoryController = Get.put(PatientHistoryController());

  RxString myEmail = "tamnv1007@gmail.com".obs;

  Rx<Patient> patient = new Patient(
      id: 0,
      email: "",
      name: "",
      avatar: "",
      backgroundDisease: "",
      allergy: "",
      bloodGroup: "",
      isActive: true,
      healthChecks: []).obs;

  Rx<Account> account = new Account(
          id: 0,
          email: "",
          firstName: "",
          lastName: "",
          ward: "",
          streetAddress: "",
          locality: "",
          city: "",
          postalCode: "",
          phone: "",
          avatar: "",
          dob: "",
          active: true,
          isMale: true,
          role: new Role(id: 0, name: "", isActive: true))
      .obs;

  getMyPatient() {
    FetchAPI.fetchMyPatient(myEmail.value).then((dataFromServer) {
      patient.value = dataFromServer;
      patientHistoryController.patientID.value = patient.value.id;
    });
  }

  RxBool isMale = true.obs;
  RxString dob = "".obs;
  RxList<dynamic> listCity = [].obs;
  RxList<dynamic> listDistrict = [].obs;
  RxList<dynamic> listWard = [].obs;
  RxString city = "".obs;
  RxString district = "".obs;
  RxString ward = "".obs;

  getAddress() {
    FetchAddressAPI.fetchProvinces().then((dataFromServer) {
      listCity.value = dataFromServer;
    });
    new Future.delayed(
        const Duration(seconds: 2),
        () => {
              setListDistrict(account.value.city),
              setListWard(account.value.locality),
            });
  }

  setListDistrict(value) {
    listCity
        .map((element) => {
              if (element.name == value)
                {listDistrict.value = element.districts}
            })
        .toList();
  }

  setListWard(value) {
    listDistrict
        .map((element) => {
              if (element.name == value) {listWard.value = element.wards}
            })
        .toList();
  }

  getMyAccount() {
    FetchAPI.fetchAccountDetail(myEmail.value).then((dataFromServer) {
      account.value = dataFromServer;
    });

    new Future.delayed(
        const Duration(seconds: 2),
        () => {
              isMale.value = account.value.isMale,
              dob.value = DateFormat('yyyy-MM-dd')
                  .format(DateTime.parse(account.value.dob)),
              city.value = account.value.city,
              district.value = account.value.locality,
              ward.value = account.value.ward,
            });
  }

  Future pickDate(BuildContext context) async {
    final initialDate = DateTime.parse("2000-01-01");
    final newDate = await showDatePicker(
        context: context,
        initialDate: initialDate,
        firstDate: DateTime(1900),
        lastDate: DateTime(initialDate.year + 20));

    if (newDate == null) return;
    dob.value = DateFormat('yyyy-MM-dd').format(newDate as DateTime);
  }

  updatePatientInfo(
      String backgroundDisease, String allergy, String bloodGroup) {
    if (backgroundDisease.isEmpty) {
      backgroundDisease = patient.value.backgroundDisease;
    }
    if (allergy.isEmpty) {
      allergy = patient.value.allergy;
    }
    if (bloodGroup.isEmpty) {
      bloodGroup = patient.value.bloodGroup;
    }

    Patient newPatient = new Patient(
        id: patient.value.id,
        email: patient.value.email,
        name: patient.value.name,
        avatar: patient.value.avatar,
        backgroundDisease: backgroundDisease,
        allergy: allergy,
        bloodGroup: bloodGroup,
        isActive: patient.value.isActive,
        healthChecks: patient.value.healthChecks);
    patient.value = newPatient;
    FetchAPI.updateMyPatientInfo(patient.value);
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

  RxBool done = false.obs;

  RxBool emptyDistrict = false.obs;
  RxBool emptyWard = false.obs;

  updateAccountInfo(
      String fName, String lName, String phoneNumber, String street) {
    if (fName.isEmpty) {
      fName = account.value.firstName;
    }
    if (lName.isEmpty) {
      lName = account.value.lastName;
    }
    if (phoneNumber.isEmpty) {
      phoneNumber = account.value.phone;
    }
    if (street.isEmpty) {
      street = account.value.streetAddress;
    }

    if (district.value.isEmpty) {
      emptyDistrict.value = true;
    } else {
      emptyDistrict.value = false;
    }
    if (ward.value.isEmpty) {
      emptyWard.value = true;
    } else {
      emptyWard.value = false;
    }
    Account newAccount = new Account(
        id: account.value.id,
        email: account.value.email,
        firstName: fName,
        lastName: lName,
        ward: account.value.ward.contains(ward.value)
            ? account.value.ward
            : ward.value,
        streetAddress: street,
        locality: account.value.locality.contains(district.value)
            ? account.value.locality
            : district.value,
        city: account.value.city.contains(city.value)
            ? account.value.city
            : city.value,
        postalCode: "000000",
        phone: phoneNumber,
        avatar: "",
        dob: account.value.dob.contains(dob.value)
            ? account.value.dob
            : dob.value,
        active: true,
        isMale: isMale.value != account.value.isMale
            ? isMale.value
            : account.value.isMale,
        role: new Role(id: 3, name: "PATIENT", isActive: true));

    account.value = newAccount;
    if (emptyDistrict.isFalse && emptyWard.isFalse) {
      FetchAPI.updateMyAccountInfo(account.value, image.value.path);
      done.value = true;
    }
  }
}
