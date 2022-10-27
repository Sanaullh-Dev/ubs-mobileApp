import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:ubs/model/user_info.dart';
import 'package:ubs/pages/dashboard/dashboard.dart';
import 'package:ubs/pages/login/controller/login_controller.dart';
import 'package:ubs/pages/main_controller.dart';
import 'package:ubs/services/remote_services.dart';
import 'package:ubs/services/secure_storage.dart';
import 'package:ubs/sharing_widget/widget_fun.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:ubs/utils/constants.dart';
import 'package:ubs/utils/text_style.dart';

class PasswordScreen extends StatefulWidget {
  final String userId;
  final bool newUser;
  final String loginType;
  const PasswordScreen(
      {super.key,
      required this.userId,
      required this.newUser,
      required this.loginType});

  @override
  State<PasswordScreen> createState() => _PasswordScreenState();
}

class _PasswordScreenState extends State<PasswordScreen> {
  final MainController mainCont = Get.put(MainController());
  final logging loginControl = Get.find<logging>();
  TextEditingController name = TextEditingController();
  TextEditingController password = TextEditingController();
  Rx<bool> passShow = true.obs;
  UserInfo? userData;
  final _formKey = GlobalKey<FormState>();

  login() async {
    if (_formKey.currentState!.validate()) {
      userData = UserInfo.fromJson({
        "log_pass": password.text,
        "u_name": name.text,
        "login_with": widget.loginType,
        "u_phone": widget.loginType == "phone" ? widget.userId : "",
        "u_email": widget.loginType == "phone" ? "" : widget.userId,
      });
      var res = await RemoteServices.addUser(userData!, widget.loginType);
      if (res != null) {
        bool res = await mainCont.writeSecure(widget.userId, password.text);
        if (res) {
          Get.to(DashboardPage());
        }
      }
    }
  }

  @override
  Widget build(BuildContext context) {
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
                child: Form(
                  key: _formKey,
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
                      Text("Welcome ${widget.userId}", style: heading5),
                      addVerticalSpace(50.h),
                      widget.newUser == false
                          ? const SizedBox()
                          : Text("Name", style: heading2),
                      // addVerticalSpace(5.h),
                      widget.newUser == true
                          ? TextFormField(
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
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Name can not empty';
                                }
                              })
                          : const SizedBox(),
                      addVerticalSpace(widget.newUser ? 80.h : 0),
                      Text("Password", style: heading2),
                      // addVerticalSpace(5.h),
                      TextFormField(
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
                          validator: (value) {
                            if (value == null ||
                                value.isEmpty ||
                                value.length < 6) {
                              return 'minimum length of 6 characters is required';
                            }
                            return null;
                          }),
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
                                disabledBackgroundColor:
                                    const Color(0xFF606060),
                                backgroundColor: const Color(0xFF263238),
                                padding: EdgeInsets.symmetric(vertical: 25.w)),
                            onPressed: login,
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
            ),
          )),
    );
  }
}

       

// <#> Dear Customer, Use code 4760 to login to your BIS account. Never share your OTP with anyone. RT2U4YIusEg
// <#> Dear Customer, Use code 8509 to login to your BIS account. Never share your OTP with anyone. RT2U4YIusEg
