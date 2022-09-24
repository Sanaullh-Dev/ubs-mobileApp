// SlidingUpPanel(
//   // maxHeight:
//   //     MediaQuery.of(context).viewInsets.bottom > 0 ? 110 : 290,
//   maxHeight: isTyping == true ? maxHeight : 290,
//   minHeight: 60,
//   defaultPanelState: PanelState.OPEN,
//   // color: Colors.red,
//   controller: _penelController,
//   header: Container(
//     padding: EdgeInsets.symmetric(horizontal: 15),
//     width: size.width,
//     height: 60,
//     color: Colors.white70,
//     child: Stack(
//       children: [
        // Align(
        //   alignment: Alignment.topCenter,
        //   child: Container(
        //     margin: const EdgeInsets.only(top: 8),
        //     width: 60,
        //     height: 5,
        //     color: Colors.blueGrey.shade300,
        //   ),
        // ),
//         Padding(
//           padding: const EdgeInsets.only(top: 20),
//           child: TabBar(
//             controller: _tabController,
//             indicatorWeight: 3,
//             indicatorColor: COLOR_INDICATOR,
//             labelPadding: EdgeInsets.only(bottom: 15),
//             tabs: [
//               Row(
//                 mainAxisAlignment: MainAxisAlignment.center,
//                 children: [
//                   Icon(
//                     FontAwesomeIcons.message,
//                     size: 25,
//                   ),
//                   addHorizontalSpace(12),
//                   Text(
//                     "Chart",
//                     style: TextStyle(fontSize: 16),
//                   ),
//                 ],
//               ),
//               Row(
//                 mainAxisAlignment: MainAxisAlignment.center,
//                 children: [
//                   Icon(
//                     FontAwesomeIcons.handPointer,
//                     size: 25,
//                   ),
//                   addHorizontalSpace(12),
//                   Text(
//                     "Make Offer",
//                     style: TextStyle(fontSize: 16),
//                   ),
//                 ],
//               )
//             ],
//           ),
//         ),
//       ],
//     ),
//   ),
//   panel: 
// Container(
//     margin: EdgeInsets.only(top: 60),
//     child: TabBarView(
//       controller: _tabController,
//       children: [
//         Stack(
//           children: [
//             Align(
//               alignment: Alignment.bottomCenter,
//               child: Card(
//                 margin: EdgeInsets.only(
//                     left: 2,
//                     right: 2,
//                     bottom: MediaQuery.of(context)
//                                 .viewInsets
//                                 .bottom >
//                             0
//                         ? 0
//                         : 8),
//                 shape: RoundedRectangleBorder(
//                     borderRadius: BorderRadius.circular(0)),
//                 child: TextField(
//                   onTap: () {
//                     isTyping = true;
//                     setState(() {});
//                   },
//                   onChanged: (String e) {
//                     setState(() {
//                       double numLines =
//                           '\n'.allMatches(e).length + 1;
//                       if (numLines >= 1 && numLines < 5) {
//                         maxHeight = 90 + (25 * numLines);
//                       }
//                     });
//                   },
//                   textAlignVertical: TextAlignVertical.center,
//                   keyboardType: TextInputType.multiline,
//                   maxLines: 5,
//                   minLines: 1,
//                   style: const TextStyle(
//                     fontSize: 20,
//                   ),
//                   decoration: const InputDecoration(
//                     hintText: "Type a message",
//                     border: InputBorder.none,
//                     prefixIcon: Padding(
//                       padding: EdgeInsets.only(right: 8),
//                       child: Icon(
//                         FontAwesomeIcons.paperclip,
//                         color: COLOR_INDICATOR,
//                         size: 25,
//                       ),
//                     ),
//                     suffixIcon:
//                         Icon(FontAwesomeIcons.microphone),
//                     hintStyle: TextStyle(
//                       fontSize: 20,
//                     ),
//                   ),
//                 ),
//               ),
//             ),
//             Visibility(
//               // visible: MediaQuery.of(context).viewInsets.bottom > 0 ? true : false,
//               visible: !isTyping,
//               child: Wrap(
//                 children: [
//                   Text(
//                     "Is it available?",
//                   )
//                 ],
//               ),
//             )
//           ],
//         ),
//         SizedBox(
//           height: 50,
//         )
//       ],
//     ),
//   ),
// 
// ),
