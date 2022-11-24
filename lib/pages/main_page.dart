import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:ubs/model/user_login.dart';
import 'package:ubs/pages/dashboard/dashboard.dart';
import 'package:get/get.dart';
import 'package:ubs/pages/login/login_home.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:ubs/services/remote_services.dart';
import 'package:ubs/services/secure_storage.dart';

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  // final LoginController loginController = Get.put(LoginController());
  // final MainController mainCont = Get.put(MainController());
  Rx<String> uid = "".obs;
  Rx<String> loginStatus = "checking".obs;
  Rx<UserLogin> uData = UserLogin(userId: "", upass: "").obs;

  @override
  void initState() {
    super.initState();
    getLoginData();
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
        uData.value = UserLogin(userId: userId, upass: uPass ?? "");
        loginStatus.value = "logged";
      }
    }
  }

  //  final mainCont = Get.find<MainController>();
  @override
  Widget build(BuildContext context) {
    SystemChannels.textInput.invokeMethod('TextInput.hide');
    return SafeArea(
      child: Obx(
        () {
          if (loginStatus.value == "logged") {
            return DashboardPage(userData: uData.value, selectPage: 0);
          }
          if (loginStatus.value == "checking") {
            return Scaffold(
              body: Center(
                child: SizedBox(
                    height: 300.sp,
                    width: 300.sp,
                    child: Image.asset("lib/assets/images/BiS.png")),
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
