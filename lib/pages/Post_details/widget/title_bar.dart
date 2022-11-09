import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:ubs/model/ads_post.dart';
import 'package:ubs/model/post_reaction.dart';
import 'package:ubs/model/user_login.dart';
import 'package:ubs/pages/Post_details/controller/post_details_controller.dart';
import 'package:ubs/services/remote_services.dart';
import 'package:ubs/sharing_widget/widget_fun.dart';
import 'package:ubs/utils/constants.dart';
import 'package:ubs/utils/text_style.dart';

class TitleBar extends StatelessWidget {
  final AdsPost adsPostData;
  final UserLogin userLogin;
  TitleBar({super.key, required this.adsPostData, required this.userLogin});

  final PostDetailsController postDetailsCon =
      Get.find<PostDetailsController>();

  void updatedFavorite() async {
    PostReaction postReaction = PostReaction(
        uid: userLogin.userId,
        pid: adsPostData.pId!,
        pFavorite: postDetailsCon.postFavorite.value == 1 ? 0 : 1,
        pView: adsPostData.pView ?? 0);
    var res = await RemoteServices.updatedFavorite(postReaction);
    if (res) {
      getSnackBarFavorite();
      await postDetailsCon.getAdsPostDetails(adsPostData);
    }
  }

  @override
  Widget build(BuildContext context) {
    final TextTheme textTheme = Theme.of(context).textTheme;
    return Container(
      padding: EdgeInsets.symmetric(vertical: 12.w, horizontal: 25.h),
      decoration: BoxDecoration(
          color: Colors.yellow.withAlpha(200),
          border: Border(
              bottom: BorderSide(width: 2, color: Colors.blueGrey.shade200))),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                adsPostData.pPrice.toString(),
                style: heading1,
              ),
              Obx(() => GestureDetector(
                    onTap: () => updatedFavorite(),
                    child: Padding(
                      padding: EdgeInsets.only(right: 15.w),
                      child: Container(
                        padding: const EdgeInsets.all(5),
                        decoration: favoriteBorder,
                        child: Icon(
                          postDetailsCon.postFavorite.value == 1
                              ? Icons.favorite
                              : Icons.favorite_border,
                          size: 60.sp,
                          color: postDetailsCon.postFavorite.value == 1
                              ? Colors.red
                              : Colors.black,
                        ),
                      ),
                    ),
                  ))
            ],
          ),
          addVerticalSpace(8.h),
          Text(
            // "Sub Title About post and more details",
            adsPostData.pTitle,
            style: heading4,
          ),
          addVerticalSpace(8.h),
          addVerticalSpace(8.h),
          Row(
            children: [
              Icon(
                Icons.location_on,
                size: 50.sp,
              ),
              Text(
                // "Location name about post",
                adsPostData.pLocation,
                style: heading5,
              ),
              const Expanded(child: SizedBox()),
              Text(
                DateFormat("dd-MMM-yy").format(adsPostData.pDate!).toString(),
                style: heading4,
              )
            ],
          ),
        ],
      ),
    );
  }
}
