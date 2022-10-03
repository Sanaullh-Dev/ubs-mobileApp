import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ubs/pages/SearchAds/search_ads.dart';
import 'package:ubs/utils/constants.dart';
import 'package:ubs/sharing_widget/widget_fun.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class SearchBar extends StatelessWidget {
  final double width;
  final TextTheme textTheme;
  const SearchBar({
    Key? key,
    required this.width,
    required this.textTheme,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // final ThemeData themData = Theme.of(context);

    return GestureDetector(
      onTap: (){
        Get.to(SearchAds());
      },
      child: Container(
        // width: width,
        height: 110.h,
        decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              offset: const Offset(1, 1),
              blurStyle: BlurStyle.normal,
              blurRadius: 100.r,
              color: const Color(0x6E000000),
            )
          ],
          border: const Border(
            bottom: BorderSide(color: Colors.black54),
          ),
        ),
        alignment: Alignment.centerRight,
        padding: EdgeInsets.symmetric(horizontal: 15.w, vertical: 15.h),
        // padding:
        //     EdgeInsets.only(left: 20.w, top: 10.h, bottom: 10.h, right: 12.w),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Container(
              width: 750.w,
              height: 80.h,
              padding: EdgeInsets.all(12.h),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(50.r),
                  border: Border.all(color: COLOR_GREY, width: 2)),
              child: Row(
                children: [
                  IconButton(
                    padding: EdgeInsets.zero,
                    constraints: const BoxConstraints(),
                    onPressed: () {},
                    icon: Icon(
                      Icons.search_rounded,
                      size: 45.sp,
                      color: Colors.grey,
                    ),
                  ),
                  addHorizontalSpace(8),
                  Expanded(
                    child: Text("Find Car, Mobile Phone, and more ",
                        overflow: TextOverflow.ellipsis,
                        softWrap: false,
                        maxLines: 1,
                        style: TextStyle(
                            color: COLOR_GREY,
                            fontWeight: FontWeight.w400,
                            fontSize: 35.sp)),
                  ),
                ],
              ),
            ),
            addHorizontalSpace(10),
            GestureDetector(
              onTap: () {},
              child: SizedBox(
                  width: width * 0.1,
                  child: Icon(
                    Icons.notifications_none,
                    size: 60.sp,
                    color: Colors.black87,
                  )),
            )
          ],
        ),
      ),
    );
  }
}

// Container(
//       width: width,
//       padding: EdgeInsets.all(5),
//       decoration: BoxDecoration(
//           borderRadius: BorderRadius.circular(8),
//           border: Border.all(color: COLOR_GREY, width: 2)),
//       child: Row(
//         children: [
//           Icon(
//             Icons.search_rounded,
//             size: 25,
//             color: Colors.grey,
//           ),
//           addHorizontalSpace(8),
//           Expanded(
//             child: Text("Find Car, Mobile Phone, and more sadasd adsasd ",
//                 overflow: TextOverflow.ellipsis,
//                 softWrap: false,
//                 maxLines: 1,
//                 style: themData.textTheme.caption),
//           ),
//         ],
//       ),
//     );
  



// NotificationListener<UserScrollNotification>(
//   onNotification: (notification) {
//     final ScrollDirection direction = notification.direction;
//     if (direction == ScrollDirection.forward)
//       isVisible = false;
//     else if (direction == ScrollDirection.reverse) isVisible = true;

//     return true;
//   },
