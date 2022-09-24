// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'package:flutter/material.dart';
import 'package:ubs/pages/home/widget/categories_bar.dart';

import 'package:ubs/utils/constants.dart';
import 'package:ubs/sharing_widget/widget_fun.dart';

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
      decoration: const BoxDecoration(
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              offset: Offset(1, 1),
              blurStyle: BlurStyle.normal,
              blurRadius: 5,
              color: Color(0x6E000000),
            )
          ],
          border: Border(bottom: BorderSide(color: Colors.black54))),
      padding: const EdgeInsets.only(left: 12, top: 10, bottom: 10, right: 12),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Container(
            width: width * 0.8,
            padding: const EdgeInsets.all(5),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8),
                border: Border.all(color: COLOR_GREY, width: 2)),
            child: Row(
              children: [
                IconButton(
                  padding: EdgeInsets.zero,
                  constraints: const BoxConstraints(),
                  onPressed: () {},
                  icon: const Icon(
                    Icons.search_rounded,
                    size: 25,
                    color: Colors.grey,
                  ),
                ),
                addHorizontalSpace(8),
                Expanded(
                  child: Text("Find Car, Mobile Phone, and more sadasd adsasd ",
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
