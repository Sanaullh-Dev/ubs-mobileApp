import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:ubs/model/post_model.dart';
import 'package:ubs/pages/Post/widget/details_points.dart';
import 'package:ubs/pages/Post/widget/image_slider.dart';
import 'package:ubs/pages/Post/widget/title_bar.dart';
import 'package:ubs/sharing_widget/widget_fun.dart';
import 'package:ubs/pages/Post/widget/RelatedAds.dart';
import 'package:ubs/utils/constants.dart';

class PostDetails extends StatelessWidget {
  final PostModel postData;
  const PostDetails({super.key, required this.postData});

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    final TextTheme textTheme = Theme.of(context).textTheme;
    
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
                      tag: "post${postData.id}",
                      child: ImageSlider(
                        imgList: [
                          // ads["image1"],
                          postData.image1,
                          postData.image2,
                          postData.image3,
                        ],
                      ),
                    ),
                    // Ads heading Section
                    TitleBar(postData: postData),
                    addVerticalSpace(15),
                    // Details Point section
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          vertical: 8, horizontal: 15),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Details",
                            style: textTheme.headline3,
                          ),
                          addVerticalSpace(8),
                          const DetailsPoints(title: "Type", info: "Apartment"),
                          const DetailsPoints(title: "Type", info: "Apartment"),
                          const DetailsPoints(title: "Type", info: "Apartment"),
                          const DetailsPoints(title: "Type", info: "Apartment"),
                        ],
                      ),
                    ),
                    addDivider(),
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
                          const Text(
                            '''Lorem ipsum dolor sit amet consectetur adipisicing elit.Maxime mollitia molestiae quas vel sint commodi repudiandae consequuntur voluptatum laborum''',
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
                    const RelatedAds()
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
            padding: const EdgeInsets.symmetric(vertical: 8 , horizontal: 18),
            child: Row(
              children: [
                Expanded(
                  child: TextButton.icon(
                    onPressed: () {},
                    icon: Icon(FontAwesomeIcons.comment,size: 25, color: Colors.white,),
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
