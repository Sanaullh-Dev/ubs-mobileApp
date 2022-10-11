import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:ubs/model/ads_post.dart';
import 'package:ubs/pages/searchAds/controller/search_controller.dart';
import 'package:ubs/pages/searchAds/search_ads.dart';
import 'package:ubs/pages/home/PostList/widget/adsTile.dart';
import 'package:ubs/pages/home/controller/home_controller.dart';
import 'package:ubs/sharing_widget/widget_fun.dart';
import 'package:ubs/utils/constants.dart';
import 'package:ubs/utils/text_style.dart';

class PostList extends StatelessWidget {
  PostList({super.key});

  final HomeController homeController = Get.find<HomeController>();
  final SearchController searchController = Get.find<SearchController>();

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final TextTheme textTheme = Theme.of(context).textTheme;

    if (homeController.typeList.value == "catList") {
      homeController.fetchCatWiseAds(homeController.mainCat.value);
    }
    // else if (homeController.typeList.value == "keywordList") {
    //   homeController.catWiseAdsList.value =
    //       searchController.keywordWiseAdsList.value;
    // }

    return SafeArea(
      child: WillPopScope(
        onWillPop: () async {
          homeController.typeList.value = "all";
          return false;
        },
        child: Scaffold(
          appBar: PreferredSize(
            preferredSize: const Size.fromHeight(120),
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 8),
              child: Row(
                children: [
                  Container(
                    width: size.width * 0.75,
                    padding: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8),
                        border: Border.all(color: COLOR_GREY, width: 3)),
                    child: Row(
                      children: [
                        IconButton(
                          padding: EdgeInsets.zero,
                          constraints: const BoxConstraints(),
                          onPressed: () {
                            homeController.typeList.value = "all";
                          },
                          icon: Icon(
                            Icons.arrow_back,
                            size: 40.sp,
                            color: Colors.black,
                          ),
                        ),
                        addHorizontalSpace(8),
                        Expanded(
                          child: GestureDetector(
                            onTap: () {
                              Get.to(SearchAds());
                            },
                            child: Text(
                                "${homeController.hintText} Ads in your current location",
                                overflow: TextOverflow.ellipsis,
                                softWrap: false,
                                maxLines: 1,
                                style: textfield),
                          ),
                        ),
                      ],
                    ),
                  ),
                  GestureDetector(
                    onTap: () {},
                    child: SizedBox(
                        width: size.width * 0.1,
                        child: Icon(
                          FontAwesomeIcons.locationDot,
                          size: 45.sp,
                          color: Colors.black87,
                        )),
                  ),
                  GestureDetector(
                    onTap: () {},
                    child: SizedBox(
                        width: size.width * 0.1,
                        child: Icon(
                          FontAwesomeIcons.arrowDownWideShort,
                          size: 45.sp,
                          // color: Colors.black87,
                        )),
                  )
                ],
              ),
            ),
          ),
          body: Obx(
            () {
              if (homeController.typeList.value == "catList") {
                return homeController.listStatus.value == true
                    ? const Center(child: CircularProgressIndicator())
                    : homeController.catWiseAdsList.isEmpty
                        ? notFoundImage(size)
                        : SingleChildScrollView(
                            child: Column(
                              children: [
                                Padding(
                                  padding: EdgeInsets.symmetric(
                                      vertical: 15.sp, horizontal: 30.sp),
                                  child: totalAdsBar(),
                                ),
                                getList(homeController.catWiseAdsList),
                              ],
                            ),
                          );
              } else if (homeController.typeList.value == "keywordList") {
                return homeController.catWiseAdsList.isEmpty
                    ? notFoundImage(size)
                    : SingleChildScrollView(
                        child: Column(
                          children: [
                            Padding(
                              padding: EdgeInsets.symmetric(
                                  vertical: 15.sp, horizontal: 30.sp),
                              child: totalAdsWithSearch(),
                            ),
                            getList(homeController.catWiseAdsList),
                          ],
                        ),
                      );
              } else {
                return notFoundImage(size);
              }
            },
          ),
        ),
      ),
    );
  }

  Widget notFoundImage(Size size) {
    return SizedBox(
      width: size.width,
      height: size.height - 120,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(
            width: size.width * 0.4,
            height: size.width * 0.4,
            child: Image.asset("lib/assets/images/404.png"),
          ),
          SizedBox(
            height: 15.h,
          ),
          Text("Ads Not Found", style: heading3)
        ],
      ),
    );
  }

  Widget totalAdsBar() {
    return Row(mainAxisAlignment: MainAxisAlignment.center, children: [
      Text(
        homeController.catWiseAdsList.length.toString(),
        style: TextStyle(
            color: Colors.black, fontSize: 35.sp, fontWeight: FontWeight.w600),
      ),
      Text(
        " Ads founds",
        style: TextStyle(color: Colors.black, fontSize: 35.sp),
      )
    ]);
  }

  Widget totalAdsWithSearch() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        SizedBox(
            width: 600.w,
            child: Text(
              'Showing result for "${searchController.searchWord.value}"',
              style: titleLabel,
              overflow: TextOverflow.ellipsis,
              softWrap: false,
              maxLines: 1,
            )),
        Container(
          padding: EdgeInsets.symmetric(vertical: 10.sp, horizontal: 30.sp),
          decoration: BoxDecoration(
              color: Colors.cyan[200],
              // border: Border.all(width: 3, color: COLOR_WHITE),
              borderRadius: BorderRadius.circular(20.r)),
          child: Text("${homeController.catWiseAdsList.length} ads",
              style: TextStyle(
                color: COLOR_BLACK,
                fontWeight: FontWeight.w400,
                fontSize: 23.sp,
                letterSpacing: 0.8,
              )),
        )
      ],
    );
  }

  Widget getList(List<AdsPost> adsList) {
    return ListView.builder(
      primary: false,
      shrinkWrap: true,
      itemCount: adsList.length,
      itemBuilder: (BuildContext context, int index) {
        return AdsTitle(
          adsData: adsList[index],
        );
      },
    );
  }
}
