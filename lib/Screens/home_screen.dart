import 'package:flutter/material.dart';
import 'package:telemedicine_mobile/constant.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Home"),
        backgroundColor: kBlueColor,
      ),
      body: SafeArea(
          child: SingleChildScrollView(
        child: Text("Detail Home Screen"),
      )),
    );
  }
}
