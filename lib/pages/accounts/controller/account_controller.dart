import 'package:get/get.dart';
import 'package:ubs/model/users_data.dart';
import 'package:ubs/services/remote_services.dart';

class AccountController extends GetxController {
  Rx<UsersData> userData =
      UsersData(logId: "", logPass: "", uName: "", loginWith: "").obs;

  // @override
  // void onInit() {
  //   super.onInit();
  // }

  void fetchUserData(String userId) async {
    var res = await RemoteServices.checkUser(userId);
    if (res != null) {
      userData.value = res;
    }
  }
}
