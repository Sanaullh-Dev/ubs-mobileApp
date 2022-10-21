import 'package:flutter/material.dart';
import 'package:ubs/pages/dashboard/dashboard.dart';
import 'package:ubs/pages/login/autoVerifyOTP/auto_verify.dart';
import 'package:ubs/pages/login/controller/login_controller.dart';
import 'package:get/get.dart';
import 'package:ubs/pages/main_controller.dart';

class MainPage extends StatefulWidget {
  MainPage({super.key});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  final design loginController = Get.put(design());
  final MainController mainCont = Get.put(MainController());
  String uid = "";

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

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
            // return const OtpVerify();
            return const AutoVerify();
          }
        },
      ),
    );
  }
}
