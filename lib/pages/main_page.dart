import 'package:flutter/material.dart';
import 'package:ubs/pages/dashboard/dashboard.dart';
import 'package:ubs/pages/login/controller/login_controller.dart';
import 'package:ubs/pages/login/login_home.dart';
import 'package:get/get.dart';
import 'package:ubs/pages/login/otp_verify.dart';

class MainPage extends StatelessWidget {
  MainPage({super.key});

  final design loginController = Get.put(design());
  //  final mainCont = Get.find<MainController>();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Obx(
        () {
          if (loginController.loginStatus.value == "waiting") {
            return const Center(child: CircularProgressIndicator());
          } else if (loginController.loginStatus.value == "login") {
            return DashboardPage();
          } else {
            // return const LoginHome();
            return const OtpVerify();
          }
        },
      ),
    );
  }
}



