import 'dart:async';
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:ubs/model/user_login.dart';
import 'package:ubs/pages/accounts/home_account.dart';
import 'package:ubs/pages/accounts/logged_account/logged_home.dart';
import 'package:ubs/pages/chats/chats_dashboard/chats_dashboard.dart';
import 'package:ubs/pages/chats/controller/chats_controller.dart';
import 'package:ubs/pages/home/controller/home_controller.dart';
import 'package:ubs/pages/home/home_page.dart';
import 'package:ubs/pages/my_ads/my_ads.dart';
import 'package:ubs/pages/selling/sale_main_categories.dart';
import 'package:ubs/sharing_widget/widget_fun.dart';
import 'package:ubs/utils/constants.dart';
import 'package:get/get.dart';

class DashboardPage extends StatefulWidget {
  final UserLogin userData;
  final int selectPage;
  const DashboardPage(
      {super.key, required this.userData, required this.selectPage});

  @override
  State<DashboardPage> createState() => _DashboardPageState();
}

class _DashboardPageState extends State<DashboardPage> {
  // final MainController mainCont = Get.put(MainController());
  final HomeController homeController = Get.find<HomeController>();
  RxInt selectPage = 0.obs;

  @override
  void initState() {
    super.initState();
    selectPage.value = widget.selectPage;
  }

  //  final mainCont = Get.find<MainController>();
  @override
  Widget build(BuildContext context) {
    final ChatsController chatsController = Get.find<ChatsController>();
    StreamSubscription<QuerySnapshot>? eventStream;

    final pageOptions = [
      HomePage(userData: widget.userData, typeList: "all", mainCatId: 0),
      ChatsDashboard(userLogin: widget.userData),
      HomePage(userData: widget.userData, typeList: "all", mainCatId: 0),
      MyAds(userData: widget.userData),
      // const HomeAccount(),
      widget.userData.userId != ""
          ? LoggedHome(userLogin: widget.userData)
          : HomeAccount(userLogin: widget.userData)
    ];
    return WillPopScope(
      onWillPop: () async {
        if (homeController.typeList.value == "all" && selectPage.value == 0) {
          return exitPop(
              context: context,
              title: "Alert Message",
              message: "Do you want to exit from BIS",
              onCancel: () => Get.back(),
              onOK: () {
                chatsController.chatsRoomStreamClose();
                exit(0);
              });
        } else {
          homeController.typeList.value = "all";
          selectPage.value = 0;
          return false;
        }
      },
      child: Scaffold(
          body: Obx(() => pageOptions[selectPage.value]),
          bottomNavigationBar: Obx(
            () => BottomNavigationBar(
              selectedLabelStyle:
                  TextStyle(fontSize: 26.sp, fontWeight: FontWeight.w500),
              unselectedLabelStyle:
                  TextStyle(fontSize: 26.sp, fontWeight: FontWeight.w500),
              backgroundColor: whiteColor,
              fixedColor: primaryColor,
              type: BottomNavigationBarType.fixed,
              currentIndex: selectPage.value,
              onTap: (index) => selectPage.value = index,
              items: [
                BottomNavigationBarItem(
                    icon: Icon(Icons.home_outlined, size: 70.sp),
                    activeIcon: Icon(Icons.home, size: 70.sp),
                    label: "Home"),
                BottomNavigationBarItem(
                    icon: Icon(Icons.chat_bubble_outline, size: 60.sp),
                    activeIcon: Icon(Icons.chat_bubble, size: 60.sp),
                    label: "Chats"),
                BottomNavigationBarItem(
                    icon: Icon(null, size: 60.w), label: "Sell"),
                BottomNavigationBarItem(
                    icon: Icon(Icons.favorite_border, size: 60.sp),
                    activeIcon: Icon(
                      Icons.favorite,
                      size: 60.sp,
                    ),
                    label: "My Ads"),
                BottomNavigationBarItem(
                    icon: Icon(Icons.manage_accounts_outlined, size: 70.sp),
                    activeIcon: Icon(Icons.manage_accounts, size: 70.sp),
                    label: "Account")
              ],
            ),
          ),
          floatingActionButtonLocation:
              FloatingActionButtonLocation.centerDocked,
          floatingActionButton: SizedBox(
            height: 110.sp,
            width: 110.sp,
            child: FittedBox(
              child: FloatingActionButton(
                elevation: 0,
                onPressed: () {
                  Get.to(SaleMainCategories(userData: widget.userData));
                },
                child: Container(
                  decoration: BoxDecoration(
                    border: Border.all(color: primaryColor, width: 8.sp),
                    color: Colors.white,
                    shape: BoxShape.circle,
                  ),
                  child: IconButton(
                    color: Colors.black87,
                    icon: const Icon(Icons.add_outlined),
                    onPressed: () {
                      Get.to(SaleMainCategories(userData: widget.userData));
                    },
                  ),
                ),
              ),
            ),
          )),
    );
  }
}
