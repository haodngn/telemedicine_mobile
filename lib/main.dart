import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:telemedicine_mobile/Screens/test_screen.dart';
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
          child: TestScreen(),
        ),
        ChangeNotifierProvider(
          create: (context) => FacebookSignInController(),
          child: LoginScreen(),
        ),
      ],
      child: MaterialApp(
        title: 'Tele Medicine',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: LoginScreen(),
      ),
    );
  }
}
