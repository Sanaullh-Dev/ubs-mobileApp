import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ubs/pages/search_ads/search_ads.dart';
import 'package:ubs/sharing_widget/widget_fun.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:ubs/utils/constants.dart';

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

    return Container(
      height: 120.h,
      padding: EdgeInsets.symmetric(horizontal: 15.sp, vertical: 30.sp),
      alignment: Alignment.centerRight,
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
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          addHorizontalSpace(10),
          Expanded(
            child: TextField(
                onTap: () {
                  Get.to(const SearchAds());
                },
                readOnly: true,
                style: TextStyle(
                    color: COLOR_BLACK, fontSize: 31.sp, fontFamily: "Poppins"),
                controller: TextEditingController(
                    text: "Find Car, Mobile Phone, and more "),
                decoration: InputDecoration(
                  contentPadding: const EdgeInsets.symmetric(vertical: 0 ,horizontal: 5),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(50.r),
                  borderSide: BorderSide(
                      color: COLOR_PRIMARY, width: 3.sp),
                  ),
                  prefixIcon: IconButton(
                    onPressed: () {},
                    icon: Icon(
                      Icons.search,
                      size: 50.sp,
                      color: Colors.black,
                    ),
                  ),
                )),
          ),
          addHorizontalSpace(20),
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
    );
  }

  OutlineInputBorder textBoxBorder() {
    return OutlineInputBorder(
      borderRadius: BorderRadius.circular(100),
      borderSide: BorderSide(width: 5, color: COLOR_PRIMARY),
    );
  }
}

// Container(
//               width: 750.w,
//               height: 80.h,
//               padding: EdgeInsets.all(12.h),
//               decoration: BoxDecoration(
//                   borderRadius: BorderRadius.circular(50.r),
//                   border: Border.all(color: COLOR_GREY, width: 2)),
//               child: Row(
//                 children: [
//                   IconButton(
//                     padding: EdgeInsets.zero,
//                     constraints: const BoxConstraints(),
//                     onPressed: () {},
//                     icon: Icon(
//                       Icons.search_rounded,
//                       size: 45.sp,
//                       color: Colors.grey,
//                     ),
//                   ),
//                   addHorizontalSpace(8),
//                   Expanded(
//                     child: Text("Find Car, Mobile Phone, and more ",
//                         overflow: TextOverflow.ellipsis,
//                         softWrap: false,
//                         maxLines: 1,
//                         style: TextStyle(
//                             color: COLOR_GREY,
//                             fontWeight: FontWeight.w400,
//                             fontSize: 35.sp)),
//                   ),
//                 ],
//               ),
//             ),
            
