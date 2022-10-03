import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import 'package:ubs/model/ads_post.dart';
import 'package:ubs/sharing_widget/widget_fun.dart';
import 'package:ubs/utils/constants.dart';
import 'package:ubs/utils/text_style.dart';

class TitleBar extends StatelessWidget {
  final AdsPost adsPostData;
  const TitleBar({super.key, required this.adsPostData});

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
              Padding(
                  padding: EdgeInsets.only(right: 15.w),
                  child: Container(
                    padding: const EdgeInsets.all(5),
                    decoration: favoriteBorder,
                    child: Icon(
                      // postData.favorite == "no"?
                      Icons.favorite_border,
                      size: 60.sp,
                      color:
                          // postData.favorite == "no" ?
                          Colors.black,
                      // : Colors.red,
                    ),
                  ),
                  )
            ],
          ),
          addVerticalSpace(8.h),
          Text(
            // "Sub Title About post and more details",
            adsPostData.pTitle,
            style: heading4,
          ),
          addVerticalSpace(8.h),
          // Text(
          //   // "Sub Title About post and more details",
          //   adsPostData.,
          //   style: textTheme.headline6,
          // ),
          addVerticalSpace(8.h),
          Row(
            children: [
              Icon(Icons.location_on, size: 55.sp,),
              Text(
                // "Location name about post",
                adsPostData.pLocation,
                style: heading6,
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
