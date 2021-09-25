import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:telemedicine_mobile/Screens/home_screen.dart';
import 'package:telemedicine_mobile/controller/google_login_controller.dart';

//button login with google

class GoogleButton extends StatelessWidget {
  const GoogleButton({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      child: GestureDetector(
        child: Image.asset(
          "assets/images/google.png",
          width: 250,
        ),
        onTap: () {
          Provider.of<GoogleSignInController>(context, listen: false).login();
          Navigator.push(context, MaterialPageRoute(builder: backtoHome));
        },
      ),

    );
  }
  Widget backtoHome(BuildContext context){
    return HomeScreen();
  }
}