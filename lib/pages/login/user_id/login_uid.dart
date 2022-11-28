import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:sms_autofill/sms_autofill.dart';
import 'package:ubs/model/users_data.dart';
import 'package:ubs/pages/login/Verify_otp/auto_verify.dart';
import 'package:ubs/pages/login/controller/login_controller.dart';
import 'package:ubs/pages/login/password/password_screen.dart';
import 'package:ubs/pages/login/widget/common_widget.dart';
import 'package:ubs/pages/login/user_id/widget/user_id.dart';
import 'package:ubs/services/remote_services.dart';
import 'package:ubs/sharing_widget/next_btn.dart';

class LoginUid extends StatefulWidget {
  final String signType;
  const LoginUid({super.key, required this.signType});

  @override
  State<LoginUid> createState() => _LoginUidState();
}

class _LoginUidState extends State<LoginUid> {
  String appSignature = "";
  bool newUser = false;
  bool isError = false;

  @override
  void initState() {
    super.initState();
    getAppSing();
    isError = false;
  }

  getAppSing() async {
    appSignature = await SmsAutoFill().getAppSignature;
    print("Signature: $appSignature");
  }

  @override
  Widget build(BuildContext context) {
    final LoginController loginControl = Get.find<LoginController>();
    // TextEditingController countryCode = TextEditingController(text: "+91");

    return SafeArea(
      child: Scaffold(
        appBar: appBar(
            titleName: "Login",
            onPress: () {
              Navigator.pop(context);
            }),
        body: Stack(
          children: [
            UserId(idType: widget.signType, isError: isError),
            NextButton(
              enable: false,
              labelText: widget.signType == "phone" ? "Get OTP" : "Next",
              onPress: () async {
                String userId = "91${loginControl.loginId.value}";
                UsersData? ck = await RemoteServices.getUserData(userId);
                if (ck == null) {
                  if (widget.signType == "phone") {
                    if (loginControl.loginId.value.length == 10 &&
                        loginControl.loginId.value.isNumericOnly) {
                      var res =
                          await RemoteServices.getOTP(userId, appSignature);
                      if (res != null) {
                      Map<String, dynamic> result = jsonDecode(res);
                        Get.to(AutoVerify(hashNo: result["hash"], userId: userId,appSignature: appSignature,));
                      }
                      // Get.to(PasswordScreen(
                      //     userId: userId,
                      //     newUser: true,
                      //     loginType: widget.signType));
                    } else {
                      setState(() => isError = true);
                      // Get.to(PasswordScreen(
                      //     userId: userId, newUser: false, loginType: signType));
                    }
                  } else if (widget.signType == "email" &&
                      loginControl.loginId.value.isEmail) {
                    // loginControl.passwordScreen.value = ! loginControl.passwordScreen.value;
                    Get.to(PasswordScreen(
                        userId: userId,
                        newUser: true,
                        loginType: widget.signType));
                  }
                } else {
                  Get.to(PasswordScreen(
                      userName: ck.uName,
                      userId: userId,
                      newUser: false,
                      loginType: widget.signType));
                }
              },
            )
          ],
        ),
      ),
    );
  }
}
