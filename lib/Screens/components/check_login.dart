import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:telemedicine_mobile/Screens/bottom_nav_screen.dart';
import 'package:telemedicine_mobile/Screens/components/loading.dart';

class CheckLogin extends StatelessWidget {
  const CheckLogin({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) => Scaffold(
        body: StreamBuilder(
            stream: FirebaseAuth.instance.authStateChanges(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return Center(child: CircularProgressIndicator());
              } else if (snapshot.hasData) {
                // return HomeScreen();
                return BottomNavScreen();
              } else if (snapshot.hasError) {
                return Center(child: Text("Something Went Wrong!"));
              } else {
                return LoadingIcon();
              }
            }),
      );
}
