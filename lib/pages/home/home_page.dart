import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:ubs/model/post_model.dart';
import 'package:ubs/model/user_login.dart';
import 'package:ubs/pages/home/PostList/post_list.dart';
import 'package:ubs/pages/home/controller/home_controller.dart';
import 'package:ubs/pages/home/widget/ads_list.dart';
import 'package:ubs/pages/home/widget/categories_bar.dart';
import 'package:ubs/pages/home/widget/location_bar.dart';
import 'package:ubs/pages/home/widget/search_bar.dart';
import 'package:ubs/sharing_widget/widget_fun.dart';
import 'package:ubs/utils/text_style.dart';

class HomePage extends StatefulWidget {
  final UserLogin userData;
  const HomePage({super.key, required this.userData});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  PostModel? selectedPost;
  // List<AdsPost> adsPosts = [];
  final HomeController homeController = Get.find<HomeController>();

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
        () => homeController.typeList.value == "all"
            ? LatestPost(
                size: size, textTheme: textTheme, userData: widget.userData)
            : PostList(userData: widget.userData),
      ),
    );
  }
}

class LatestPost extends StatefulWidget {
  final UserLogin userData;
  final Size size;
  final TextTheme textTheme;
  LatestPost(
      {super.key,
      required this.size,
      required this.textTheme,
      required this.userData});

  @override
  State<LatestPost> createState() => _LatestPostState();
}

class _LatestPostState extends State<LatestPost> {
  final homeController = Get.find<HomeController>();

  @override
  void initState() {
    super.initState();
    // loadAds();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: NestedScrollView(
            floatHeaderSlivers: true,
            headerSliverBuilder: (context, _) {
              return <Widget>[
                SliverAppBar(
                  title: const LocationBar(),
                  // titleSpacing: 5,
                  toolbarHeight: 80.h,
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
                  toolbarHeight: 110.h,
                  automaticallyImplyLeading: false,
                  forceElevated: true,
                  title: SearchBar(
                      width: widget.size.width, textTheme: widget.textTheme),
                )
              ];
            },
            body: RefreshIndicator(
                onRefresh: () async {
                  await homeController.fetchAds();
                },
                child: Obx(
                  (() => homeController.adsPostList.value.isEmpty ||
                          homeController.mainCatList.value.isEmpty
                      ? Center(
                          child: SizedBox(
                            height: 500.sp,
                            width: 200.sp,
                            child: Column(
                              children: [
                                Image.asset(
                                  "lib/assets/images/loading.png",
                                ),
                                addVerticalSpace(50.sp),
                                Text("Loading...", style: heading4)
                              ],
                            ),
                          ),
                        )
                      : SingleChildScrollView(
                          child: Column(
                            children: [
                              GestureDetector(
                                  onTap: () {}, child: addVerticalSpace(10)),
                              CategoriesBar(userData: widget.userData),
                              addVerticalSpace(10),
                              Padding(
                                padding: const EdgeInsets.only(left: 14),
                                child: Text("Fresh recommendation",
                                    style: heading4),
                              ),
                              SizedBox(height: 25.h),
                              AdsList(
                                userData: widget.userData,
                                adsPost: homeController.adsPostList,
                              ),
                            ],
                          ),
                        )),
                ))));
  }
}
