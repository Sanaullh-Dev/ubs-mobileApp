import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:ubs/pages/Chats/chats_dashboard.dart';
import 'package:ubs/pages/dashboard/dashboard.dart';
import 'package:ubs/pages/home/home_page.dart';
import 'package:ubs/pages/location/state_page.dart';
import 'package:ubs/pages/login/controller/login_controller.dart';
import 'package:ubs/pages/login/signup_page.dart';
import 'package:ubs/pages/main_controller.dart';
import 'package:ubs/pages/selling/sale_main_categories.dart';
import 'package:ubs/utils/constants.dart';
import 'package:get/get.dart';

class MainPage extends StatelessWidget {
  MainPage({super.key});

  final LoginController loginController = Get.put(LoginController());
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
            return const SingUp();
          }
        },
      ),
    );
  }
}
