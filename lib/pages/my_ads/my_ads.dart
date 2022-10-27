import 'package:flutter/material.dart';
import 'package:ubs/pages/my_ads/my_ads/my_adsList.dart';
import 'package:ubs/utils/constants.dart';
import 'package:ubs/utils/text_style.dart';

class MyAds extends StatefulWidget {
  const MyAds({super.key});

  @override
  State<MyAds> createState() => _MyAdsState();
}

class _MyAdsState extends State<MyAds> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: DefaultTabController(
        length: 2,
        child: Scaffold(
          body: NestedScrollView(
            floatHeaderSlivers: true,
            headerSliverBuilder: (context, _) {
              return [
                SliverAppBar(
                  title: Container(
                    width: MediaQuery.of(context).size.width,
                    padding: const EdgeInsets.symmetric(vertical: 8),
                    child: Text("My Ads", style: heading2),
                  ),
                ),
                SliverAppBar(
                  automaticallyImplyLeading: false,
                  pinned: true,
                  title: Container(
                    width: MediaQuery.of(context).size.width,
                    padding: EdgeInsets.zero,
                    margin: EdgeInsets.zero,
                    height: 58,
                    child: TabBar(
                        indicatorWeight: 6,
                        indicatorColor: COLOR_BLACK,
                        labelColor: COLOR_BLACK,
                        labelStyle: heading4,
                        labelPadding: EdgeInsets.only(bottom: 8, top: 8),
                        tabs: const [
                          Tab(text: 'ADS'),
                          Tab(text: 'FAVORITES'),
                        ]),
                  ),
                )
              ];
            },
            body: const TabBarView(children: [
              MyAdsList(),
              MyAdsList(),
            ]),
          ),
        ),
      ),
    );
  }
}
