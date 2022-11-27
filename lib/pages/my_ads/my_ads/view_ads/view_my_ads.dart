import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:ubs/model/ads_post.dart';
import 'package:ubs/model/user_login.dart';
import 'package:ubs/pages/post_details/widget/image_slider.dart';
import 'package:ubs/sharing_widget/widget_fun.dart';
import 'package:ubs/utils/constants.dart';
import 'package:ubs/utils/text_style.dart';

class ViewMyAds extends StatefulWidget {
  final UserLogin userData;
  final AdsPost adsPostData;
  const ViewMyAds({
    super.key,
    required this.adsPostData,
    required this.userData,
  });

  @override
  State<ViewMyAds> createState() => _ViewMyAdsState();
}

class _ViewMyAdsState extends State<ViewMyAds> {
  // final PostDetailsController postDetController =
  //     Get.find<PostDetailsController>();
  // final HomeController homeCont = Get.find<HomeController>();
  // Rx<UsersData>? userData;

  @override
  void initState() {
    super.initState();
    // postDetController.adsPost.value = widget.adsPostData;
  }

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    AdsPost ads = widget.adsPostData;
    return SafeArea(
      child: Scaffold(
        body: SizedBox(
          width: size.width,
          height: size.height,
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Stack(
                  children: [
                    Hero(
                      tag: "post${ads.pId}",
                      child: ImageSlider(
                        imgList: getImage(ads),
                      ),
                    ),
                    Positioned(
                        top: 0,
                        child: Container(
                          width: size.width,
                          height: 70,
                          padding: EdgeInsets.symmetric(horizontal: 40.w),
                          decoration: BoxDecoration(
                            gradient: LinearGradient(
                                colors: [
                                  Colors.black87,
                                  Colors.black.withAlpha(10)
                                ],
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
                              Wrap(
                                children: [
                                  IconButton(
                                    onPressed: () {},
                                    icon: Icon(
                                      Icons.share,
                                      size: 60.sp,
                                      color: Colors.white,
                                    ),
                                  ),
                                  const SizedBox(width: 15),
                                  IconButton(
                                    onPressed: () {},
                                    icon: Icon(
                                      Icons.edit_outlined,
                                      size: 60.sp,
                                      color: Colors.white,
                                    ),
                                  ),
                                ],
                              )
                            ],
                          ),
                        )),
                  ],
                ),
                // Ads heading Section
                addVerticalSpace(10.h),
                // addDivider(),
                PostReactionBar(adsData: widget.adsPostData),
                addDivider(),
                addVerticalSpace(30.h),
                ListTile(
                  title: Text(widget.adsPostData.pTitle, style: heading2InBold),
                  subtitle: Text(widget.adsPostData.pBrand, style: heading3),
                ),
                addDivider(),
                addVerticalSpace(30.h),
                // Description section
                Padding(
                  padding:
                      const EdgeInsets.symmetric(vertical: 8, horizontal: 15),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("Description", style: heading2InBold),
                      addVerticalSpace(8),
                      Text(ads.pDescribe,
                          textAlign: TextAlign.start, style: heading5)
                    ],
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
  if (adsData.pImg1 != "") {
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

class PostReactionBar extends StatelessWidget {
  final AdsPost adsData;
  const PostReactionBar({super.key, required this.adsData});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Wrap(children: [
            Icon(Icons.remove_red_eye_outlined, size: 60.sp),
            const SizedBox(width: 10),
            Text(adsData.pView != null ? adsData.pView.toString() : "0",
                style: heading2)
          ]),
          Wrap(children: [
            Icon(Icons.favorite, color: primaryColor, size: 60.sp),
            const SizedBox(width: 10),
            Text(adsData.pFavorite != null ? adsData.pFavorite.toString() : "0",
                style: heading2)
          ]),
        ],
      ),
    );
  }
}
