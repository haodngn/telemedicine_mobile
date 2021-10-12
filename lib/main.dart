import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:telemedicine_mobile/Screens/bottom_nav_screen.dart';
import 'package:telemedicine_mobile/Screens/chatbot_screen.dart';
import 'package:telemedicine_mobile/Screens/components/loading.dart';
import 'package:telemedicine_mobile/Screens/consultation_rating_screen.dart';
import 'package:telemedicine_mobile/Screens/edit_patient_profile_screen.dart';
import 'package:telemedicine_mobile/Screens/filter_screen.dart';
import 'package:telemedicine_mobile/Screens/form_after_login_screen.dart';
import 'package:telemedicine_mobile/Screens/home_screen.dart';
import 'package:telemedicine_mobile/Screens/list_doctor_screen.dart';
import 'package:telemedicine_mobile/Screens/patient_history_screen.dart';
import 'package:telemedicine_mobile/Screens/patient_profile_screen.dart';
import 'package:telemedicine_mobile/Screens/view_drug_screen.dart';
import 'package:telemedicine_mobile/controller/formafterlogin_controller.dart';
import 'controller/facebook_login_controller.dart';
import 'controller/google_login_controller.dart';
import 'package:telemedicine_mobile/Screens/login_screen.dart';
import 'package:firebase_core/firebase_core.dart';

Future main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => GoogleSignInController(),
          child: LoadingIcon(),
        ),
        ChangeNotifierProvider(
          create: (context) => FacebookSignInController(),
          child: LoadingIcon(),
        ),
      ],
      child: GetMaterialApp(
        title: 'Tele Medicine',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: LoginScreen(),
      ),
    );
  }
}
