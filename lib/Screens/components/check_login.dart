import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:telemedicine_mobile/Screens/components/loading.dart';
import 'package:telemedicine_mobile/Screens/form_after_login_screen.dart';

class CheckLogin extends StatelessWidget {
  CheckLogin({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) => Scaffold(
        body: StreamBuilder(
            stream: FirebaseAuth.instance.authStateChanges(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return Center(child: CircularProgressIndicator());
              } else if (snapshot.hasData) {
                //  return BottomNavScreen();
                return UserInformation();
              } else if (snapshot.hasError) {
                return Center(child: Text("Something Went Wrong!"));
              } else {
                return LoadingIcon();
              }
            }),
      );
}
