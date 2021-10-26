import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:telemedicine_mobile/Screens/bottom_nav_screen.dart';
import 'package:telemedicine_mobile/Screens/components/check_login.dart';
import 'package:telemedicine_mobile/Screens/form_after_login_screen.dart';
import 'package:telemedicine_mobile/controller/google_login_controller.dart';
import 'package:telemedicine_mobile/controller/patient_history_controller.dart';

//button login with google

class GoogleButton extends StatelessWidget {
  GoogleButton({
    Key? key,
  }) : super(key: key);
  final patientHistoryController = Get.put(PatientHistoryController());
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      child: GestureDetector(
        child: Image.asset(
          "assets/images/google.png",
          width: 250,
        ),
        onTap: () async {
          patientHistoryController.getNearestHealthCheck();
          patientHistoryController.getTopDoctor();
          bool checkLogin =
              await Provider.of<GoogleSignInController>(context, listen: false)
                  .googleLogin();
          if (checkLogin) {
            Navigator.push(
                context, MaterialPageRoute(builder: checkLoginGoogle));
          }
        },
      ),
    );
  }

  Widget checkLoginGoogle(BuildContext context) {
    // if (true)
    //   return UserInformation();
    // else
    return BottomNavScreen();
  }
}
