import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:ubs/model/user_login.dart';
import 'package:ubs/model/users_data.dart';
import 'package:ubs/services/remote_services.dart';
import 'package:ubs/services/secure_storage.dart';

class LoginController extends GetxController {
  static final StorageService _storageService = StorageService();
  final googleSignIn = GoogleSignIn();
  // GoogleSignInAccount? _user;
  // GoogleSignInAccount get user => _user!;
  RxString loginId = "".obs;
  Rx<String> loginStatus = "checking".obs;
  Rx<UserLogin> uData = UserLogin(userId: "", upass: "").obs;
  Rx<List<StorageItem>>? items;

  @override
  void onInit() async {
    items?.value = await _storageService.readAllSecureData();
    getSecureValue();
  }

  void getSecureValue() async {
    // _storageService.deleteSecureData("LoginId");
    var userId = await _storageService.readSecureData("LoginId");
    var Upass = await _storageService.readSecureData("LoginPass");
    if (userId == null) {
      loginStatus.value = "no";
    } else {
      var res = await RemoteServices.userLogin(userId, Upass ?? "");
      if (res == "logged") {
        uData.value = UserLogin(userId: userId, upass: Upass ?? "");
        loginStatus.value = "logged";
      }
    }
  }

  Future<bool> writeSecure(String loginId, String loginPass) async {
    try {
      await _storageService.writeSecureData(StorageItem("LoginId", loginId));
      await _storageService
          .writeSecureData(StorageItem("LoginPass", loginPass));
      loginStatus.value = "logged";
      return true;
    } catch (e) {
      return false;
    }
  }

  Future<bool?> googleLogin() async {
    try {
      loginStatus.value = "waiting";
      final googleUser = await googleSignIn.signIn();
      if (googleUser == null) {
        loginStatus.value = "no";
        return false;
      } else {
        var res = await RemoteServices.getUserData(googleUser.email);
        if (res == null) {
          var userData = UsersData.fromJson({
            "log_id": googleUser.email,
            "log_pass": "",
            "u_name": googleUser.displayName,
            "login_with": "google",
            "u_phone": "",
            "u_photo": googleUser.photoUrl,
            "u_email": googleUser.email,
          });

          var res = await RemoteServices.addUser(userData);
          if (res != null) {
            await writeSecure(googleUser.email, "");
            loginStatus.value = "login";
            return true;
          }
        } else {
          await writeSecure(googleUser.email, "");
          return true;
        }
      }
    } catch (e) {}
    return null;
  }

  logoutUser() {
    _storageService.deleteSecureData("LoginId");
    _storageService.deleteSecureData("LoginPass");
  }
}


// _user = googleUser;
// final googleAuth = await googleUser.authentication;
// final credential = GoogleAuthProvider.credential(
//     accessToken: googleAuth.accessToken, idToken: googleAuth.idToken);

// UserCredential usersDB =
//     await FirebaseAuth.instance.signInWithCredential(credential);
// final user = FirebaseAuth.instance.currentUser;
