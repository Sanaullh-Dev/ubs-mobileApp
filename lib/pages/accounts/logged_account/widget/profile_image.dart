import 'package:flutter/material.dart';
import 'package:ubs/pages/accounts/controller/account_controller.dart';
import 'package:ubs/sharing_widget/show_image.dart';
import 'package:ubs/utils/custom_fun.dart';

Widget getProfileImage(AccountController controller) {
  if (controller.isPhoto.value == "") {
    return Image.asset("lib/assets/images/user.png");
  } else if (controller.isPhoto.value == "local") {
    return Image.file(controller.userPhoto!, fit: BoxFit.cover);
  } else if (controller.isPhoto.value == "url") {
    return ShowImage(imageUrl: getLink(controller.userData.value.uPhoto));
  }
  return Image.asset("lib/assets/images/user.png");
}
