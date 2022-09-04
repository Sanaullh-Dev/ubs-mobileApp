// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:ubs/pages/Chats/chats_dashboard.dart';
import 'package:ubs/pages/home/home_page.dart';
import 'package:ubs/pages/location/state_page.dart';
import 'package:ubs/pages/selling/sale_main_categories.dart';
import 'package:ubs/utils/constants.dart';

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  int selectedPage = 0;

  @override
  Widget build(BuildContext context) {
    final pageOptions = [
      const HomePage(),
      const ChatsDashboard(),
      const HomePage(),
      const StateListPage(),
      // const SaleMainCategories()
    ];

    return SafeArea(
      child: Scaffold(
          body: pageOptions[selectedPage],
          bottomNavigationBar: BottomNavigationBar(
            selectedLabelStyle:
                const TextStyle(fontSize: 14, fontWeight: FontWeight.w400),
            unselectedLabelStyle:
                const TextStyle(fontSize: 14, fontWeight: FontWeight.w400),
            backgroundColor: COLOR_WHITE,
            selectedItemColor: COLOR_PRIMARY,
            unselectedItemColor: Colors.grey,
            type: BottomNavigationBarType.fixed,
            currentIndex: selectedPage,
            onTap: (index) {
              setState(() {
                // if(index == 2)
                selectedPage = index;
              });
            },
            items: const <BottomNavigationBarItem>[
              BottomNavigationBarItem(
                  icon: Icon(
                    Icons.home_filled,
                    size: 35,
                  ),
                  label: "Home"),
              BottomNavigationBarItem(
                  icon: Icon(
                    Icons.chat_rounded,
                    color: COLOR_BLACK,
                    size: 35,
                  ),
                  label: "Chats"),
              BottomNavigationBarItem(
                  icon: Icon(
                    null,
                    // Icons.favorite_border,
                    color: COLOR_WHITE,
                    size: 35,
                  ),
                  label: "Sell"),
              BottomNavigationBarItem(
                  icon: Icon(
                    Icons.favorite_border,
                    color: COLOR_BLACK,
                    size: 35,
                  ),
                  label: "My Ads"),
              BottomNavigationBarItem(
                  icon: Icon(
                    Icons.manage_accounts,
                    color: COLOR_BLACK,
                    size: 35,
                  ),
                  label: "Account"),
            ],
          ),
          floatingActionButtonLocation:
              FloatingActionButtonLocation.centerDocked,
          floatingActionButton: SizedBox(
            height: 60.0,
            width: 60.0,
            child: FittedBox(
              child: FloatingActionButton(
                elevation: 0,
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const SaleMainCategories()));
                },
                child: Container(
                  decoration: BoxDecoration(
                    border: Border.all(color: COLOR_PRIMARY, width: 6),
                    color: Colors.white,
                    shape: BoxShape.circle,
                  ),
                  child: IconButton(
                    color: Colors.black87,
                    iconSize: 27,
                    icon: const Icon(Icons.add_outlined),
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) =>
                                  const SaleMainCategories()));
                    },
                  ),
                ),
              ),
            ),
          )),
    );
  }
}
