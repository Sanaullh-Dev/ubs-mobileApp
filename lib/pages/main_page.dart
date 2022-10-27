import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:ubs/pages/dashboard/dashboard.dart';
import 'package:ubs/pages/login/Verify_otp/auto_verify.dart';
import 'package:ubs/pages/login/controller/login_controller.dart';
import 'package:get/get.dart';
import 'package:ubs/pages/login/login_home.dart';
import 'package:ubs/pages/main_controller.dart';

class MainPage extends StatefulWidget {
  MainPage({super.key});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  final logging loginController = Get.put(logging());
  final MainController mainCont = Get.put(MainController());
  String uid = "";

  @override
  void initState() {
    super.initState();    
  } 

  //  final mainCont = Get.find<MainController>();
  @override
  Widget build(BuildContext context) {
    SystemChannels.textInput.invokeMethod('TextInput.hide');
    return SafeArea(
      child: Obx(
        () {
          if (loginController.loginStatus.value == "logged") {
            return DashboardPage();
          }
          if (loginController.loginStatus.value == "waiting") {
            return const Center(child: CircularProgressIndicator());
          } else {
            // return PasswordScreen(newUser: true, userId: "84848484");
            return const LoginHome();
          }
        },
      ),
    );
  }
}
