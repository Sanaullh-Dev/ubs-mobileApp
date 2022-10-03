import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:ubs/pages/home/PostList/widget/adsTile.dart';
import 'package:ubs/pages/home/controller/home_controller.dart';
import 'package:ubs/sharing_widget/widget_fun.dart';
import 'package:ubs/utils/constants.dart';
import 'package:ubs/utils/text_style.dart';

class PostList extends StatelessWidget {
  PostList({super.key});

  final HomeController homeController = Get.put(HomeController());

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final TextTheme textTheme = Theme.of(context).textTheme;
    homeController.fetchCatWiseAds(homeController.mainCat.value);

    return SafeArea(
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
                          homeController.allAds.value = true;
                        },
                        icon: Icon(
                          Icons.arrow_back,
                          size: 40.sp,
                          color: Colors.black,
                        ),
                      ),
                      addHorizontalSpace(8),
                      Expanded(
                        child: Text("Category Name with address",
                            overflow: TextOverflow.ellipsis,
                            softWrap: false,
                            maxLines: 1,
                            style: textTheme.titleLarge),
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
          () => homeController.listStatus.value == true
              ? const Center(child: CircularProgressIndicator())
              : homeController.catWiseAdsList.isEmpty
                  ? SizedBox(
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
                    )
                  : SingleChildScrollView(
                      child: Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.symmetric(vertical: 15),
                            child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    homeController.catWiseAdsList.length
                                        .toString(),
                                    style: TextStyle(
                                        color: Colors.black,
                                        fontSize: 35.sp,
                                        fontWeight: FontWeight.w600),
                                  ),
                                  Text(
                                    " Ads founds",
                                    style: TextStyle(
                                        color: Colors.black, fontSize: 35.sp),
                                  )
                                ]),
                          ),
                          ListView.builder(
                            primary: false,
                            shrinkWrap: true,
                            itemCount: homeController.catWiseAdsList.length,
                            itemBuilder: (BuildContext context, int index) {
                              return AdsTitle(
                                textTheme: textTheme,
                                wSize: size.width,
                                adsData: homeController.catWiseAdsList[index],
                              );
                            },
                          ),
                        ],
                      ),
                    ),
        ),
      ),
    );
  }
}
