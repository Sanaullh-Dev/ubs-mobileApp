import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:ubs/model/ads_post.dart';
import 'package:ubs/model/post_reaction.dart';
import 'package:ubs/model/user_login.dart';
import 'package:ubs/model/users_data.dart';
import 'package:ubs/pages/Chats/chat_individual/charts_individual.dart';
import 'package:ubs/pages/Chats/controller/chats_controller.dart';
import 'package:ubs/pages/Post_details/controller/post_details_controller.dart';
import 'package:ubs/pages/Post_details/widget/RelatedAds.dart';
import 'package:ubs/pages/Post_details/widget/image_slider.dart';
import 'package:ubs/pages/Post_details/widget/title_bar.dart';
import 'package:ubs/pages/Post_details/widget/userinfo_bar.dart';
import 'package:ubs/pages/accounts/profile_page.dart/user_profile.dart';
import 'package:ubs/pages/home/controller/home_controller.dart';
import 'package:ubs/services/remote_services.dart';
import 'package:ubs/sharing_widget/widget_fun.dart';
import 'package:ubs/utils/text_style.dart';

class PostDetails extends StatefulWidget {
  final UserLogin userData;
  final AdsPost adsPostData;
  const PostDetails(
      {super.key, required this.adsPostData, required this.userData});

  @override
  State<PostDetails> createState() => _PostDetailsState();
}

class _PostDetailsState extends State<PostDetails> {
  final PostDetailsController postDetController =
      Get.find<PostDetailsController>();
  final ChatsController chatsController = Get.find<ChatsController>();
  final HomeController homeCont = Get.find<HomeController>();
  Rx<UsersData>? userData;

  @override
  void initState() {
    super.initState();
    postDetController.adsPost.value = widget.adsPostData;
    int pFavorite = widget.adsPostData.pFavorite == null
        ? 0
        : widget.adsPostData.pFavorite!;
    postDetController.postFavorite.value = pFavorite;
    updateViewReaction();
    postDetController.fetchUserInfo(widget.adsPostData.pUid);
  }

  updateViewReaction() async {
    PostReaction postReaction = PostReaction(
        uid: widget.userData.userId,
        pid: widget.adsPostData.pId!,
        pFavorite: widget.adsPostData.pFavorite ?? 0,
        pView: 1);
    await RemoteServices.addPostReaction(postReaction);
    await postDetController.getAdsPostDetails(widget.adsPostData);

    var res = await RemoteServices.getUserData(widget.adsPostData.pUid);
    if (res != null) {
      userData?.value = res;
    }
  }

  updateFavorite() async {
    PostReaction postReaction = PostReaction(
        uid: widget.userData.userId,
        pid: widget.adsPostData.pId!,
        pFavorite: widget.adsPostData.pFavorite ?? 0,
        pView: 1);
    await RemoteServices.updatedFavorite(postReaction);
  }

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    ScrollController scrollController = ScrollController();
    // final TextTheme textTheme = Theme.of(context).textTheme;

    return SafeArea(
      child: WillPopScope(
        onWillPop: () async {
          await homeCont.fetchAds();
          return true;
        },
        child: Scaffold(
          body: SizedBox(
            width: size.width,
            height: size.height,
            child: Obx(
              () => Stack(
                children: [
                  SingleChildScrollView(
                    controller: scrollController,
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
                        TitleBar(
                            adsPostData: postDetController.adsPost.value,
                            userLogin: widget.userData),
                        addVerticalSpace(40.h),
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
                        // Title - Related Added
                        const SizedBox(height: 40),
                        addDivider(),
                        // User Profile Bar
                        InkWell(
                          onTap: () {
                            Get.to(UserProfile(
                                userLogin: widget.userData,
                                profileUser: postDetController.userData.value));
                          },
                          child: UserInfoBar(
                              url: postDetController.userData.value.uName,
                              userName: postDetController.userData.value.uName,
                              onPress: () {}),
                        ),
                        addDivider(),
                        const SizedBox(height: 20),
                        // Related Added
                        Padding(
                          padding: const EdgeInsets.symmetric(
                              vertical: 8, horizontal: 25),
                          child: Text(
                            "Related Ads",
                            style: heading3,
                          ),
                        ),
                        const SizedBox(height: 20),
                        RelatedAds(
                            scrolledCont: scrollController,
                            usersData: widget.userData,
                            mCateId: postDetController.adsPost.value.pMcat,
                            showingPostId:
                                postDetController.adsPost.value.pId!),
                        const SizedBox(height: 20),
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
                                homeCont.fetchAds();
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
                      onPressed: () {
                        chatsController
                            .addChatRoom(
                                loggedUser: widget.userData.userId,
                                adsPostData: postDetController.adsPost.value)
                            .then((docId) {
                          if (docId != null) {
                            Get.to(ChatsIndividual(
                                douId: docId,
                                userLogin: widget.userData,
                                adsData: postDetController.adsPost.value));
                          }
                        });
                      },
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
