import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:ubs/model/user_info.dart';
import 'package:ubs/pages/login/controller/login_controller.dart';
import 'package:ubs/pages/login/widget/common_widget.dart';
import 'package:ubs/services/remote_services.dart';
import 'package:ubs/sharing_widget/widget_fun.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:ubs/utils/constants.dart';
import 'package:ubs/utils/text_style.dart';

class PasswordScreen extends StatelessWidget {
  final String userId;
  final bool newUser;
  final String loginType;
  const PasswordScreen(
      {super.key,
      required this.userId,
      required this.newUser,
      required this.loginType});

  @override
  Widget build(BuildContext context) {
    final logging loginControl = Get.find<logging>();
    TextEditingController name = TextEditingController();
    TextEditingController password = TextEditingController();
    Rx<bool> passShow = true.obs;
    UserInfo userData;

    return SafeArea(
      child: Scaffold(
          appBar: AppBar(
            title: Text("Login", style: appBarTitle),
          ),
          body: Obx(
            () => Container(
              color: Colors.white,
              padding: EdgeInsets.symmetric(horizontal: 50.h),
              child: SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    addVerticalSpace(50.h),
                    SizedBox(
                      width: 180.w,
                      height: 180.w,
                      child: Image.asset("lib/assets/images/user.png"),
                    ),
                    addVerticalSpace(10.h),
                    Text("Welcome $userId", style: heading5),
                    addVerticalSpace(50.h),
                    newUser == false
                        ? const SizedBox()
                        : Text("Name", style: heading2),
                    // addVerticalSpace(5.h),
                    newUser == true
                        ? TextField(
                            controller: name,
                            style: textfield,
                            keyboardType: TextInputType.name,
                            maxLength: 25,
                            autofocus: true,
                            decoration: InputDecoration(
                              // counterText: "",
                              hintText: "your full name",
                              hintStyle: heading5,
                            ),
                          )
                        : const SizedBox(),
                    addVerticalSpace(newUser ? 80.h : 0),
                    Text("Password", style: heading2),
                    // addVerticalSpace(5.h),
                    TextField(
                      controller: password,
                      obscureText: passShow.value,
                      style: textfield,
                      keyboardType: TextInputType.visiblePassword,
                      maxLength: 15,
                      autofocus: true,
                      decoration: InputDecoration(
                          // counterText: "",
                          hintText: "Password",
                          hintStyle: heading5,
                          suffixIcon: IconButton(
                            icon: Icon(
                              passShow.value
                                  ? FontAwesomeIcons.eyeSlash
                                  : FontAwesomeIcons.eye,
                              color: COLOR_BLACK,
                              size: 50.sp,
                            ),
                            onPressed: () {
                              passShow.value = !passShow.value;
                            },
                          )),
                    ),
                    addVerticalSpace(40.h),
                    Text(
                      "Forgot your password?",
                      style: TextStyle(
                          color: Colors.blue[700],
                          fontWeight: FontWeight.w600,
                          fontSize: 32.sp,
                          letterSpacing: 0.5,
                          decoration: TextDecoration.underline),
                    ),
                    addVerticalSpace(40.h),
                    SizedBox(
                      width: double.infinity,
                      // decoration: onlyTopBorder,
                      child: Padding(
                        padding: EdgeInsets.symmetric(
                            vertical: 30.sp, horizontal: 50.sp),
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                              disabledBackgroundColor: const Color(0xFF606060),
                              backgroundColor: const Color(0xFF263238),
                              padding: EdgeInsets.symmetric(vertical: 25.w)),
                          onPressed: (name.text == "" && password.text == "")
                              ? null
                              : () {
                                  userData = UserInfo.fromJson({
                                    "log_pass": password.text,
                                    "u_name": name.text,
                                    "login_with": loginType,
                                    "u_phone":
                                        loginType == "phone" ? userId : "",
                                    "u_email":
                                        loginType == "phone" ? "" : userId,
                                  });
                                  RemoteServices.addUser(userData, loginType);
                                },
                          child: Text(
                            "Login",
                            style: buttonTextStyle,
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ),
          )),
    );
  }
}

       

// <#> Dear Customer, Use code 4760 to login to your BIS account. Never share your OTP with anyone. RT2U4YIusEg
// <#> Dear Customer, Use code 8509 to login to your BIS account. Never share your OTP with anyone. RT2U4YIusEg
