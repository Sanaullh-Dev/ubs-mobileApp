import 'package:badges/badges.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ubs/pages/accounts/controller/account_controller.dart';
import 'package:ubs/pages/accounts/logged_account/widget/bottom_option.dart';
import 'package:ubs/pages/accounts/logged_account/widget/profile_image.dart';
import 'package:ubs/sharing_widget/widget_fun.dart';
import 'package:ubs/utils/constants.dart';
import 'package:ubs/utils/text_style.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AccountDetails extends StatefulWidget {
  final String userId;
  const AccountDetails({super.key, required this.userId});

  @override
  State<AccountDetails> createState() => _AccountDetailsState();
}

class _AccountDetailsState extends State<AccountDetails> {
  final AccountController accountController = Get.find<AccountController>();
  // final LoginController loginCont = Get.find<LoginController>();
  // final user = FirebaseAuth.instance.currentUser!;

  // TextEditingController nameCont =
  //     TextEditingController(text: "Sanaulla Shaikh111");
  // TextEditingController aboutCont =
  //     TextEditingController(text: "I am sanaulla shaikh");
  // TextEditingController mobileCont = TextEditingController(text: "98888888");
  // TextEditingController emailCont =
  //     TextEditingController(text: "sanaulla@gmail.com");

  @override
  void initState() {
    super.initState();
    // accountController.fetchUserData(widget.userId);
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
            appBar: AppBar(
              toolbarHeight: 100.h,
              leading: IconButton(
                  icon: Icon(Icons.close, size: 60.sp),
                  onPressed: () {
                    Get.back();
                    accountController.fetchUserData(widget.userId);
                  }),
              actions: [
                InkWell(
                  onTap: () {
                    accountController
                        .updateUserData()
                        .then((value) => Get.back());
                  },
                  child: Padding(
                      padding: EdgeInsets.symmetric(
                          horizontal: 30.w, vertical: 30.w),
                      child: Text("Save", style: heading5)),
                ),
                addHorizontalSpace(20.w)
              ],
            ),
            body: Obx(
              // userData
              () => accountController.loading.value == true
                  ? const Center(child: CircularProgressIndicator())
                  : SingleChildScrollView(
                      child: Padding(
                        padding: EdgeInsets.symmetric(horizontal: 50.w),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            addVerticalSpace(50.h),
                            Text("Basic Information", style: heading2),
                            addVerticalSpace(30.h),
                            Row(
                              mainAxisSize: MainAxisSize.max,
                              children: [
                                InkWell(
                                  onTap: () =>
                                      bottomOption(context, accountController),
                                  child: Badge(
                                      badgeContent: Container(
                                        margin: EdgeInsets.symmetric(
                                            horizontal: 10.sp, vertical: 20.sp),
                                        child: Icon(
                                          Icons.edit_outlined,
                                          size: 50.sp,
                                        ),
                                      ),
                                      badgeColor: COLOR_PRIMARY,
                                      position: BadgePosition.bottomEnd(),
                                      child: GetProfileImage(imgSize: 200)),
                                ),
                                addHorizontalSpace(50.w),
                                Expanded(
                                  child: textBox(
                                      onChange: (val) => accountController
                                          .userData.value.uName = val,
                                      isEnable: true,
                                      hintText: "Sanaulla Shaikh",
                                      labelName: "Your Name",
                                      textController: TextEditingController(
                                          text: accountController
                                              .userData.value.uName)),
                                )
                              ],
                            ),
                            addVerticalSpace(50.h),
                            textBox(
                                onChange: (val) => accountController
                                    .userData.value.uAbout = val,
                                isEnable: true,
                                hintText: "I like this etc..",
                                labelName: "Tell something about you",
                                textController: TextEditingController(
                                    text: accountController
                                        .userData.value.uAbout)),
                            addVerticalSpace(80.h),
                            Text(
                              "Contact information",
                              style: heading2,
                            ),
                            addVerticalSpace(30.h),
                            Row(
                              children: [
                                SizedBox(
                                  width: 70,
                                  child: textBox(
                                      onChange: (val) {},
                                      isEnable: false,
                                      labelName: "Country",
                                      hintText: "+ 91",
                                      textController:
                                          TextEditingController(text: "+ 91 ")),
                                ),
                                addHorizontalSpace(50.w),
                                Expanded(
                                  child: textBox(
                                      onChange: (val) => accountController
                                          .userData.value.uPhone = val,
                                      isEnable: accountController
                                                  .userData.value.loginWith ==
                                              "phone"
                                          ? false
                                          : true,
                                      hintText: "988888888",
                                      labelName: "Phone Number",
                                      textController: TextEditingController(
                                          text: accountController
                                              .userData.value.uPhone)),
                                ),
                              ],
                            ),
                            addVerticalSpace(22.h),
                            Text("Yay! Your number is verified",
                                style: messageLabel),
                            addVerticalSpace(30.h),
                            textBox(
                                onChange: (val) => accountController
                                    .userData.value.uEmail = val,
                                isEnable: accountController
                                            .userData.value.loginWith ==
                                        "phone"
                                    ? true
                                    : false,
                                hintText: "Ex. yourname@gmail.com",
                                labelName: "Email",
                                textController: TextEditingController(
                                    text: accountController
                                        .userData.value.uEmail)),
                            addVerticalSpace(22.h),
                            Text(
                                "You have verified your email. It's important to allow us to securely communicate with you.",
                                style: messageLabel),
                          ],
                        ),
                      ),
                    ),
            )));
  }

  Widget textBox({
    required String labelName,
    required String hintText,
    required TextEditingController textController,
    required bool isEnable,
    required Function(String) onChange,
  }) {
    return TextFormField(
      enabled: isEnable,
      controller: textController,
      style: textfield,
      keyboardType: TextInputType.number,
      onChanged: onChange,
      // maxLength: 10,
      decoration: InputDecoration(
          contentPadding: EdgeInsets.fromLTRB(0, 15.sp, 0, 5.sp),
          counterText: "",
          label: Text(labelName, style: titleLabel),
          hintText: hintText,
          hintStyle: heading5,
          filled: !isEnable,
          fillColor: Colors.grey[300]),
    );
  }
}
