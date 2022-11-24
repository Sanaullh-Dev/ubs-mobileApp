import 'package:flutter/material.dart';
import 'package:ubs/model/user_login.dart';
import 'package:ubs/pages/my_ads/favorites_list/favorites_list.dart';
import 'package:ubs/pages/my_ads/my_ads/my_ads_list.dart';
import 'package:ubs/utils/constants.dart';
import 'package:ubs/utils/text_style.dart';

class MyAds extends StatefulWidget {
  final UserLogin userData;
  const MyAds({super.key, required this.userData});

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
                  automaticallyImplyLeading: false,
                  // centerTitle: true,
                  title: Text("My Ads", style: heading2),
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
                        labelPadding: const EdgeInsets.only(bottom: 8, top: 8),
                        tabs: const [
                          Tab(text: 'ADS'),
                          Tab(text: 'FAVORITES'),
                        ]),
                  ),
                )
              ];
            },
            body: TabBarView(children: [
              MyAdsList(userLogin: widget.userData),
              FavoritesList(userLogin: widget.userData),
            ]),
          ),
        ),
      ),
    );
  }
}
