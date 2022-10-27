import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:ubs/pages/Chats/chats_dashboard.dart';
import 'package:ubs/pages/accounts/account_page.dart';
import 'package:ubs/pages/home/home_page.dart';
import 'package:ubs/pages/main_controller.dart';
import 'package:ubs/pages/my_ads/my_ads.dart';
import 'package:ubs/pages/selling/sale_main_categories.dart';
import 'package:ubs/utils/constants.dart';
import 'package:get/get.dart';

class DashboardPage extends StatefulWidget {
  DashboardPage({super.key});

  @override
  State<DashboardPage> createState() => _DashboardPageState();
}

class _DashboardPageState extends State<DashboardPage> {
  final MainController mainCont = Get.put(MainController());

  @override
  void initState() {
    super.initState();
  }

  //  final mainCont = Get.find<MainController>();
  @override
  Widget build(BuildContext context) {
    final pageOptions = [
      const HomePage(),
      const ChatsDashboard(),
      const HomePage(),
      const MyAds(),
      const AccountPage(),
      // const SaleMainCategories()
    ];

    return Scaffold(
        body: Obx(() => pageOptions[mainCont.selectPage.value]),
        bottomNavigationBar: Obx(
          () => BottomNavigationBar(
            selectedLabelStyle:
                TextStyle(fontSize: 22.sp, fontWeight: FontWeight.w400),
            unselectedLabelStyle:
                TextStyle(fontSize: 22.sp, fontWeight: FontWeight.w400),
            backgroundColor: COLOR_WHITE,
            fixedColor: COLOR_PRIMARY,
            type: BottomNavigationBarType.fixed,
            currentIndex: mainCont.selectPage.value,
            onTap: (index) => mainCont.selectPage.value = index,
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
          height: 110.w,
          width: 110.w,
          child: FittedBox(
            child: FloatingActionButton(
              elevation: 0,
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const SaleMainCategories(),
                  ),
                );
              },
              child: Container(
                decoration: BoxDecoration(
                  border: Border.all(color: COLOR_PRIMARY, width: 12.sp),
                  color: Colors.white,
                  shape: BoxShape.circle,
                ),
                child: IconButton(
                  color: Colors.black87,
                  iconSize: 50.sp,
                  icon: const Icon(Icons.add_outlined),
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const SaleMainCategories()));
                  },
                ),
              ),
            ),
          ),
        ));
  }
}
