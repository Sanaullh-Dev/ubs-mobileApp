import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';

class logging extends GetxController {
  final googleSignIn = GoogleSignIn();
  GoogleSignInAccount? _user;
  GoogleSignInAccount get user => _user!;
  RxString loginStatus = "no".obs;
  RxString loginId = "".obs;
  
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
    
  // checking logging details 
  // void getLoginDetails() async {
  //   if (prefs.getString("uid") != null) {
  //     loginStatus.value = "login";
  //   }else {
  //     loginStatus.value = "no";
  //   }
  // }
}
