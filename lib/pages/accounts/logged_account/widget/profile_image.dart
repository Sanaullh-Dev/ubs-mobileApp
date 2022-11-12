import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ubs/pages/accounts/controller/account_controller.dart';
import 'package:ubs/sharing_widget/show_image.dart';
import 'package:ubs/utils/constants.dart';
import 'package:ubs/utils/custom_fun.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class GetProfileImage extends StatelessWidget {
  final double imgSize;

  GetProfileImage({super.key, required this.imgSize});

  final AccountController accountController = Get.find<AccountController>();

  @override
  Widget build(BuildContext context) {
    return Container(
      width: imgSize.sp,
      height: imgSize.sp,
      decoration: const BoxDecoration(
        boxShadow: [
          BoxShadow(
            offset: Offset(1, 1),
            blurStyle: BlurStyle.normal,
            blurRadius: 5,
            color: Color.fromARGB(132, 0, 0, 0),
          )
        ],
        borderRadius: const BorderRadius.all(Radius.circular(100)),
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(100.0),
        child: getImage(),
      ),
    );
  }

  Widget getImage() {
    if (accountController.isPhoto.value == "") {
      return Image.asset("lib/assets/images/user.png");
    } else if (accountController.isPhoto.value == "local" &&
        accountController.userPhoto.value != null) {
      return Image.file(accountController.userPhoto.value, fit: BoxFit.cover);
    } else if (accountController.isPhoto.value == "url") {
      return ShowImage(
          imageUrl: getLink(accountController.userData.value.uPhoto));
    }
    return Image.asset("lib/assets/images/user.png");
  }
}
