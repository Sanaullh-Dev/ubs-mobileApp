import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:get/get.dart';
import 'package:ubs/model/ads_post.dart';
import 'package:ubs/model/post_reaction.dart';
import 'package:ubs/model/user_login.dart';
import 'package:ubs/pages/post_details/post_details.dart';
import 'package:ubs/pages/home/controller/home_controller.dart';
import 'package:ubs/services/remote_services.dart';
import 'package:ubs/sharing_widget/show_image.dart';
import 'package:ubs/sharing_widget/widget_fun.dart';
import 'package:ubs/utils/constants.dart';
import 'package:ubs/utils/custom_fun.dart';
import 'package:ubs/utils/text_style.dart';

class AdsList extends StatefulWidget {
  final UserLogin userData;
  final List<AdsPost> adsPost;
  const AdsList({Key? key, required this.adsPost, required this.userData})
      : super(key: key);

  @override
  State<AdsList> createState() => _AdsListState();
}

class _AdsListState extends State<AdsList> {
  final homeController = Get.find<HomeController>();

  void addPostReaction(int index) async {
    PostReaction postReaction = PostReaction(
        uid: widget.userData.userId,
        pid: widget.adsPost[index].pId!,
        pFavorite: widget.adsPost[index].pFavorite == 1 ? 0 : 1,
        pView: widget.adsPost[index].pView ?? 0);
    var res = await RemoteServices.addPostReaction(postReaction);
    if (res) {
      homeController.fetchAds();
    }
  }

  @override
  Widget build(BuildContext context) {
    return AlignedGridView.count(
      primary: false,
      shrinkWrap: true,
      crossAxisCount: 2,
      // scrollDirection: Axis.vertical,
      itemCount: widget.adsPost.length,
      itemBuilder: (BuildContext context, int index) {
        return GestureDetector(
          onTap: () {
            Get.to(PostDetails(
              userData: widget.userData,
              adsPostData: widget.adsPost[index],
            ));
          },
          child: Container(
            margin: EdgeInsets.symmetric(vertical: 15.h, horizontal: 13.w),
            padding: EdgeInsets.symmetric(vertical: 15.h, horizontal: 18.w),
            decoration: BoxDecoration(
                color: Colors.white,
                border: Border.all(width: 2, color: Colors.grey.shade400),
                borderRadius: BorderRadius.circular(20.r)),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Stack(
                  children: [
                    // --- For Cover Image
                    Container(
                      alignment: Alignment.center,
                      height: 230.sp,
                      child: Hero(
                          tag: "post${widget.adsPost[index].pId}",
                          transitionOnUserGestures: true,
                          child: ShowImage(
                              imageUrl: getLink(widget.adsPost[index].pImg1))),
                    ),
                    // ----- for features batch
                    // Positioned(
                    //   top: 15.h,
                    //   left: 0,
                    //   child: adsPost[index].pImg3 == null
                    //       ? const SizedBox()
                    //       : featuredTag(),
                    // ),
                    // ------ for favorite icon
                    Positioned(
                      right: 5.w,
                      top: 5.h,
                      child: GestureDetector(
                        onTap: () => addPostReaction(index),
                        child: Container(
                          padding: EdgeInsets.all(10.w),
                          decoration: favoriteBorder,
                          child: Icon(
                            widget.adsPost[index].pFavorite == 1
                                ? Icons.favorite
                                : Icons.favorite_border,
                            size: 40.sp,
                            color: widget.adsPost[index].pFavorite == 1
                                ? Colors.red
                                : Colors.black54,
                          ),
                        ),
                      ),
                    )
                  ],
                ),
                // addVerticalSpace(15.h),
                SizedBox(
                  height: 50.h,
                  // -----for Name product
                  child: Text(
                    "₹ ${widget.adsPost[index].pPrice.toString()}",
                    style: heading3,
                  ),
                ),
                SizedBox(
                  height: 50.h,
                  // -----for Name product
                  child: Text(
                    widget.adsPost[index].pTitle,
                    overflow: TextOverflow.ellipsis,
                    softWrap: false,
                    maxLines: 1,
                    style:
                        TextStyle(fontWeight: FontWeight.w400, fontSize: 30.sp),
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Icon(
                      Icons.location_on_outlined,
                      size: 35.sp,
                    ),
                    addHorizontalSpace(10.w),
                    Text(
                      // AddLists[index]["Location"],
                      widget.adsPost[index].pLocation,
                      overflow: TextOverflow.ellipsis,
                      softWrap: false,
                      maxLines: 1,
                      style: TextStyle(
                          color: blackColor,
                          fontWeight: FontWeight.w400,
                          fontSize: 32.sp),
                    )
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
