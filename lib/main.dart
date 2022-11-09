import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get_navigation/get_navigation.dart';
import 'package:ubs/main_binding.dart';
import 'package:ubs/model/user_login.dart';
import 'package:ubs/pages/chats/chat_individual/charts_individual.dart';
import 'package:ubs/pages/chats/chats_dashboard.dart';
import 'package:ubs/pages/selling/sale_main_categories.dart';
import 'package:ubs/utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:ubs/pages/main_page.dart';

Future main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  MainBinding().dependencies();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(900, 1600),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (context, child) {
        return GetMaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'B|S',
          theme: ThemeData(
            primarySwatch: MaterialColor(0xFFFFBB00, primarySwatchColor),
            textButtonTheme: TextButtonThemeData(
              style: TextButton.styleFrom(
                textStyle: const TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                    fontWeight: FontWeight.w600),
                backgroundColor: const Color(0xFF263238),
                padding: const EdgeInsets.symmetric(vertical: 10),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(4),
                ),
              ),
            ),
          ),
          // theme: getThemeData(screenWidth),
          initialRoute: '/',
          // initialBinding: MainBinding(),
          routes: {
            '/': (context) => MainPage(),
            '/home': (context) => MainPage(),
            '/chat': (context) => const ChatsDashboard(),
            '/chatDetails': (context) => const ChatIndividual(),
            '/SaleMainCategories': (context) => SaleMainCategories(
                userData: UserLogin(userId: "", upass: "")),
          },
        );
      },
      child: MainPage(),
    );
  }
}
