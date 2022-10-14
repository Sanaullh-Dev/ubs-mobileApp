import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ubs/pages/login/controller/login_controller.dart';
import 'package:ubs/pages/login/otp_verify.dart';
import 'package:ubs/pages/login/widget/common_widget.dart';
import 'package:ubs/pages/login/widget/user_id.dart';
import 'package:ubs/sharing_widget/next_btn.dart';


class LoginPage extends StatelessWidget {
  final String signType;
  const LoginPage({super.key, required this.signType});

  @override
  Widget build(BuildContext context) {
    final design loginControl = Get.find<design>();

    TextEditingController countryCode = TextEditingController(text: "+91");
    String uname = "";
    var size = MediaQuery.of(context).size;

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
                  await loginControl.phoneAuth(
                    countryCode: countryCode.text,
                    codeSent: () {
                      Get.to(const OtpVerify());
                    },
                  );
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
