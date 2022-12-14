import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:ubs/model/user_login.dart';
import 'package:ubs/pages/post_details/controller/post_details_controller.dart';
import 'package:ubs/pages/home/controller/home_controller.dart';
import 'package:ubs/utils/constants.dart';
import 'package:ubs/sharing_widget/widget_fun.dart';
import 'package:ubs/utils/custom_fun.dart';
import 'package:ubs/utils/text_style.dart';

const double iconsSize = 40;

class RelatedAds extends StatelessWidget {
  final int mCateId;
  final int showingPostId;
  final UserLogin usersData;
  final ScrollController scrolledCont;
  const RelatedAds(
      {super.key,
      required this.mCateId,
      required this.showingPostId,
      required this.usersData,
      required this.scrolledCont});

  @override
  Widget build(BuildContext context) {
    HomeController homeController = Get.find<HomeController>();
    homeController.fetchRelatedCatWiseAds(usersData.userId, mCateId);
    final PostDetailsController postDetController =
        Get.find<PostDetailsController>();

    return Container(
      color: whiteColor,
      // padding: EdgeInsets.symmetric(vertical: 8.w),
      height: 470.sp,
      child: Obx(
        () => homeController.relatedCatAdsList.value.isEmpty
            ? const Center(child: CircularProgressIndicator())
            : ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: homeController.relatedCatAdsList.value.length,
                itemBuilder: (BuildContext context, int index) {
                  var adsData = homeController.relatedCatAdsList.value[index];
                  return adsData.pId == showingPostId
                      ? const SizedBox()
                      : GestureDetector(
                          onTap: () async {
                            await postDetController.getAdsPostDetails(
                                usersData.userId, adsData.pId!);

                            scrolledCont.animateTo(
                              scrolledCont.position.minScrollExtent,
                              curve: Curves.easeOut,
                              duration: const Duration(seconds: 500),
                            );
                          },
                          child: Container(
                            decoration: BoxDecoration(
                              color: Colors.white,
                              border:
                                  Border.all(width: 1, color: mainBorderColor),
                              borderRadius: BorderRadius.circular(10.r),
                            ),
                            padding: EdgeInsets.all(15.w),
                            margin: const EdgeInsets.only(left: 12),
                            // color: categoriesList[index]["color"],
                            width: 380.sp,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Image.network(
                                  // postList[index].image1,
                                  getLink(adsData.pImg1),
                                  height: 250.sp,
                                  width: 390.sp,
                                  fit: BoxFit.cover,
                                  alignment: Alignment.center,
                                ),
                                addVerticalSpace(8.h),
                                Padding(
                                  padding:
                                      EdgeInsets.symmetric(horizontal: 10.w),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text('\$ ${adsData.pPrice}',
                                          style: heading3),
                                      // Icon(Icons.favorite_border)
                                      IconButton(
                                        padding: EdgeInsets.zero,
                                        constraints: const BoxConstraints(),
                                        color: adsData.pFavorite == 1
                                            ? Colors.red
                                            : Colors.black,
                                        onPressed: () {},
                                        icon: Icon(
                                          adsData.pFavorite == 1
                                              ? Icons.favorite
                                              : Icons.favorite_border,
                                          size: 50.sp,
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                                addVerticalSpace(2.h),
                                Text(
                                  homeController
                                      .relatedCatAdsList.value[index].pTitle,
                                  style: heading5,
                                  overflow: TextOverflow.ellipsis,
                                  maxLines: 1,
                                ),
                                addVerticalSpace(2.h),
                                Row(
                                  children: [
                                    Icon(
                                      Icons.location_on,
                                      size: 35.sp,
                                    ),
                                    SizedBox(width: 5.w),
                                    Text(
                                      homeController.relatedCatAdsList
                                          .value[index].pLocation,
                                      style: heading5,
                                      overflow: TextOverflow.ellipsis,
                                      maxLines: 1,
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        );
                },
              ),
      ),
    );
  }
}
