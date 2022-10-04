import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:ubs/model/ads_post.dart';
import 'package:ubs/pages/PostDetails/post_details_controller.dart';
import 'package:ubs/pages/PostDetails/widget/RelatedAds.dart';
import 'package:ubs/pages/PostDetails/widget/image_slider.dart';
import 'package:ubs/pages/PostDetails/widget/title_bar.dart';
import 'package:ubs/sharing_widget/widget_fun.dart';
import 'package:ubs/utils/constants.dart';
import 'package:ubs/utils/text_style.dart';

class PostDetails extends StatelessWidget {
  // final PostModel postData;
  final AdsPost adsPostData;
  const PostDetails({super.key, required this.adsPostData});

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    final TextTheme textTheme = Theme.of(context).textTheme;

    final PostDetailsController postDetController =
        Get.put(PostDetailsController());
    postDetController.addAdsPostData(adsPostData);

    return SafeArea(
      child: Scaffold(
        body: SizedBox(
          width: size.width,
          height: size.height,
          child: Obx(
            () => Stack(
              children: [
                SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Hero(
                        tag: "post${postDetController.adsPost.value.pId}",
                        child: ImageSlider(
                          imgList: getImage(postDetController.adsPost.value),
                        ),
                      ),
                      // Ads heading Section
                      TitleBar(adsPostData: postDetController.adsPost.value),
                      addVerticalSpace(10.h),
                      // Description section
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            vertical: 8, horizontal: 15),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Description",
                              style: heading3,
                            ),
                            addVerticalSpace(8),
                            Text(
                              postDetController.adsPost.value.pDescribe,
                              textAlign: TextAlign.start,
                              style: heading5,
                            )
                          ],
                        ),
                      ),
                      addDivider(),
                      // Title - Related Added
                      // Related Added
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            vertical: 8, horizontal: 15),
                        child: Text(
                          "Related Ads",
                          style: heading3,
                        ),
                      ),
                      RelatedAds(
                          mCateId: postDetController.adsPost.value.pMcat,
                          showingPostId: postDetController.adsPost.value.pId!)
                    ],
                  ),
                ),

                // Sticky App bar on top
                Positioned(
                    top: 0,
                    child: Container(
                      width: size.width,
                      padding: EdgeInsets.symmetric(horizontal: 20.w),
                      decoration: const BoxDecoration(
                        // color: COLOR_PRIMERY,
                        // border: Border(
                        //   bottom: BorderSide(width: 1, color: Colors.grey)
                        // ),
                        gradient: LinearGradient(
                            colors: [Colors.black87, Colors.transparent],
                            begin: Alignment.topCenter,
                            end: Alignment.bottomCenter),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          IconButton(
                            onPressed: () {
                              Navigator.pop(context);
                            },
                            icon: Icon(
                              Icons.arrow_back,
                              size: 60.sp,
                              color: Colors.white,
                            ),
                          ),
                          IconButton(
                            onPressed: () {},
                            icon: Icon(
                              Icons.share,
                              size: 60.sp,
                              color: Colors.white,
                            ),
                          ),
                        ],
                      ),
                    )),
              ],
            ),
          ),
        ),
        bottomNavigationBar: BottomAppBar(
          color: Colors.white,
          elevation: 50.h,
          child: Padding(
            padding: EdgeInsets.symmetric(vertical: 8.h, horizontal: 18.w),
            child: Row(
              children: [
                Expanded(
                  child: TextButton.icon(
                    onPressed: () {},
                    icon: Icon(
                      FontAwesomeIcons.comment,
                      size: 45.sp,
                      color: Colors.white,
                    ),
                    label: Text(
                      "Chart",
                      style: buttonTextStyle,
                    ),
                  ),
                ),
                addHorizontalSpace(8),
                Expanded(
                  child: TextButton.icon(
                    onPressed: () {},
                    icon: Icon(
                      FontAwesomeIcons.phone,
                      size: 45.sp,
                      color: Colors.white,
                    ),
                    label: Text(
                      " Call",
                      style: buttonTextStyle,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

List<String> getImage(AdsPost adsData) {
  List<String> li = [];
  if (adsData.pImg1 != null && adsData.pImg1 != "") {
    li.add(adsData.pImg1);
  }
  if (adsData.pImg2 != null && adsData.pImg2 != "") {
    li.add(adsData.pImg2);
  }

  if (adsData.pImg3 != null && adsData.pImg3 != "") {
    li.add(adsData.pImg3);
  }

  if (adsData.pImg4 != null && adsData.pImg4 != "") {
    li.add(adsData.pImg4);
  }

  if (adsData.pImg5 != null && adsData.pImg5 != "") {
    li.add(adsData.pImg5);
  }
  return li;
}
