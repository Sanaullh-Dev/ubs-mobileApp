import 'package:flutter/material.dart';

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
    height: 25,
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
    child: const Text(
      "Features",
      style: TextStyle(fontSize: 10, letterSpacing: 0.8, color: Colors.black),
    ),
  );
}


