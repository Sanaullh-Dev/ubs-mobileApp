import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/animation.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:shared_preferences/shared_preferences.dart';

class design extends GetxController {
  final googleSignIn = GoogleSignIn();
  GoogleSignInAccount? _user;
  GoogleSignInAccount get user => _user!;
  RxString loginStatus = "no".obs;
  RxString loginId = "".obs;
  // Rx<String> passwordScreen = "userId".obs;

  Future googleLogin() async {
    loginStatus.value = "waiting";
    final googleUser = await googleSignIn.signIn();
    if (googleUser == null) {
      loginStatus.value = "no";
      return;
    }

    _user = googleUser;
    final googleAuth = await googleUser.authentication;

    final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken, idToken: googleAuth.idToken);

    await FirebaseAuth.instance.signInWithCredential(credential);
    loginStatus.value = "login";
  }
  // design

  final Future<SharedPreferences> _prefs = SharedPreferences.getInstance();

  void getLoginDetails() async {
    final SharedPreferences prefs = await _prefs;
    if (prefs.getString("uid") != null) {
      loginStatus.value = "login";
    }else {
      loginStatus.value = "no";
    }
  }
}
