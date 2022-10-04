import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:ubs/model/ads_post.dart';
import 'package:ubs/pages/PostDetails/post_details.dart';
import 'package:ubs/sharing_widget/widget_fun.dart';
import 'package:ubs/utils/constants.dart';
import 'package:ubs/utils/custom_fun.dart';
import 'package:ubs/utils/text_style.dart';

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
        margin: EdgeInsets.symmetric(vertical: 6.h),
        padding: EdgeInsets.symmetric(vertical: 20.h),
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
          addHorizontalSpace(25.w),
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
                          style: TextStyle(
                              fontSize: 22.sp, fontWeight: FontWeight.w700),
                        ),
                      ],
                    ),
                    Container(
                      padding: EdgeInsets.all(5.sp),
                      child: Icon(
                        // postData.favorite == "no"?
                        Icons.favorite_border,
                        // : Icons.favorite,
                        size: 50.sp,
                        color:
                            // postData.favorite == "no" ?
                            Colors.black,
                        // : Colors.red,
                      ),
                    )
                  ],
                ),
                Container(
                  margin: EdgeInsets.only(right: 20.sp),
                  child: Text(adsData.pTitle),
                ),
                Row(
                  children: [
                     Icon(Icons.location_on,size: 38.sp),
                    Text(
                      adsData.pLocation,
                      style: heading5,
                    ),
                    const Expanded(child: SizedBox()),
                    Text(
                      DateFormat("dd-MMM-yy").format(adsData.pDate!).toString(),
                      style: heading4,
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
