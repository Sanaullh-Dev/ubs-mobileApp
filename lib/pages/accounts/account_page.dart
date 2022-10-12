import 'dart:math';

import 'package:badges/badges.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ubs/pages/login/controller/login_controller.dart';
import 'package:ubs/sharing_widget/show_image.dart';
import 'package:ubs/sharing_widget/widget_fun.dart';
import 'package:ubs/utils/constants.dart';
import 'package:ubs/utils/text_style.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AccountPage extends StatefulWidget {
  const AccountPage({super.key});

  @override
  State<AccountPage> createState() => _AccountPageState();
}

class _AccountPageState extends State<AccountPage> {
  // final LoginController loginCont = Get.find<LoginController>();
  final user = FirebaseAuth.instance.currentUser!;

  TextEditingController nameCont =
      TextEditingController(text: "Sanaulla Shaikh111");
  TextEditingController aboutCont =
      TextEditingController(text: "I am sanaulla shaikh");
  TextEditingController mobileCont = TextEditingController(text: "98888888");
  TextEditingController emailCont =
      TextEditingController(text: "sanaulla@gmail.com");

  @override
  void initState() {
    // TODO: implement initState
    getUserData();
    super.initState();
  }

  getUserData(){
    nameCont.text = user.displayName!;
    emailCont.text = user.email != null ? user.email! : "";
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;

    return SafeArea(
        child: Scaffold(
      appBar: AppBar(
        toolbarHeight: 100.h,
        leading:
            IconButton(icon: Icon(Icons.close, size: 60.sp), onPressed: () {}),
        actions: [
          Padding(
              padding: EdgeInsets.symmetric(horizontal: 30.w, vertical: 30.w),
              child: Text("Save", style: heading5)),
          addHorizontalSpace(20.w)
        ],
      ),
      body: SingleChildScrollView(
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
                  SizedBox(
                    width: 200.sp,
                    height: 200.sp,
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
                      child: ClipOval(
                        child: user.photoURL == null 
                        ? Image.asset("lib/assets/images/user.png")
                        : ShowImage(imageUrl: user.photoURL!)                      
                      ),
                    ),
                  ),
                  addHorizontalSpace(50.w),
                  Expanded(
                    child: textBox(
                        hintText: "Sanaulla Shaikh",
                        labelName: "Your Name",
                        textController: nameCont),
                  )
                ],
              ),
              addVerticalSpace(50.h),
              textBox(
                  hintText: "I am sanaulla shaikh",
                  labelName: "Something about you",
                  textController: aboutCont),
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
                        labelName: "Country",
                        hintText: "+ 91",
                        textController: TextEditingController(text: "+ 91")),
                  ),
                  addHorizontalSpace(50.w),
                  Expanded(
                    child: textBox(
                        hintText: "988888888",
                        labelName: "Phone Number",
                        textController: mobileCont),
                  ),
                ],
              ),
              addVerticalSpace(22.h),
              Text("Yay! Your number is verified", style: messageLabel),
              addVerticalSpace(30.h),
              textBox(
                  hintText: "Ex. yourname@gmail.com",
                  labelName: "Email",
                  textController: emailCont),
              addVerticalSpace(22.h),
              Text(
                  "You have verified your email. It's important to allow us to securely communicate with you.",
                  style: messageLabel),
            ],
          ),
        ),
      ),
    ));
  }

  Widget textBox(
      {required String labelName,
      required String hintText,
      required TextEditingController textController}) {
    return TextFormField(
      controller: textController,
      style: textfield,
      keyboardType: TextInputType.number,
      maxLength: 10,
      decoration: InputDecoration(
        contentPadding: EdgeInsets.fromLTRB(0, 15.sp, 0, 5.sp),
        counterText: "",
        label: Text(labelName, style: titleLabel),
        hintText: hintText,
        hintStyle: heading5,
      ),
    );
  }
}
