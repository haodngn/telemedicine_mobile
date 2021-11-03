import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:telemedicine_mobile/Screens/login_screen.dart';
import 'package:telemedicine_mobile/api/fetch_api.dart';
import 'package:telemedicine_mobile/main.dart';

import 'account_controller.dart';

class FacebookSignInController with ChangeNotifier {
  Map? userData;

  Future<String> facebookLogin() async {
    final accountController = Get.put(AccountController());
    String statusLogin = "";
    try {
      accountController.isLoading.value = true;
      final LoginResult result = await FacebookAuth.instance.login();
      if (result.status == LoginStatus.cancelled) {
        Get.to(LoginScreen());
        return "";
      }
      if (result.status == LoginStatus.failed) {
        Get.to(LoginScreen());
        return "";
      }
      if (result.status == LoginStatus.success) {
        final OAuthCredential facebookAuthCredential =
            FacebookAuthProvider.credential(result.accessToken!.token);
        UserCredential user = await FirebaseAuth.instance
            .signInWithCredential(facebookAuthCredential);
        await FetchAPI.loginWithToken(await user.user!.getIdToken())
            .then((value) => {statusLogin = value});
        notifyListeners();
      }
      return "";
    } catch (e) {
      print("err");
      print(e.toString());
      Get.to(LoginScreen());
      statusLogin = "";
    } finally {
      accountController.isLoading.value = false;
    }
    return statusLogin;
  }
}
