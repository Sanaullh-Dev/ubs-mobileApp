import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:ubs/utils/constants.dart';
import 'package:ubs/utils/text_style.dart';

Widget addVerticalSpace(double height) {
  return SizedBox(
    height: height,
  );
}

Widget addHorizontalSpace(double width) {
  return SizedBox(
    width: width,
  );
}

Widget addDivider() {
  return Divider(
    thickness: 2,
    color: Colors.blueGrey.shade200,
    height: 25.h,
  );
}

Widget iconOnButton(IconData iconName) {
  return Icon(
    iconName,
    color: Colors.white,
    size: 26,
  );
}

Widget featuredTag() {
  return Container(
    color: Colors.amber.shade400,
    padding: const EdgeInsets.symmetric(vertical: 3, horizontal: 6),
    child: Text(
      "Features",
      style:
          TextStyle(fontSize: 15.sp, letterSpacing: 0.8, color: Colors.black),
    ),
  );
}

SnackbarController getSnackBarFavorite() {
  return Get.showSnackbar(
    GetSnackBar(
      messageText: Text("Saved into your Favorite", style: snackBarText),
      icon: const Icon(Icons.favorite, color: Colors.red, size: 30),
      duration: const Duration(seconds: 2),
      padding: const EdgeInsets.symmetric(horizontal: 45, vertical: 25),
      margin: const EdgeInsets.only(bottom: 5),
    ),
  );
}

Future<dynamic> alertDialogBox(
    {required BuildContext context,
    required String title,
    required String message,
    required VoidCallback onOK}) {
  return showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
            title: Text(title),
            content: Text(message),
            actionsPadding: const EdgeInsets.only(bottom: 30, top: 40),
            actions: [
              GestureDetector(
                onTap: () {
                  Navigator.of(ctx).pop();
                },
                child: Text('Cancel',
                    style: btnText.copyWith(
                        decoration: TextDecoration.underline,
                        color: Colors.black)),
              ),
              SizedBox(width: 8),
              GestureDetector(
                onTap: () {
                  Navigator.of(ctx).pop();
                },
                child: Text('Accept',
                    style: btnText.copyWith(
                        decoration: TextDecoration.underline,
                        color: COLOR_PRIMARY)),
              ),
              const SizedBox(width: 5),
            ],
          ));
}



 



// Icon(
//         Icons.undo,
//         color: Colors.red,
//         size: 30,
//       )
