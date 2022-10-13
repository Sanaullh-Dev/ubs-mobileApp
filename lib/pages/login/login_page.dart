import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ubs/pages/login/controller/login_controller.dart';
import 'package:ubs/pages/login/widget/password.dart';
import 'package:ubs/pages/login/widget/user_id.dart';
import 'package:ubs/sharing_widget/next_btn.dart';
import 'package:ubs/utils/text_style.dart';

class LoginPage extends StatelessWidget {
  final String signType;
  const LoginPage({super.key, required this.signType});

  @override
  Widget build(BuildContext context) {
    final LoginController loginControl = Get.find<LoginController>();
    
    TextEditingController countryCode = TextEditingController(text: "+91");
    String uname = "";
    var size = MediaQuery.of(context).size;

    return SafeArea(
      child: WillPopScope(
        onWillPop: () async {
          if (loginControl.passwordScreen.value == true) {
            loginControl.passwordScreen.value = false;
            return false;
          }
          return true;
        },
        child: Scaffold(
          appBar: AppBar(
            leading: IconButton(
              icon: const Icon(Icons.close),
              onPressed: () {},
            ),
            title: Text("Login", style: appBarTitle),
          ),
          body: Obx(
            (() => Stack(
                  children: [
                    UserId(idType: signType),
                    AnimatedPositioned(
                      left: loginControl.passwordScreen.value == true ? 0 : size.width + 20,
                      top: 0,
                      duration: const Duration(milliseconds: 500),
                      curve: Curves.easeIn,
                      child: PasswordScreen(
                          screenWidget: size.width, loginType: signType),
                    ),
                    NextButton(
                        enable: false,
                        labelText: loginControl.passwordScreen.value ? "Login" : "Next",
                        onPress: () async {
                          if(signType == "phone") {
                            await loginControl.phoneAuth(
                              countryCode: countryCode.text,
                              );
                          }else if(signType == "email") {
                            loginControl.passwordScreen.value = ! loginControl.passwordScreen.value;
                          }
                          
                        })
                  ],
                )),
          ),
        ),
      ),
    );
  }
}
