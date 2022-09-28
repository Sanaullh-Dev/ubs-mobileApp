import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:ubs/model/ads_post.dart';
import 'package:ubs/pages/PostDetails/widget/RelatedAds.dart';
import 'package:ubs/pages/PostDetails/widget/image_slider.dart';
import 'package:ubs/pages/PostDetails/widget/title_bar.dart';
import 'package:ubs/sharing_widget/widget_fun.dart';
import 'package:ubs/utils/constants.dart';

class PostDetails extends StatelessWidget {
  // final PostModel postData;
  final AdsPost adsPostData;
  const PostDetails({super.key, required this.adsPostData});

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    final TextTheme textTheme = Theme.of(context).textTheme;
    List<String> imgeLi = getImage(adsPostData);

    return SafeArea(
      child: Scaffold(
        body: SizedBox(
          width: size.width,
          height: size.height,
          child: Stack(
            children: [
              SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Hero(
                      tag: "post${adsPostData.pId}",
                      child: ImageSlider(
                        imgList: imgeLi,
                      ),
                    ),
                    // Ads heading Section
                    TitleBar(adsPostData: adsPostData),
                    addVerticalSpace(15),
                    // Description section
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          vertical: 8, horizontal: 15),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Description",
                            style: textTheme.headline3,
                          ),
                          addVerticalSpace(8),
                          Text(
                            adsPostData.pDescribe,
                            textAlign: TextAlign.start,
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
                        style: textTheme.headline3,
                      ),
                    ),
                    RelatedAds(
                        mCateId: adsPostData.pMcat,
                        showingPostId: adsPostData.pId!)
                  ],
                ),
              ),

              // Sticky App bar on top
              Positioned(
                  top: 0,
                  child: Container(
                    width: size.width,
                    padding: const EdgeInsets.symmetric(horizontal: 20),
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
                          icon: const Icon(
                            Icons.arrow_back,
                            size: 30,
                            color: Colors.white,
                          ),
                        ),
                        IconButton(
                          onPressed: () {},
                          icon: const Icon(
                            Icons.share,
                            size: 30,
                            color: Colors.white,
                          ),
                        ),
                      ],
                    ),
                  )),
            ],
          ),
        ),
        bottomNavigationBar: BottomAppBar(
          color: Colors.white,
          elevation: 50,
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 18),
            child: Row(
              children: [
                Expanded(
                  child: TextButton.icon(
                    onPressed: () {},
                    icon: Icon(
                      FontAwesomeIcons.comment,
                      size: 25,
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
                    icon: iconOnButton(FontAwesomeIcons.phone),
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
  if (adsData.pImg1 != null) {
    li.add(adsData.pImg1);
  }
  if (adsData.pImg2 != null) {
    li.add(adsData.pImg2);
  }

  if (adsData.pImg3 != null) {
    li.add(adsData.pImg3);
  }

  if (adsData.pImg4 != null) {
    li.add(adsData.pImg4);
  }

  if (adsData.pImg5 != null) {
    li.add(adsData.pImg5);
  }
  return li;
}
