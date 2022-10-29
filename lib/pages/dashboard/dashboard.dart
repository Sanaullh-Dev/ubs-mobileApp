import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:ubs/model/user_login.dart';
import 'package:ubs/pages/Chats/chats_dashboard.dart';
import 'package:ubs/pages/accounts/account_page.dart';
import 'package:ubs/pages/home/home_page.dart';
import 'package:ubs/pages/my_ads/my_ads.dart';
import 'package:ubs/pages/selling/sale_main_categories.dart';
import 'package:ubs/utils/constants.dart';
import 'package:get/get.dart';

class DashboardPage extends StatefulWidget {
  final UserLogin userData;
  const DashboardPage({super.key, required this.userData});

  @override
  State<DashboardPage> createState() => _DashboardPageState();
}

class _DashboardPageState extends State<DashboardPage> {
  // final MainController mainCont = Get.put(MainController());
  RxInt selectPage = 0.obs;

  @override
  void initState() {
    super.initState();
  }

  //  final mainCont = Get.find<MainController>();
  @override
  Widget build(BuildContext context) {
    final pageOptions = [
      HomePage(userData: widget.userData),
      const ChatsDashboard(),
      HomePage(userData: widget.userData),
      MyAds(userData: widget.userData),
      const AccountPage(),
      // const SaleMainCategories()
    ];

    return Scaffold(
        body: Obx(() => pageOptions[selectPage.value]),
        bottomNavigationBar: Obx(
          () => BottomNavigationBar(
            selectedLabelStyle:
                TextStyle(fontSize: 22.sp, fontWeight: FontWeight.w400),
            unselectedLabelStyle:
                TextStyle(fontSize: 22.sp, fontWeight: FontWeight.w400),
            backgroundColor: COLOR_WHITE,
            fixedColor: COLOR_PRIMARY,
            type: BottomNavigationBarType.fixed,
            currentIndex: selectPage.value,
            onTap: (index) => selectPage.value = index,
            items: [
              BottomNavigationBarItem(
                  icon: Icon(Icons.home_filled, size: 80.sp), label: "Home"),
              BottomNavigationBarItem(
                  icon: Icon(Icons.chat_rounded, size: 80.sp), label: "Chats"),
              BottomNavigationBarItem(
                  icon: Icon(null, size: 60.w), label: "Sell"),
              BottomNavigationBarItem(
                  icon: Icon(Icons.favorite_border, size: 80.sp),
                  label: "My Ads"),
              BottomNavigationBarItem(
                  icon: Icon(Icons.manage_accounts, size: 80.sp),
                  label: "Account")
            ],
          ),
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
        floatingActionButton: SizedBox(
          height: 110.sp,
          width: 110.sp,
          child: FittedBox(
            child: FloatingActionButton(
              elevation: 0,
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) =>
                        SaleMainCategories(userData: widget.userData),
                  ),
                );
              },
              child: Container(
                decoration: BoxDecoration(
                  border: Border.all(color: COLOR_PRIMARY, width: 8.sp),
                  color: Colors.white,
                  shape: BoxShape.circle,
                ),
                child: IconButton(
                  color: Colors.black87,
                  icon: const Icon(Icons.add_outlined),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) =>
                            SaleMainCategories(userData: widget.userData),
                      ),
                    );
                  },
                ),
              ),
            ),
          ),
        ));
  }
}
