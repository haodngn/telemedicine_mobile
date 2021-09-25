import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:telemedicine_mobile/screens/user_information.dart';

void main() async {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(),
      home: UserInformation(),
    );
  }
}
