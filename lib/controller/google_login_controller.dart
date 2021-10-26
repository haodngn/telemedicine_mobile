import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:telemedicine_mobile/api/fetch_api.dart';
import 'package:telemedicine_mobile/controller/account_controller.dart';
import 'package:telemedicine_mobile/controller/patient_history_controller.dart';
import 'package:telemedicine_mobile/controller/patient_profile_controller.dart';

class GoogleSignInController with ChangeNotifier {
  var _googleSignIn = GoogleSignIn();
  GoogleSignInAccount? _user;
  GoogleSignInAccount get user => _user!;

  Future<bool> googleLogin() async {
    final accountController = Get.put(AccountController());
    final patientHistoryController = Get.put(PatientHistoryController());
    final patientProfileController = Get.put(PatientProfileController());

    bool statusLogin = false;
    try {
      accountController.isLoading.value = true;
      // final googleUser = await _googleSignIn.signIn();
      // if (googleUser == null) return false;
      // _user = googleUser;
      // final googleAuth = await googleUser.authentication;

      // final credential = GoogleAuthProvider.credential(
      //   accessToken: googleAuth.accessToken,
      //   idToken: googleAuth.idToken,
      // );
      // var response = await FirebaseAuth.instance.signInWithCredential(credential);
      await FetchAPI.loginWithToken("abc").then((value) {
        patientProfileController.getMyPatient();
      }); //await response.user!.getIdToken());
      notifyListeners();
      statusLogin = true;
    } catch (e) {
      print(e);
      statusLogin = false;
    } finally {
      accountController.isLoading.value = false;
    }
    return statusLogin;
  }

  logOut() async {
    this._user = await _googleSignIn.signOut();
    final storage = new FlutterSecureStorage();
    storage.deleteAll();
    notifyListeners();
  }
}
