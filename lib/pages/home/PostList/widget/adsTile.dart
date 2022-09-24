import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:ubs/model/ads_post.dart';
import 'package:ubs/pages/PostDetails/post_details.dart';
import 'package:ubs/sharing_widget/widget_fun.dart';
import 'package:ubs/utils/constants.dart';
import 'package:ubs/utils/custom_fun.dart';

class AdsTitle extends StatelessWidget {
  final TextTheme textTheme;
  final double wSize;
  final AdsPost adsData;
  const AdsTitle(
      {super.key,
      required this.textTheme,
      required this.wSize,
      required this.adsData});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => PostDetails(
              // postData: postList[index],
              adsPostData: adsData,
            ),
          ),
        );
      },
      child: Container(
        margin: EdgeInsets.symmetric(vertical: 5),
        padding: EdgeInsets.symmetric(vertical: 12),
        decoration: BoxDecoration(
          border: Border(
            bottom: BorderSide(
              width: 0.8,
              color: COLOR_LIGHT_BLACK.withAlpha(50),
            ),
            top: BorderSide(
              width: 0.8,
              color: COLOR_LIGHT_BLACK.withAlpha(50),
            ),
          ),
        ),
        child: Row(children: [
          SizedBox(
            width: wSize * 0.25,
            height: wSize * 0.20,
            child: Image.network(
              getLink(adsData.pImg1),
              fit: BoxFit.fitWidth,
            ),
          ),
          addHorizontalSpace(12),
          Expanded(
            child: Column(
              // mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      children: [
                        featuredTag(),
                        Text(
                          adsData.pPrice.toString(),
                          style: const TextStyle(
                              fontSize: 18, fontWeight: FontWeight.w700),
                        ),
                      ],
                    ),
                    Container(
                      padding: const EdgeInsets.all(5),
                      child: const Icon(
                        // postData.favorite == "no"?
                        Icons.favorite_border,
                        // : Icons.favorite,
                        size: 30,
                        color:
                            // postData.favorite == "no" ?
                            Colors.black,
                        // : Colors.red,
                      ),
                    )
                  ],
                ),
                Container(
                  margin: EdgeInsets.only(right: 20),
                  child: Text(adsData.pTitle),
                ),
                Row(
                  children: [
                    const Icon(Icons.location_on),
                    Text(
                      adsData.pLocation,
                      style: textTheme.headline6,
                    ),
                    const Expanded(child: SizedBox()),
                    Text(
                      DateFormat("dd-MMM-yy").format(adsData.pDate!).toString(),
                      style: textTheme.headline4,
                    )
                  ],
                )
              ],
            ),
          ),
          addHorizontalSpace(12),
        ]),
      ),
    );
  }
}
