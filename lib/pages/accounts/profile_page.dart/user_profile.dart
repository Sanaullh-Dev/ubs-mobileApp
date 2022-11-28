import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:ubs/model/ads_post.dart';
import 'package:ubs/model/user_login.dart';
import 'package:ubs/model/users_data.dart';
import 'package:ubs/services/remote_services.dart';
import 'package:ubs/sharing_widget/show_image.dart';
import 'package:ubs/utils/constants.dart';
import 'package:ubs/utils/custom_fun.dart';
import 'package:ubs/utils/text_style.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class UserProfile extends StatefulWidget {
  final UsersData profileUser;
  final UserLogin userLogin;
  const UserProfile(
      {super.key, required this.profileUser, required this.userLogin});

  @override
  State<UserProfile> createState() => _UserProfileState();
}

class _UserProfileState extends State<UserProfile> {
  RxList<AdsPost> adsPos = <AdsPost>[].obs;

  @override
  void initState() {
    super.initState();
    getUserAds();
  }

  getUserAds() async {
    var res = await RemoteServices.fetchUserProfileAds(
        widget.profileUser.logId, widget.userLogin.userId);
    adsPos.value = res ?? [];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back, size: 50.sp),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 30.sp),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 10.sp),
            Padding(
              padding: EdgeInsets.symmetric(vertical: 25.sp),
              child: Row(
                children: [
                  SizedBox(
                      width: 180.sp,
                      height: 180.sp,
                      child: ShowUserPhoto(
                          imageUrl: getLink(widget.profileUser.uPhoto))),
                  Expanded(
                    child: Column(
                      children: [
                        IntrinsicHeight(
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Column(
                                children: [
                                  Text("5", style: heading2InBold),
                                  Text("Following", style: heading6)
                                ],
                              ),
                              const VerticalDivider(
                                  color: blackColor, thickness: 1, width: 20),
                              Column(
                                children: [
                                  Text("15", style: heading2InBold),
                                  Text("Followers", style: heading6)
                                ],
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(height: 15),
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 40),
                          width: double.infinity,
                          child: ElevatedButton(
                              onPressed: () {}, child: const Text("Follow")),
                        )
                      ],
                    ),
                  )
                ],
              ),
            ),
            SizedBox(height: 8.sp),
            Text(widget.profileUser.uName,
                style: heading5.copyWith(fontWeight: FontWeight.w700)),
            SizedBox(height: 8.sp),
            Text("Member since from Oct 2022", style: heading6),
            Divider(thickness: 3, color: Colors.black38, height: 70.sp),
            Text("Published ads", style: titleLabel),
            const SizedBox(height: 20),
            Obx(
              () => Expanded(
                child: adsPos.isEmpty
                    ? const Center(child: CircularProgressIndicator())
                    : ListView.builder(
                        // physics: const NeverScrollableScrollPhysics(),
                        // shrinkWrap: true,
                        itemCount: adsPos.value.length,
                        itemBuilder: (BuildContext context, int index) {
                          var ads = adsPos.value[index];
                          return Container(
                            margin: EdgeInsets.only(bottom: 25.sp),
                            height: 240.sp,
                            child: Card(
                              elevation: 5,
                              shadowColor: Colors.black,
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10)),
                              child: Row(
                                children: [
                                  ClipRRect(
                                    borderRadius: BorderRadius.horizontal(
                                        left: Radius.circular(15.r)),
                                    child: SizedBox(
                                        width: 240.sp,
                                        height: 240.sp,
                                        child: ShowImage(
                                            imageUrl: getLink(ads.pImg1))),
                                  ),
                                  SizedBox(width: 20.sp),
                                  Expanded(
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        SizedBox(height: 20.sp),
                                        Row(
                                          children: [
                                            Text("₹ ${ads.pPrice}",
                                                style: heading4),
                                            const Spacer(),
                                            ads.pFavorite == 1
                                                ? Icon(Icons.favorite,
                                                    color: Colors.red,
                                                    size: 50.sp)
                                                : Icon(Icons.favorite_border,
                                                    color: Colors.black,
                                                    size: 50.sp),
                                            SizedBox(width: 30.sp)
                                          ],
                                        ),
                                        const SizedBox(height: 5),
                                        Text(ads.pTitle, style: titleLabel),
                                        const Spacer(),
                                        Row(
                                          children: [
                                            Icon(Icons.location_on,
                                                size: 40.sp),
                                            SizedBox(width: 5.sp),
                                            Text(ads.pLocation,
                                                style: subTitle2),
                                            const Spacer(),
                                            Text(DateFormat("dd-MMM-yy")
                                                .format(ads.pDate!)
                                                .toString()),
                                            SizedBox(width: 35.sp),
                                          ],
                                        ),
                                        const SizedBox(height: 15),
                                      ],
                                    ),
                                  )
                                ],
                              ),
                            ),
                          );
                        },
                      ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
