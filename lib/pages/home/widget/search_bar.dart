import 'package:flutter/material.dart';
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

    return Container(
      // width: width,
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
      padding: EdgeInsets.only(left: 20.w, top: 15.h, bottom: 15.h, right: 12.w),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Container(
            width: 750.w,
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
                    size: 38.sp,
                    color: Colors.grey,
                  ),
                ),
                addHorizontalSpace(8),
                Expanded(
                  child: Text("Find Car, Mobile Phone, and more ",
                      overflow: TextOverflow.ellipsis,
                      softWrap: false,
                      maxLines: 1,
                      style: textTheme.caption),
                ),
              ],
            ),
          ),
          addHorizontalSpace(10),
          GestureDetector(
            onTap: () {},
            child: SizedBox(
                width: width * 0.1,
                child: const Icon(
                  Icons.notifications_none,
                  size: 40 * 0.8,
                  color: Colors.black87,
                )),
          )
        ],
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
