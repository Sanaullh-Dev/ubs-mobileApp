import 'package:flutter/material.dart';
import 'package:ubs/sharing_widget/widget_fun.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:ubs/utils/text_style.dart';

class LocationBar extends StatelessWidget {
  const LocationBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Icon(
          Icons.location_on,
          size: 50.sp,
          color: Colors.black87,
        ),
        addHorizontalSpace(5),
        Text("Location, State Name", style: heading4),
        Icon(Icons.keyboard_arrow_down, size: 60.sp, color: Colors.black87),
      ],
    );
  }
}



//////////////////////////////////////
// import 'package:flutter/material.dart';
// import 'package:ubs/pages/home/widget/categories_bar.dart';
// import 'package:ubs/sharing_widget/widget_fun.dart';
// import 'package:ubs/utils/constants.dart';

// class LocationBar extends StatelessWidget {
//   final TextTheme textTheme;

//   const LocationBar({Key? key, required this.textTheme}) : super(key: key);

//   @override
//   Widget build(BuildContext context) {

//     return SliverAppBar(
//             backgroundColor: COLOR_PRIMARY,
//             floating: true,
//             toolbarHeight: 46,
//             elevation: 0,
//             actions: [
//               Expanded(
//                 child: Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     //location bar
//                     Container(
//                       padding:
//                           const EdgeInsets.only(left: 8, top: 10, bottom: 0),
//                       child: Row(
//                         children: [
//                           const Icon(
//                             Icons.location_on,
//                             size: iconsSize * 0.7,
//                             color: Colors.black87,
//                           ),
//                           addHorizontalSpace(5),
//                           Text("Location, State Name",
//                               style: textTheme.headline6),
//                           const Icon(Icons.keyboard_arrow_down,
//                               size: iconsSize * 0.7, color: Colors.black87),
//                         ],
//                       ),
//                     ),
//                   ],
//                 ),
//               ),
//             ],
//           );
//   }
// }
