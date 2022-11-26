import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:ubs/model/ads_post.dart';
import 'package:get/get.dart';
import 'package:ubs/model/post_reaction.dart';
import 'package:ubs/model/user_login.dart';
import 'package:ubs/pages/dashboard/dashboard.dart';
import 'package:ubs/pages/my_ads/controller/my_ads_controller.dart';
import 'package:ubs/pages/my_ads/widgets/empty_page.dart';
import 'package:ubs/services/remote_services.dart';
import 'package:ubs/sharing_widget/widget_fun.dart';
import 'package:ubs/utils/constants.dart';
import 'package:ubs/utils/custom_fun.dart';
import 'package:ubs/utils/text_style.dart';

class FavoritesList extends StatefulWidget {
  final UserLogin userLogin;
  const FavoritesList({super.key, required this.userLogin});

  @override
  State<FavoritesList> createState() => _FavoritesListState();
}

class _FavoritesListState extends State<FavoritesList> {
  final MyAdsController myAdsController = Get.find<MyAdsController>();

  @override
  void initState() {
    super.initState();
    myAdsController.fetchFavoriteAds(widget.userLogin.userId);
  }

  void addPostReaction(AdsPost ads) async {
    PostReaction postReaction = PostReaction(
        uid: widget.userLogin.userId,
        pid: ads.pId!,
        pFavorite: ads.pFavorite == 1 ? 0 : 1,
        pView: ads.pView ?? 0);
    var res = await RemoteServices.addPostReaction(postReaction);
    if (res) {
      myAdsController.fetchFavoriteAds(widget.userLogin.userId);
    }
  }

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    // double imgSize = size.width * 0.15;

    return RefreshIndicator(
      onRefresh: () async {
        myAdsController.fetchFavoriteAds(widget.userLogin.userId);
      },
      child: Padding(
        padding: EdgeInsets.only(top: 10.h),
        child: Obx(
          () => myAdsController.adsList.value.isEmpty
              ? myAdsController.favoritesAdsLoading.value == true
                  ? const Center(child: CircularProgressIndicator())
                  : EmptyPage(
                      size: size,
                      btnName: "Discover",
                      onBtnPress: () {
                        Get.offAll(DashboardPage(
                          userData: widget.userLogin,
                          selectPage: 0,
                        ));
                      },
                      imagePath: "lib/assets/images/favorites_list.png")
              : ListView.builder(
                  itemCount: myAdsController.adsList.value.length,
                  itemBuilder: (BuildContext context, int index) {
                    AdsPost ads = myAdsController.adsList.value[index];
                    return Container(
                      margin: EdgeInsets.symmetric(vertical: 6.h),
                      padding: EdgeInsets.symmetric(
                          vertical: 15.h, horizontal: 30.w),
                      decoration: BoxDecoration(
                        border: Border(
                          bottom: BorderSide(
                            width: 1.5,
                            color: lightBlackColor.withAlpha(100),
                          ),
                        ),
                      ),
                      child: Row(children: [
                        SizedBox(
                          width: 160.sp,
                          height: 160.sp,
                          child: Image.network(
                            getLink(ads.pImg1),
                            fit: BoxFit.fitWidth,
                          ),
                        ),
                        addHorizontalSpace(25.w),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "₹ ${ads.pPrice.toString()}",
                                style: heading4,
                              ),
                              const SizedBox(height: 4),
                              Text(
                                ads.pTitle,
                                style: heading6,
                                maxLines: 2,
                                softWrap: true,
                              ),
                            ],
                          ),
                        ),
                        Spacer(),
                        const SizedBox(width: 15),
                        GestureDetector(
                          onTap: () => addPostReaction(ads),
                          child: Container(
                            padding: EdgeInsets.all(5.sp),
                            child: Icon(
                              Icons.favorite,
                              size: 70.sp,
                              color: primaryColor,
                            ),
                          ),
                        ),
                        addHorizontalSpace(12),
                      ]),
                    );
                  },
                ),
        ),
      ),
    );
  }
}


// return Container(
//   padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
//   decoration: const BoxDecoration(
//     border:
//         Border(bottom: BorderSide(color: Colors.black87, width: 0.8)),
//   ),
//   child: SizedBox(
//       width: double.infinity,
//       height: imgSize,
//       child: Row(
//         children: [
//           SizedBox(
//             height: imgSize,
//             width: imgSize,
//             child: Container(
//               color: Colors.red,
//             ),
//             // child: ShowImage(
//             //   imageUrl: getLink("ad")),
//           ),
//           const SizedBox(width: 20),
//           Column(
//             mainAxisAlignment: MainAxisAlignment.center,
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               Text(
//                 "\$ 5,000",
//                 style: labelText,
//               ),
//               Text(
//                 "Iphone 11 pro 2015",
//                 style: textfield,
//               ),
//             ],
//           ),
//           Spacer(),
//           Icon(Icons.favorite)
//         ],
//       )),
// );
      
