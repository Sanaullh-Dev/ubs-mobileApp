import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:ubs/model/user_data.dart';
import 'package:ubs/services/secure_storage.dart';

class LoginController extends GetxController {
  static final StorageService _storageService = StorageService();
  final googleSignIn = GoogleSignIn();
  GoogleSignInAccount? _user;
  GoogleSignInAccount get user => _user!;
  RxString loginId = "".obs;
  Rx<String> loginStatus = "".obs;
  Rx<UserData>? uData;
  Rx<List<StorageItem>>? items;

  @override
  void onInit() async {
    items?.value = await _storageService.readAllSecureData();
    getSecureValue();
  }

  void getSecureValue() async {
    var Uname = await _storageService.readSecureData("LoginName");
    var Upass = await _storageService.readSecureData("LoginPass");
    uData!.value = UserData(uname: Uname!, upass: Upass!);
    if (Uname.isEmpty || Upass.isEmpty) {
      loginStatus.value = "no";
    } else {
      loginStatus.value = "logged";
    }
  }

  Future<bool> writeSecure(String loginId, String loginPass) async {
    try {
      await _storageService.writeSecureData(StorageItem("LoginName", loginId));
      await _storageService
          .writeSecureData(StorageItem("LoginPass", loginPass));
      loginStatus.value = "login";
      return true;
    } catch (e) {
      return false;
    }
  }

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
