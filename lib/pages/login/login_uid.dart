import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sms_autofill/sms_autofill.dart';
import 'package:ubs/pages/login/autoVerifyOTP/auto_verify.dart';
import 'package:ubs/pages/login/controller/login_controller.dart';
import 'package:ubs/pages/login/otp_verify.dart';
import 'package:ubs/pages/login/widget/common_widget.dart';
import 'package:ubs/pages/login/widget/user_id.dart';
import 'package:ubs/services/remote_services.dart';
import 'package:ubs/sharing_widget/next_btn.dart';

class LoginUid extends StatelessWidget {
  final String signType;
  LoginUid({super.key, required this.signType});

  String app_signature = "";

  getAppSing() async {
    app_signature = await SmsAutoFill().getAppSignature;
    print("Signature: $app_signature");
  }

  @override
  Widget build(BuildContext context) {
    final logging loginControl = Get.find<logging>();

    TextEditingController countryCode = TextEditingController(text: "+91");
    // String uname = "";
    // var size = MediaQuery.of(context).size;

    getAppSing();

    return SafeArea(
      child: Scaffold(
        appBar: appBar("Login"),
        body: Stack(
          children: [
            UserId(idType: signType),
            // AnimatedPositioned(
            //   left: loginControl.passwordScreen.value == true ? 0 : size.width + 20,
            //   top: 0,
            //   duration: const Duration(milliseconds: 500),
            //   curve: Curves.easeIn,
            //   child: PasswordScreen(
            //       screenWidget: size.width, loginType: signType),
            // ),

            NextButton(
              enable: false,
              labelText: signType == "phone" ? "Get OTP" : "Next",
              onPress: () async {
                if (signType == "phone") {
                  if (loginControl.loginId.value.length <= 10) {
                    var res = await RemoteServices.getOTP(
                        "+91${loginControl.loginId}", app_signature);
                    if (res != null) {
                      Get.to(const AutoVerify());
                    }
                  }
                } else if (signType == "email") {
                  // loginControl.passwordScreen.value = ! loginControl.passwordScreen.value;
                }
              },
            )
          ],
        ),
      ),
    );
  }
}
