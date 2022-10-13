import 'package:flutter/material.dart';
import 'package:ubs/sharing_widget/widget_fun.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:ubs/utils/constants.dart';
import 'package:ubs/utils/text_style.dart';

class PasswordScreen extends StatelessWidget {
  final double screenWidget;
  final String loginType;
  const PasswordScreen({super.key, required this.screenWidget, required this.loginType});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      width: screenWidget,
      padding: EdgeInsets.symmetric(horizontal: 50.h),
      child: Column(
        // mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          addVerticalSpace(50.h),
          SizedBox(
            width: 180.w,
            height: 180.w,
            child: Image.asset("lib/assets/images/user.png"),
          ),
          addVerticalSpace(20.h),
          Text("Welcome 98888888", style: heading5),
          addVerticalSpace(10.h),
          Text("Enter your Password", style: heading1),
          addVerticalSpace(40.h),
          TextField(
            style: textfield,
            keyboardType: TextInputType.number,
            maxLength: 10,
            autofocus: true,
            decoration: InputDecoration(
                counterText: "",
                hintText: "Password",
                hintStyle: heading5,
                suffixIcon: IconButton(
                  icon: Icon(
                    Icons.remove_red_eye,
                    color: COLOR_BLACK,
                    size: 50.sp,
                  ),
                  onPressed: () {},
                )),
          ),
          addVerticalSpace(40.h),
          Text("Forgot your password?",
              style: TextStyle(
                color: Colors.blue[700],
                fontWeight: FontWeight.w600,
                fontSize: 28.sp,
                letterSpacing: 0.8,
              ))
        ],
      ),
    );
  }
}
