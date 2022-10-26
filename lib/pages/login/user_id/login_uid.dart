import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sms_autofill/sms_autofill.dart';
import 'package:ubs/pages/login/Verify_otp/auto_verify.dart';
import 'package:ubs/pages/login/controller/login_controller.dart';
import 'package:ubs/pages/login/password/password_screen.dart';
import 'package:ubs/pages/login/widget/common_widget.dart';
import 'package:ubs/pages/login/user_id/user_id.dart';
import 'package:ubs/services/remote_services.dart';
import 'package:ubs/sharing_widget/next_btn.dart';

class LoginUid extends StatelessWidget {
  final String signType;
  LoginUid({super.key, required this.signType});

  String appSignature = "";
  bool newUser = false;

  getAppSing() async {
    appSignature = await SmsAutoFill().getAppSignature;
    print("Signature: $appSignature");
  }

  @override
  Widget build(BuildContext context) {
    final logging loginControl = Get.find<logging>();
    TextEditingController countryCode = TextEditingController(text: "+91");
    getAppSing();

    return SafeArea(
      child: Scaffold(
        appBar: appBar("Login"),
        body: Stack(
          children: [
            UserId(idType: signType),
            NextButton(
              enable: false,
              labelText: signType == "phone" ? "Get OTP" : "Next",
              onPress: () async {
                String userId = "91${loginControl.loginId.value}";
                var ck = await RemoteServices.checkUser(userId);
                if (ck == null) {
                  if (signType == "phone") {
                    if (loginControl.loginId.value.length <= 10) {
                      // var res =
                      //     await RemoteServices.getOTP(userId, appSignature);
                      // if (res != null) {
                      // Map<String, dynamic> result = jsonDecode(res);                      
                      //   Get.to(AutoVerify(hashNo: result["hash"], userId: userId,appSignature: appSignature,));
                      // }
                      Get.to(PasswordScreen(userId: userId, newUser: true, loginType: signType));
                    } else {
                      Get.to(PasswordScreen(userId: userId, newUser: false, loginType: signType));
                    }
                  } else if (signType == "email") {
                    // loginControl.passwordScreen.value = ! loginControl.passwordScreen.value;
                  }
                }
              },
            )
          ],
        ),
      ),
    );
  }
}
