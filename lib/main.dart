import 'dart:ui';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get_navigation/get_navigation.dart';
import 'package:ubs/main_binding.dart';
import 'package:ubs/pages/Chats/chat_individual/charts_individual.dart';
import 'package:ubs/pages/Chats/chats_dashboard.dart';
import 'package:ubs/pages/selling/sale_main_categories.dart';
import 'package:ubs/utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:ubs/pages/main_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    double screenWidth = window.physicalSize.width;

    return ScreenUtilInit(
      designSize: const Size(900, 1600),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (context, child) {
        return GetMaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'b|s',
          theme: getThemeData(screenWidth),
          initialRoute: '/',
          initialBinding: MainBinding(),
          routes: {
            '/': (context) => MainPage(),
            '/chat': (context) => const ChatsDashboard(),
            '/chatdetails': (context) => const ChatIndividual(),
            '/SaleMainCategores': (context) => const SaleMainCategories(),
          },
        );
      },
      child: MainPage(),
    );
  }
}
