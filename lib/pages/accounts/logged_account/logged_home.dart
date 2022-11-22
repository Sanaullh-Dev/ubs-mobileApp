import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:ubs/model/user_login.dart';
import 'package:ubs/pages/accounts/controller/account_controller.dart';
import 'package:ubs/pages/accounts/logged_account/account_details.dart';
import 'package:ubs/pages/accounts/logged_account/widget/profile_image.dart';
import 'package:ubs/pages/login/controller/login_controller.dart';
import 'package:ubs/pages/login/login_home.dart';
import 'package:ubs/utils/text_style.dart';

class LoggedHome extends StatefulWidget {
  final UserLogin userLogin;
  const LoggedHome({super.key, required this.userLogin});

  @override
  State<LoggedHome> createState() => _LoggedHomeState();
}

class _LoggedHomeState extends State<LoggedHome> {
  var design = "";
  final AccountController accountController = Get.find<AccountController>();
  final LoginController loginController = Get.find<LoginController>();

  @override
  void initState() {
    accountController.fetchUserData(widget.userLogin.userId);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // UsersData userDt = accountController.userData.value;
    return Scaffold(
        body: Obx(
      () => accountController.userData.value.logId == ""
          ? const Center(child: CircularProgressIndicator())
          : Padding(
              padding: EdgeInsets.symmetric(horizontal: 30.sp),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 50),
                  InkWell(
                    onTap: () => Get.to(AccountDetails(
                        userId: accountController.userData.value.logId)),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(vertical: 15),
                      child: Row(
                        children: [
                          GetProfileImage(imgSize: 180),
                          const SizedBox(width: 20),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Text(accountController.userData.value.uName,
                                    style: heading2InBold),
                                Text("View and edit profile",
                                    style: heading5.copyWith(
                                        fontWeight: FontWeight.w600,
                                        color: Colors.black,
                                        decoration: TextDecoration.underline))
                              ],
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                  // const Divider(thickness: 1, color: Colors.black54),
                  const SizedBox(height: 10),
                  ListTile(
                    leading: SizedBox(
                        width: 50,
                        height: 50,
                        child: Icon(
                          FontAwesomeIcons.gear,
                          size: 65.sp,
                          color: Colors.blueGrey,
                        )),
                    title: Text("Setting",
                        style: titleLabel.copyWith(color: Colors.black)),
                    subtitle: Text("Privacy and Logout", style: titleLabel),
                    trailing: trailingIcon(),
                  ),
                  const SizedBox(height: 10),
                  ListTile(
                      leading: SizedBox(
                          width: 50,
                          height: 50,
                          child: Image.asset("lib/assets/images/bis_icon.png")),
                      title: Text("Help & Support",
                          style: titleLabel.copyWith(color: Colors.black)),
                      subtitle: Text("Help center and legal terms",
                          style: titleLabel),
                      trailing: trailingIcon()),
                  const Divider(thickness: 2, height: 30),
                  ListTile(
                    leading: Icon(
                      FontAwesomeIcons.earthAsia,
                      size: 65.sp,
                      color: Colors.blueGrey,
                    ),
                    title: Text("Select Language",
                        style: titleLabel.copyWith(color: Colors.black)),
                    subtitle: Text("English", style: subtitleLabel),
                    trailing: trailingIcon(),
                  ),
                  const Divider(thickness: 2, height: 30),
                  const SizedBox(height: 20),
                  SizedBox(
                    width: double.infinity,
                    height: 50,
                    child: ElevatedButton(
                      child: Text("Log out",
                          style: buttonTextStyle.copyWith(color: Colors.black)),
                      onPressed: () {
                        loginController.logoutUser();
                        Get.offAll(const LoginHome());
                      },
                    ),
                  )
                ],
              ),
            ),
    ));
  }

  Icon trailingIcon() {
    return const Icon(Icons.arrow_forward_ios, color: Colors.black);
  }
}
