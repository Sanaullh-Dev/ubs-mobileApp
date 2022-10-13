import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/animation.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';

class LoginController extends GetxController {
  final googleSignIn = GoogleSignIn();
  GoogleSignInAccount? _user;
  GoogleSignInAccount get user => _user!;
  RxString loginStatus = "no".obs;
  RxString loginId = "".obs;
  Rx<bool> passwordScreen = false.obs;

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

  Future phoneAuth({String? countryCode}) async {
    if (countryCode != null && loginId.value.length == 10) {
      await FirebaseAuth.instance.verifyPhoneNumber(
        phoneNumber: countryCode+ loginId.value,
        verificationCompleted: (PhoneAuthCredential credential) {},
        verificationFailed: (FirebaseAuthException e) {},
        codeSent: (String verificationId, int? resendToken) {
          print("verificationId :->$verificationId");
          passwordScreen.value = ! passwordScreen.value;
        },
        codeAutoRetrievalTimeout: (String verificationId) {},
      );
    }
  }
}
