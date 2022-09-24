import 'package:flutter/material.dart';
import 'package:get/get.dart';
// import 'package:flutter_sticky_header/flutter_sticky_header.dart';
import 'package:ubs/model/post_model.dart';
import 'package:ubs/pages/home/PostList/post_list.dart';
import 'package:ubs/pages/home/controller/home_controller.dart';
import 'package:ubs/pages/home/widget/ads_list.dart';
import 'package:ubs/pages/home/widget/categories_bar.dart';
import 'package:ubs/pages/home/widget/location_bar.dart';
import 'package:ubs/pages/home/widget/search_bar.dart';
import 'package:ubs/sharing_widget/widget_fun.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  PostModel? selectedPost;
  // List<AdsPost> adsPosts = [];
  final HomeController homeController = Get.put(HomeController());

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    final TextTheme textTheme = Theme.of(context).textTheme;

    return SafeArea(
      child: Obx(
        () => homeController.allAds.value
            ? LatestPost(size: size, textTheme: textTheme)
            : PostList(),
      ),
    );
  }
}

class LatestPost extends StatelessWidget {
  final Size size;
  final TextTheme textTheme;
  LatestPost({super.key, required this.size, required this.textTheme});

  final HomeController homeController = Get.put(HomeController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: NestedScrollView(
        floatHeaderSlivers: true,
        headerSliverBuilder: (context, _) {
          return <Widget>[
            SliverAppBar(
              title: LocationBar(textTheme: textTheme),
              // titleSpacing: 5,
              toolbarHeight: 45,
              pinned: false,
              floating: true,
              // primary: false,
              centerTitle: false,
              // titleSpacing: NavigationToolbar.kMiddleSpacing,
              // automaticallyImplyLeading: false,
            ),
            SliverAppBar(
              pinned: true,
              primary: false,
              centerTitle: false,
              titleSpacing: 0,
              toolbarHeight: 60,
              automaticallyImplyLeading: false,
              forceElevated: true,
              title: Container(
                // color: Colors.red,
                // width: MediaQuery.of(context).size.width,
                child: SearchBar(width: size.width, textTheme: textTheme),
              ),
            )
          ];
        },
        body: SingleChildScrollView(
          child: Column(
            children: [
              GestureDetector(onTap: () {}, child: addVerticalSpace(10)),
              const CategoriesBar(),
              addVerticalSpace(10),
              Padding(
                padding: const EdgeInsets.only(left: 14),
                child: Text("Fresh recommendation", style: textTheme.headline4),
              ),
              const SizedBox(height: 15),
              Obx(() => homeController.adsPostList.value == null
                  ? const CircularProgressIndicator()
                  : AdsList(
                      adsPost: homeController.adsPostList,
                    )),
            ],
          ),
        ),
      ),
    );
  }
}
