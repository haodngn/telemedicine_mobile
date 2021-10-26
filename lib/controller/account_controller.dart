import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:telemedicine_mobile/models/Account.dart';
import 'package:telemedicine_mobile/models/Role.dart';

class AccountController extends GetxController
{
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
      active: false,
      isMale: false,
      role: new Role(id: 0, name: "", isActive: true)).obs;

  RxBool isLoading = false.obs;
}