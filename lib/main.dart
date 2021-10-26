import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:provider/provider.dart';
import 'package:telemedicine_mobile/Screens/components/loading.dart';
import 'package:telemedicine_mobile/Screens/home_screen.dart';
import 'controller/facebook_login_controller.dart';
import 'controller/google_login_controller.dart';
import 'package:telemedicine_mobile/Screens/login_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

Future main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  await [Permission.microphone, Permission.camera].request();
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
        debugShowCheckedModeBanner: false,
        home: LoginScreen(),
        localizationsDelegates: [
          GlobalWidgetsLocalizations.delegate,
          GlobalMaterialLocalizations.delegate,
          GlobalCupertinoLocalizations.delegate,
        ],
        supportedLocales: [Locale('en', 'US')],
      ),

    );
  }
}
