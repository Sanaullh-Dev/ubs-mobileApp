import 'dart:async';

import 'package:flutter/material.dart';
import 'package:ubs/model/user_login.dart';
import 'package:ubs/pages/dashboard/dashboard.dart';
import 'package:get/get.dart';
import 'package:ubs/pages/login/login_home.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:ubs/services/remote_services.dart';
import 'package:ubs/services/secure_storage.dart';
import 'package:ubs/utils/constants.dart';
import 'package:ubs/utils/text_style.dart';

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  Rx<String> uid = "".obs;
  Rx<String> loginStatus = "checking".obs;
  Rx<UserLogin> uData = UserLogin(userId: "", uPass: "").obs;
  Rx<String> loadingLabel = "...".obs;
  Timer? countdownTimer;

  @override
  void initState() {
    super.initState();
    getLoginData();
    startTimer();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    countdownTimer!.cancel();
  }

  void startTimer() {
    countdownTimer = Timer.periodic(const Duration(seconds: 1), (_) {
      if (loadingLabel.value.length == 3) {
        loadingLabel.value = "";
      } else if (loadingLabel.value.length == 2) {
        loadingLabel.value = "...";
      } else if (loadingLabel.value.length == 1) {
        loadingLabel.value = "..";
      } else if (loadingLabel.value.isEmpty) {
        loadingLabel.value = ".";
      }
    });
  }

  void getLoginData() async {
    final StorageService storageService = StorageService();
    var userId = await storageService.readSecureData("LoginId");
    var uPass = await storageService.readSecureData("LoginPass");
    if (userId == null) {
      loginStatus.value = "no";
    } else {
      var res = await RemoteServices.userLogin(userId, uPass ?? "");
      if (res == "logged") {
        uData.value = UserLogin(userId: userId, uPass: uPass ?? "");
        loginStatus.value = "logged";
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    // SystemChannels.textInput.invokeMethod('TextInput.hide');
    final Size size = MediaQuery.of(context).size;
    return SafeArea(
      child: Obx(
        () {
          if (loginStatus.value == "logged") {
            return DashboardPage(userData: uData.value, selectPage: 0);
          }
          if (loginStatus.value == "checking") {
            return Scaffold(
              backgroundColor: Colors.white,
              body: Center(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SizedBox(
                        height: 250.sp,
                        width: 250.sp,
                        child: Image.asset("lib/assets/images/BiS.png")),
                    SizedBox(height: 50.sp),
                    Container(
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.black,width: 2)
                      ),
                      width: size.width * 0.6,
                      child: LinearProgressIndicator(
                        color: primaryColor,
                        backgroundColor: Colors.grey[300],
                        minHeight: 40.sp,                        
                      ),
                    ),
                    SizedBox(height: 50.sp),
                    SizedBox(
                        width: 205.sp,
                        child: Text("Loading${loadingLabel.value}",
                            style: heading2))
                  ],
                ),
              ),
            );
          } else {
            return const LoginHome();
          }
        },
      ),
    );
  }
}
