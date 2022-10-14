import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/animation.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';

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

  Future phoneAuth({String? countryCode, VoidCallback? codeSent}) async {
    if (countryCode != null && loginId.value.length == 10) {
      var pno = countryCode+ loginId.value;
      print(pno);
      await FirebaseAuth.instance.verifyPhoneNumber(
        phoneNumber: pno,
        verificationCompleted: (PhoneAuthCredential credential) {},
        verificationFailed: (FirebaseAuthException e) {},
        codeSent: (String verificationId, int? resendToken) => codeSent,        
        // {
          
        //   // passwordScreen.value = ! passwordScreen.value;
        // },
        codeAutoRetrievalTimeout: (String verificationId) {},
      );
    }
  }
}
