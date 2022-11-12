import 'dart:io';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:ubs/model/users_data.dart';
import 'package:ubs/services/remote_services.dart';
import 'package:ubs/utils/custom_fun.dart';

class AccountController extends GetxController {
  Rx<UsersData> userData =
      UsersData(logId: "", logPass: "", uName: "", loginWith: "").obs;
  RxBool loading = false.obs;
  RxString isPhoto = "".obs;
  Rx<File> userPhoto = File("").obs;

  // @override
  // void onInit() {
  //   super.onInit();
  // }

  void fetchUserData(String userId) async {
    userPhoto.value = File("");
    isPhoto.value = "";
    var res = await RemoteServices.checkUser(userId);
    if (res != null) {
      userData.value = res;
      if (userData.value.uPhoto != null) {
        isPhoto.value = "url";
        userPhoto.value = File(getLink(userData.value.uPhoto));
      }
    }
  }

  Future<bool> updateUserData() async {
    loading.value = true;
    if (userPhoto != null) {
      userData.value.uPhoto = userPhoto.value.path;
    }
    var res =
        await RemoteServices.updateUserData(userData.value, isPhoto.value);
    loading.value = false;
    return res;
  }

  Future imagePickFromGallery(String pickType) async {
    try {
      final image = await ImagePicker().pickImage(
          source:
              pickType == "gallery" ? ImageSource.gallery : ImageSource.camera);
      if (image == null) return;
      userPhoto.value = File(image.path);
      isPhoto.value = "local";
    } on PlatformException catch (e) {
      print('Failed to pick image: $e');
    }
  }

  removerImage() {
    isPhoto.value = "";
    userPhoto.value = File("");
    userData.value.uPhoto = "";
  }
}
