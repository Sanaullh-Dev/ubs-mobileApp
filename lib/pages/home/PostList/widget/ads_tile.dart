import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:ubs/model/ads_post.dart';
import 'package:ubs/model/user_login.dart';
import 'package:ubs/sharing_widget/widget_fun.dart';
import 'package:ubs/utils/constants.dart';
import 'package:ubs/utils/custom_fun.dart';
import 'package:ubs/utils/text_style.dart';

class AdsTile extends StatelessWidget {
  final UserLogin userData;
  final AdsPost adsData;
  VoidCallback onPress;

  AdsTile(
      {super.key,
      required this.adsData,
      required this.userData,
      required this.onPress});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPress,
      child: Container(
        margin: EdgeInsets.symmetric(vertical: 6.h),
        padding: EdgeInsets.symmetric(vertical: 20.h),
        decoration: BoxDecoration(
          border: Border(
            bottom: BorderSide(
              width: 0.8,
              color: lightBlackColor.withAlpha(50),
            ),
            top: BorderSide(
              width: 0.8,
              color: lightBlackColor.withAlpha(50),
            ),
          ),
        ),
        child: Row(children: [
          SizedBox(
            width: 180.sp,
            height: 180.sp,
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
                        // featuredTag(),
                        Text(
                          "₹ ${adsData.pPrice.toString()}",
                          style: heading4,
                        ),
                      ],
                    ),
                    Container(
                      padding: EdgeInsets.all(5.sp),
                      child: Icon(
                        adsData.pFavorite == 1
                            ? Icons.favorite
                            : Icons.favorite_border,
                        size: 50.sp,
                        color:
                            adsData.pFavorite == 1 ? Colors.red : Colors.black,
                        // : Colors.red,
                      ),
                    )
                  ],
                ),
                Container(
                  margin: EdgeInsets.only(right: 20.sp),
                  child: Text(adsData.pTitle, style: heading5),
                ),
                Row(
                  children: [
                    Icon(Icons.location_on, size: 38.sp),
                    Text(
                      adsData.pLocation,
                      style: titleLabel,
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
