import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:ubs/sharing_widget/widget_fun.dart';
import 'package:ubs/utils/constants.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class LoginHome extends StatelessWidget {
  const LoginHome({super.key});

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;

    return SafeArea(
        child: Scaffold(
      body: Container(
        color: COLOR_WHITE,
        child: Stack(
          children: [
            Positioned(
                top: 20,
                left: 20,
                child: IconButton(
                  icon: Icon(Icons.close, size: 70.sp),
                  onPressed: () {},
                )),
            Positioned(
              top: height * 0.20,
              left: (width - 350.sp) / 2,
              child: SizedBox(
                  height: 350.sp,
                  width: 350.sp,
                  child: Image.asset("lib/assets/images/BiS.png")),
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: Container(
                // height: 250,
                width: double.infinity,
                color: COLOR_PRIMARY,
                padding: EdgeInsets.symmetric(vertical: 50.h),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    loginBtn(
                        "Continue with Phone", Icons.phone_iphone, width * 0.7),
                    addVerticalSpace(30.h),
                    loginBtn("Continue with Phone", FontAwesomeIcons.google,
                        width * 0.7),
                    addVerticalSpace(30.h),
                    Text("OR", style: testStyle(false)),
                    addVerticalSpace(30.h),
                    Text("Login with Email", style: testStyle(false)),
                    addVerticalSpace(30.h),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    ));
  }

  Widget loginBtn(String btnName, IconData btnIcon, double width) {
    return SizedBox(
      width: width,
      child: ElevatedButton.icon(
        onPressed: () {},
        style: ElevatedButton.styleFrom(
            alignment: Alignment.centerLeft,
            padding: EdgeInsets.symmetric(vertical: 25.h, horizontal: 30.w),
            backgroundColor: Colors.white,
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20.r))),
        // icon: Icon(Icons.phone_iphone, size: 20.sp),
        icon: Icon(
          btnIcon,
          color: Colors.black,
          size: 50.w,
        ),
        label: Padding(
          padding: EdgeInsets.symmetric(horizontal: 22.w),
          child: Text(
            btnName,
            style: TextStyle(
              color: Colors.black,
              fontWeight: FontWeight.w600,
              fontSize: 35.sp,
            ),
          ),
        ),
      ),
    );
  }
}

testStyle(bool underline) {
  return TextStyle(
      color: Colors.black,
      fontWeight: FontWeight.w500,
      fontSize: 35.sp,
      // decoration: underline == true ? TextDecoration.underline : TextDecoration.none
      decoration: TextDecoration.underline);
}
