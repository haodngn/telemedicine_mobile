import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:telemedicine_mobile/api/fetch_address_api.dart';
import 'package:telemedicine_mobile/api/fetch_api.dart';
import 'package:telemedicine_mobile/models/Account.dart';
import 'package:telemedicine_mobile/models/Patient.dart';
import 'package:telemedicine_mobile/models/Role.dart';

class PatientProfileController extends GetxController {
  RxString myEmail = "vantam@gmail.com".obs;

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
}
