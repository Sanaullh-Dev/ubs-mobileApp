import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:ubs/model/ads_post.dart';
import 'package:ubs/model/user_login.dart';
import 'package:ubs/pages/my_ads/controller/my_ads_controller.dart';
import 'package:ubs/pages/my_ads/my_ads/view_ads/view_my_ads.dart';
import 'package:ubs/pages/my_ads/widgets/empty_page.dart';
import 'package:ubs/pages/selling/sale_main_categories.dart';
import 'package:ubs/services/remote_services.dart';
import 'package:ubs/sharing_widget/widget_fun.dart';
import 'package:ubs/utils/custom_fun.dart';
import 'package:ubs/utils/text_style.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class MyAdsList extends StatefulWidget {
  final UserLogin userLogin;
  const MyAdsList({super.key, required this.userLogin});

  @override
  State<MyAdsList> createState() => _MyAdsListState();
}

class _MyAdsListState extends State<MyAdsList> {
  final MyAdsController myAdsController = Get.find<MyAdsController>();
  var dateFormat = DateFormat('dd-MMM-yyyy');
  RxBool isDismissible = true.obs;

  @override
  void initState() {
    super.initState();
    myAdsController.fetchMySalesAds(widget.userLogin.userId);
  }

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;

    return Obx(
      () => myAdsController.mySalesAdsList.value.isEmpty
          ? myAdsController.myAdsLoading.value == true
              ? const Center(child: CircularProgressIndicator())
              : EmptyPage(
                  size: size,
                  btnName: "Post",
                  onBtnPress: () {
                    Get.to(SaleMainCategories(userData: widget.userLogin));
                  },
                  imagePath: "lib/assets/images/my_ads.png")
          : RefreshIndicator(
              onRefresh: () async {
                myAdsController.fetchMySalesAds(widget.userLogin.userId);
              },
              child: ListView.builder(
                itemCount: myAdsController.mySalesAdsList.value.length,
                itemBuilder: (BuildContext context, int index) {
                  AdsPost ads = myAdsController.mySalesAdsList.value[index];
                  return Container(
                    width: double.infinity,
                    margin: EdgeInsets.fromLTRB(40.sp, 30.sp, 30.sp, 20.sp),
                    padding: EdgeInsets.only(bottom: 20.sp),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(12.r),
                        color: Colors.white,
                        boxShadow: [
                          const BoxShadow(
                              color: Colors.black45,
                              offset: Offset(2, 2),
                              blurRadius: 4),
                          BoxShadow(
                              color: Colors.blueGrey[800]!,
                              offset: const Offset(-6, 0),
                              blurRadius: 0)
                        ]),
                    child: Column(
                      children: [
                        Container(
                          padding: EdgeInsets.symmetric(
                              horizontal: 30.sp, vertical: 15.sp),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.vertical(
                                top: Radius.circular(12.r)),
                            color: Colors.blueGrey[100],
                          ),
                          child: Row(
                            mainAxisSize: MainAxisSize.max,
                            children: [
                              Text(
                                  "Publish on ${dateFormat.format(ads.pDate!)}",
                                  style: cardTitle.copyWith(fontSize: 26.sp)),
                              const Spacer(),
                              PopupMenuButton(
                                child: const Icon(Icons.more_horiz),
                                itemBuilder: (context) =>
                                    const <PopupMenuItem<String>>[
                                  PopupMenuItem<String>(
                                      value: 'Delete', child: Text('Delete')),
                                ],
                                onSelected: (val) async {
                                  if (val == "Delete") {
                                    alertDialogBox(
                                        context: context,
                                        title: "Delete Listing",
                                        message:
                                            "You want to delete your ads and you can't be undo this",
                                        onOK: () async {
                                          await RemoteServices.deleteMySalesAds(
                                              widget.userLogin.userId,
                                              ads.pId!);
                                          myAdsController.fetchMySalesAds(
                                              widget.userLogin.userId);
                                        });
                                  }
                                },
                              ),

                              // IconButton(
                              //     onPressed: () {},
                              //     icon: const Icon(Icons.more_horiz))
                            ],
                          ),
                        ),
                        InkWell(
                          onTap: () {
                            Get.to(ViewMyAds(
                                adsPostData: ads, userData: widget.userLogin));
                          },
                          child: Container(
                            color: Colors.white,
                            child: Padding(
                              padding: EdgeInsets.only(left: 20.sp, top: 20.sp),
                              child: Row(
                                children: [
                                  SizedBox(
                                    width: 190.sp,
                                    height: 190.sp,
                                    child: Hero(
                                      tag: "post${ads.pId}",
                                      transitionOnUserGestures: true,
                                      child: Image.network(
                                        getLink(ads.pImg1),
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                  ),
                                  SizedBox(width: 25.sp),
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        ads.pTitle,
                                        style: messageLabel,
                                        maxLines: 1,
                                        softWrap: true,
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                      SizedBox(height: 8.sp),
                                      Text(
                                        "₹ ${ads.pPrice.toString()}",
                                        style: heading6,
                                      ),
                                      SizedBox(height: 5.sp),
                                      Row(
                                        children: [
                                          Icon(Icons.remove_red_eye,
                                              size: 44.sp),
                                          Text(" View : ${ads.pView ?? 0}",
                                              style: btnText.copyWith(
                                                  fontSize: 30.sp)),
                                          SizedBox(width: 20.sp),
                                          Text("|",
                                              style: btnText.copyWith(
                                                  fontSize: 30.sp)),
                                          SizedBox(width: 20.sp),
                                          Icon(Icons.favorite, size: 40.sp),
                                          Text(
                                              " favorite : ${ads.pFavorite ?? 0}",
                                              style: btnText),
                                        ],
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                        Divider(
                            color: Colors.blueGrey[100],
                            thickness: 2,
                            endIndent: 15,
                            indent: 15,
                            height: 45.sp),
                        Padding(
                          padding: EdgeInsets.only(right: 30.sp),
                          child: Align(
                            alignment: Alignment.centerRight,
                            child: ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                  backgroundColor: Colors.white,
                                  padding: EdgeInsets.symmetric(
                                      horizontal: 60.sp, vertical: 25.sp),
                                  side: const BorderSide(
                                      width: 3, color: Colors.blueGrey)),
                              child:
                                  Text("Mark as sold", style: buttonTextLight),
                              onPressed: () {},
                            ),
                          ),
                        )
                      ],
                    ),
                  );
                },
              ),
            ),
    );
  }
}
