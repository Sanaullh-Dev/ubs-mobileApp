import 'dart:ui';
import 'package:ubs/pages/Categories/main_categories.dart';
import 'package:ubs/pages/Chats/chat_individual/charts_individual.dart';
import 'package:ubs/pages/Chats/chats_dashboard.dart';
import 'package:ubs/pages/selling/sale_main_categories.dart';
import 'package:ubs/utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:ubs/pages/MainPage.dart';
import 'package:ubs/utils/demo.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    double screenWidth = window.physicalSize.width;

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'b|s',
      theme: getThemeData(screenWidth),
      initialRoute: '/',
      routes: {
        '/': (context) => const MainPage(),
        '/chat' : (context) => const ChatsDashboard(),
        '/chatdetails' : (context) => const ChatIndividual(),
        '/demo' : (context) => const demoWidget(),
        '/SaleMainCategores' : (context) => const SaleMainCategories(),
      },
    );
  }
}


