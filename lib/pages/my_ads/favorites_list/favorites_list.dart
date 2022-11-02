import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:ubs/sharing_widget/widget_fun.dart';
import 'package:ubs/utils/constants.dart';
import 'package:ubs/utils/custom_fun.dart';
import 'package:ubs/utils/text_style.dart';

class FavoritesList extends StatelessWidget {
  const FavoritesList({super.key});

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    // double imgSize = size.width * 0.15;

    return ListView.builder(
      itemCount: 5,
      itemBuilder: (BuildContext context, int index) {
        return Container(
          margin: EdgeInsets.symmetric(vertical: 6.h),
          padding: EdgeInsets.symmetric(vertical: 2.h, horizontal: 30.w),
          decoration: BoxDecoration(
            border: Border(
              bottom: BorderSide(
                width: 0.8,
                color: COLOR_LIGHT_BLACK.withAlpha(50),
              ),
            ),
          ),
          child: Row(children: [
            SizedBox(
              width: 160.sp,
              height: 160.sp,
              child: Image.asset(
                "lib/assets/images/user.png",
                fit: BoxFit.fitWidth,
              ),
              // child: Image.network(
              //   getLink(adsData.pImg1),
              //   fit: BoxFit.fitWidth,
              // ),
            ),
            addHorizontalSpace(25.w),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  // "₹ ${adsData.pPrice.toString()}",
                  "₹ 5,000",
                  style: heading4,
                ),
                Container(
                  margin: EdgeInsets.only(right: 20.sp),
                  // child: Text(adsData.pTitle, style: heading5),
                  child: Text("adsData.pTitle", style: heading5),
                ),
              ],
            ),
            Spacer(),
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
                  ),
                  
            addHorizontalSpace(12),
          ]),
        );

        // return Container(
        //   padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
        //   decoration: const BoxDecoration(
        //     border:
        //         Border(bottom: BorderSide(color: Colors.black87, width: 0.8)),
        //   ),
        //   child: SizedBox(
        //       width: double.infinity,
        //       height: imgSize,
        //       child: Row(
        //         children: [
        //           SizedBox(
        //             height: imgSize,
        //             width: imgSize,
        //             child: Container(
        //               color: Colors.red,
        //             ),
        //             // child: ShowImage(
        //             //   imageUrl: getLink("ad")),
        //           ),
        //           const SizedBox(width: 20),
        //           Column(
        //             mainAxisAlignment: MainAxisAlignment.center,
        //             crossAxisAlignment: CrossAxisAlignment.start,
        //             children: [
        //               Text(
        //                 "\$ 5,000",
        //                 style: labelText,
        //               ),
        //               Text(
        //                 "Iphone 11 pro 2015",
        //                 style: textfield,
        //               ),
        //             ],
        //           ),
        //           Spacer(),
        //           Icon(Icons.favorite)
        //         ],
        //       )),
        // );
      },
    );
  }
}
