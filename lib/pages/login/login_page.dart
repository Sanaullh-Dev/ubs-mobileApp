import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ubs/pages/login/widget/password.dart';
import 'package:ubs/pages/login/widget/user_name.dart';
import 'package:ubs/sharing_widget/next_btn.dart';
import 'package:ubs/utils/text_style.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    TextEditingController countryCode = new TextEditingController();
    TextEditingController loginUname = new TextEditingController();
    countryCode.text = "+ 91";
    Rx<bool> passwordScreen = false.obs;
    var size = MediaQuery.of(context).size;

    return SafeArea(
      child: WillPopScope(
        onWillPop: () async {
          if (passwordScreen.value == true) {
            passwordScreen.value = false;
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
            title: Text("Login", style: appBarTital),
          ),
          body: Obx(
            (() => Stack(
                  children: [
                    const UserName(),
                    AnimatedPositioned(
                      left: passwordScreen.value == true ? 0 : size.width + 20,
                      top: 0,
                      duration: const Duration(milliseconds: 500),
                      curve: Curves.easeIn,
                      child: PasswordScreen(screenWidght: size.width),
                    ),
                    NextButton(
                        enable: false,
                        labelText: passwordScreen.value ? "Login" : "Next",
                        onPress: () {
                          passwordScreen.value = !passwordScreen.value;
                        })
                  ],
                )),
          ),
        ),
      ),
    );
  }
}
