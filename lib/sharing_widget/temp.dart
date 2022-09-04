// import 'package:flutter/material.dart';
// import 'package:ubs/custom_widget/search.dart';
// import 'package:ubs/utils/sample_data.dart';
// import 'package:ubs/utils/widget_fun.dart';
// import 'package:ubs/widgets/add_list.dart';
// import 'package:ubs/widgets/categories.dart';

// class HomeScreen extends StatelessWidget {
//   const HomeScreen({super.key});

//   @override
//   Widget build(BuildContext context) {
//     final Size size = MediaQuery.of(context).size;
//     final ThemeData themData = Theme.of(context);

//     return SafeArea(
//       child: Scaffold(
//         body: Container(
//           width: size.width,
//           height: size.height,
//           // padding: const EdgeInsets.only(top: 12),
//           child: CustomScrollView(
//             slivers: <Widget>[
//               SliverAppBar(
//                 backgroundColor: Colors.white,
//                 pinned: false,
//                 floating: true,
//                 actions: [
//                   Column(
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     children: [
//                       Container(
//                         padding: const EdgeInsets.only(top: 5),
//                         child: Row(
//                           children: [
//                             const Icon(
//                               Icons.location_on,
//                               size: iconsSize * 0.7,
//                               color: Colors.black87,
//                             ),
//                             addHorizontalSpace(5),
//                             Text("Location, State Name",
//                                 style: themData.textTheme.headline6),
//                             const Icon(Icons.keyboard_arrow_down,
//                                 size: iconsSize * 0.7),
//                           ],
//                         ),
//                       ),
//                       Padding(
//                         padding: const EdgeInsets.symmetric(
//                             horizontal: 12, vertical: 8),
//                         child: Row(
//                           mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                           children: [
//                             searchBox(
//                               width: size.width * 0.8,
//                             ),
//                             addHorizontalSpace(10),
//                             GestureDetector(
//                               onTap: () {},
//                               child: SizedBox(
//                                   width: size.width * 0.1,
//                                   child: const Icon(
//                                     Icons.notifications_none,
//                                     size: iconsSize * 0.8,
//                                     color: Colors.black87,
//                                   )),
//                             )
//                           ],
//                         ),
//                       ),
//                     ],
//                   )
//                 ],
//               ),
//               SliverList(
//                 delegate: SliverChildListDelegate([
//                   addVerticalSpace(10),
//                   const SizedBox(height: 205, child: Categories()),
//                   addVerticalSpace(10),
//                   AddList()
//                 ]),
//               )
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }





















// import 'package:flutter/material.dart';
// import 'package:sticky_headers/sticky_headers.dart';
// import 'package:ubs/custom_widget/search.dart';
// import 'package:ubs/utils/sample_data.dart';
// import 'package:ubs/utils/widget_fun.dart';
// import 'package:ubs/widgets/add_list.dart';
// import 'package:ubs/widgets/categories.dart';

// class HomeScreen extends StatelessWidget {
//   const HomeScreen({super.key,this.controller,});

//   final ScrollController? controller;
//   @override
//   Widget build(BuildContext context) {
//     final Size size = MediaQuery.of(context).size;
//     final ThemeData themData = Theme.of(context);

//     return SafeArea(
//       child: Scaffold(
//         body: Container(
//           width: size.width,
//           height: size.height,
//           // padding: const EdgeInsets.only(top: 12),
//           child: SingleChildScrollView(
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 StickyHeader(
//                     header: Expanded(
//                       child: Container(
//                         padding: const EdgeInsets.symmetric(
//                             vertical: 8, horizontal: 10),
//                         child: Row(
//                           crossAxisAlignment: CrossAxisAlignment.start,
//                           children: [
//                             const Icon(
//                               Icons.location_on,
//                               size: iconsSize * 0.7,
//                               color: Colors.black87,
//                             ),
//                             addHorizontalSpace(5),
//                             Text("Location, State Name",
//                                 style: themData.textTheme.headline6),
//                             const Icon(Icons.keyboard_arrow_down,
//                                 size: iconsSize * 0.7),
//                           ],
//                         ),
//                       ),
//                     ),
//                     content: SizedBox()),
//                 StickyHeader(
//                     header: 
//                     Padding(
//                       padding: const EdgeInsets.symmetric(
//                           horizontal: 12, vertical: 8),
//                       child: Row(
//                         mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                         children: [
//                           searchBox(
//                             width: size.width * 0.8,
//                           ),
//                           addHorizontalSpace(10),
//                           GestureDetector(
//                             onTap: () {},
//                             child: SizedBox(
//                                 width: size.width * 0.1,
//                                 child: const Icon(
//                                   Icons.notifications_none,
//                                   size: iconsSize * 0.8,
//                                   color: Colors.black87,
//                                 )),
//                           )
//                         ],
//                       ),
//                     ),
//                     content: Column(
//                       children: [
//                         addVerticalSpace(10),
//                         const SizedBox(height: 205, child: Categories()),
//                         addVerticalSpace(10),
//                         AddList()
//                       ],
//                     )),
//               ],
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }

