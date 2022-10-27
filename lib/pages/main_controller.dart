import 'dart:ffi';

import 'package:get/get.dart';
import 'package:ubs/services/secure_storage.dart';

class MainController extends GetxController {
  static final StorageService _storageService = StorageService();
  Rx<List<StorageItem>>? items;
  RxInt selectPage = 0.obs;
  Rx<String> loginStatus = "".obs;
  UserData? uData;

  @override
  void onInit() async {
    items?.value = await _storageService.readAllSecureData();
    // print(items);
    getSecureValue();
  }

  Future<bool> writeSecure(String loginId, String loginPass) async {
    try {
      await _storageService.writeSecureData(StorageItem("LoginName", loginId));
      await _storageService
          .writeSecureData(StorageItem("LoginPass", loginPass));
      return true;
    } catch (e) {
      return false;
    }
  }

  void getSecureValue() async {
    var Uname = await _storageService.readSecureData("LoginName");
    var Upass = await _storageService.readSecureData("LoginPass");
    uData = new UserData(Uname!, Upass!);
  }
}

class UserData {
  UserData(this.Uname, this.Upass);
  final String Uname;
  final String Upass;
}
