import 'package:flutter/material.dart';
import 'package:telemedicine_mobile/constant.dart';

class ProfileScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("ProfileScreen"),
        backgroundColor: kBlueColor,
      ),
      body: SafeArea(
          child: SingleChildScrollView(
            child: Text("ProfileScreen"
            ),
          )
      ),
    );
  }
}

