import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

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
