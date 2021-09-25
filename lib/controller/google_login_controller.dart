import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:telemedicine_mobile/Screens/home_screen.dart';

class GoogleSignInController with ChangeNotifier{
  var _googleSignIn = GoogleSignIn();
  GoogleSignInAccount? googleAccount;

  login() async {
    this.googleAccount =await _googleSignIn.signIn();
    notifyListeners();
    // Navigator.push(context, MaterialPageRoute(builder: backtoHome));
  }
  // Widget backtoHome(BuildContext context){
  //   return HomeScreen();
  // }

  logOut() async {
    this.googleAccount =await _googleSignIn.signOut();
    notifyListeners();
  }
}