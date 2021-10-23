import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:telemedicine_mobile/api/fetch_api.dart';

class GoogleSignInController  with ChangeNotifier  {
  var _googleSignIn = GoogleSignIn();
  GoogleSignInAccount? _user;
  GoogleSignInAccount get user => _user!;

  Future<bool> googleLogin() async {
    try {
      final googleUser = await _googleSignIn.signIn();
      if (googleUser == null) return false;
      _user = googleUser;
      final googleAuth = await googleUser.authentication;

      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );
      var response = await FirebaseAuth.instance.signInWithCredential(credential);
      await FetchAPI.loginWithToken(await response.user!.getIdToken());
      notifyListeners();
      return true;
    }catch(e)
    {
      print(e);
      return false;
    }
  }

  logOut() async {
    this._user = await _googleSignIn.signOut();
    final storage = new FlutterSecureStorage();
    storage.deleteAll();
    notifyListeners();
  }
}
