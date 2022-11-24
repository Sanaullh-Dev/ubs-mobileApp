import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:ubs/model/ads_post.dart';
import 'package:ubs/model/user_login.dart';
import 'package:ubs/pages/my_ads/controller/my_ads_controller.dart';
import 'package:ubs/pages/my_ads/my_ads/view_ads/view_my_ads.dart';
import 'package:ubs/pages/my_ads/widgets/empty_page.dart';
import 'package:ubs/pages/selling/sale_main_categories.dart';
import 'package:ubs/sharing_widget/widget_fun.dart';
import 'package:ubs/utils/custom_fun.dart';
import 'package:ubs/utils/text_style.dart';

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
                    margin: const EdgeInsets.fromLTRB(20, 15, 15, 15),
                    padding: const EdgeInsets.only(bottom: 15),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(6),
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
                          padding: const EdgeInsets.symmetric(
                              horizontal: 15, vertical: 10),
                          decoration: BoxDecoration(
                            borderRadius: const BorderRadius.vertical(
                                top: Radius.circular(6)),
                            color: Colors.blueGrey[100],
                          ),
                          child: Row(
                            mainAxisSize: MainAxisSize.max,
                            // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text("Publish on ${dateFormat.format(ads.pDate!)}",
                                  style: cardTitle),
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
                                          // await RemoteServices.deleteMySalesAds(
                                          //     widget.userLogin.userId, ads.pId!);
                                          // myAdsController.fetchMySalesAds(
                                          //     widget.userLogin.userId);
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
                              padding: const EdgeInsets.only(left: 10, top: 10),
                              child: Row(
                                children: [
                                  SizedBox(
                                    width: 100,
                                    height: 100,
                                    child: Hero(
                                      tag: "post${ads.pId}",
                                      transitionOnUserGestures: true,
                                      child: Image.network(
                                        getLink(ads.pImg1),
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                  ),
                                  const SizedBox(width: 15),
                                  Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
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
                                      const SizedBox(height: 5),
                                      Text(
                                        "₹ ${ads.pPrice.toString()}",
                                        style: heading5,
                                      ),
                                      const SizedBox(height: 5),
                                      Row(
                                        children: [
                                          const Icon(Icons.remove_red_eye),
                                          Text("  View : ${ads.pView ?? 0}",
                                              style: btnText),
                                          const SizedBox(width: 15),
                                          Text("|", style: btnText),
                                          const SizedBox(width: 15),
                                          const Icon(Icons.favorite),
                                          Text(
                                              "  favorite : ${ads.pFavorite ?? 0}",
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
                            height: 25),
                        Padding(
                          padding: const EdgeInsets.only(right: 15),
                          child: Align(
                            alignment: Alignment.centerRight,
                            child: ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                  backgroundColor: Colors.white,
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 30, vertical: 15),
                                  side: const BorderSide(
                                      width: 3, color: Colors.blueGrey)),
                              child: Text("Mark as sold", style: buttonTextLight),
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
