import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:ubs/model/ads_post.dart';
import 'package:ubs/pages/PostDetails/post_details.dart';
import 'package:ubs/sharing_widget/widget_fun.dart';
import 'package:ubs/utils/constants.dart';
import 'package:ubs/utils/custom_fun.dart';

class AdsList extends StatelessWidget {
  final List<AdsPost> adsPost;
  const AdsList({Key? key, required this.adsPost}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final ThemeData themData = Theme.of(context);
    // var uri = API_URL + "/" + adsPost.catImg.replaceAll("\\", "/");

    return AlignedGridView.count(
      primary: false,
      shrinkWrap: true,
      crossAxisCount: 2,
      // scrollDirection: Axis.vertical,
      itemCount: adsPost.length,
      itemBuilder: (BuildContext context, int index) {
        return GestureDetector(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => PostDetails(
                  // postData: postList[index],
                  adsPostData: adsPost[index],
                ),
              ),
            );
          },
          child: Container(
            margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 5),
            padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 12),
            decoration: BoxDecoration(
                color: Colors.white,
                border: Border.all(width: 2, color: Colors.grey.shade400),
                borderRadius: BorderRadius.circular(10)),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Stack(
                  children: [
                    // --- For Cover Image
                    Container(
                      alignment: Alignment.center,
                      height: 140,
                      child: Hero(
                        tag: "post${adsPost[index].pId}",
                        transitionOnUserGestures: true,
                        child: Image.network(
                          getLink(adsPost[index].pImg1),
                          // color: Colors.white,
                          // colorBlendMode: BlendMode.color,
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    // ----- for features batch
                    Positioned(
                      top: 10,
                      left: 0,
                      child: adsPost[index].pImg3 == null
                          ? const SizedBox()
                          : featuredTag(),
                    ),
                    // ------ for favorite icon
                    Positioned(
                        right: 5,
                        top: 5,
                        child: Container(
                          padding: const EdgeInsets.all(5),
                          decoration: favoriteBorder,
                          child: Icon(
                            // AddLists[index]. ["Favorite"] == "yes"
                            adsPost[index].pImg3 != null
                                ? Icons.favorite
                                : Icons.favorite_border,
                            size: 25,
                            color: adsPost[index].pImg3 != null
                                ? Colors.red
                                : Colors.black54,
                          ),
                        ))
                  ],
                ),
                addVerticalSpace(8),
                SizedBox(
                  height: 25,
                  // -----for Name product
                  child: Text(
                    "₹ ${adsPost[index].pPrice.toString()}",
                    style: themData.textTheme.headline5,
                  ),
                ),
                SizedBox(
                  height: 30,
                  // -----for Name product
                  child: Text(
                    adsPost[index].pTitle,
                    style: themData.textTheme.titleSmall,
                    overflow: TextOverflow.ellipsis,
                    softWrap: false,
                    maxLines: 1,
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    const Icon(
                      Icons.location_on_outlined,
                      size: 15,
                    ),
                    addHorizontalSpace(5),
                    Text(
                      // AddLists[index]["Location"],
                      adsPost[index].pLocation,
                      style: themData.textTheme.subtitle1,
                      overflow: TextOverflow.ellipsis,
                      softWrap: false,
                      maxLines: 1,
                    )
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}


// GridView.builder(
        //   padding: EdgeInsets.symmetric(horizontal: 10),
        //   shrinkWrap: true,
        //   physics: const NeverScrollableScrollPhysics(),
        //   gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        //     crossAxisCount: 2,
        //   ),
        //   itemCount: postList.length,
        //   itemBuilder: (BuildContext context, int index) {
        //     return GestureDetector(
        //       onTap: () {
        //         Navigator.push(
        //             context,
        //             MaterialPageRoute(
        //                 builder: (context) => PostDetails(
        //                       postData: postList[index],
        //                     )));
        //       },
        //       child: Container(
        //         margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 5),
        //         padding:
        //             const EdgeInsets.symmetric(vertical: 8, horizontal: 12),
        //         decoration: BoxDecoration(
        //             color: Colors.white,
        //             border: Border.all(width: 2, color: Colors.grey.shade400),
        //             borderRadius: BorderRadius.circular(10)),
        //         child: Column(
        //           crossAxisAlignment: CrossAxisAlignment.start,
        //           children: [
        //             Stack(
        //               children: [
        //                 // --- For Cover Image
        //                 Container(
        //                   alignment: Alignment.center,
        //                   height: 120,
        //                   child: Hero(
        //                     tag: "post${postList[index].id}",
        //                     transitionOnUserGestures: true,
        //                     child: Image.asset(
        //                       // AddLists[index]["image1"],
        //                       postList[index].image1,
        //                       fit: BoxFit.cover,
        //                     ),
        //                   ),
        //                 ),
        //                 // ----- for features batch
        //                 Positioned(
        //                     top: 10,
        //                     left: 0,
        //                     child: postList[index].features == "no"
        //                         ? const SizedBox()
        //                         : Container(
        //                             color: Colors.amber.shade400,
        //                             padding: const EdgeInsets.symmetric(
        //                                 vertical: 3, horizontal: 6),
        //                             child: const Text(
        //                               "Features",
        //                               style: TextStyle(
        //                                   fontSize: 10,
        //                                   letterSpacing: 0.8,
        //                                   color: Colors.black),
        //                             ),
        //                           )),
        //                 // ------ for favorite icon
        //                 Positioned(
        //                     right: 5,
        //                     top: 5,
        //                     child: Container(
        //                       padding: const EdgeInsets.all(5),
        //                       decoration: favoriteBorder,
        //                       child: Icon(
        //                         // AddLists[index]. ["Favorite"] == "yes"
        //                         postList[index].favorite == "yes"
        //                             ? Icons.favorite
        //                             : Icons.favorite_border,
        //                         size: 25,
        //                         color: postList[index].favorite == "yes"
        //                             ? Colors.red
        //                             : Colors.black54,
        //                       ),
        //                     ))
        //               ],
        //             ),
        //             addVerticalSpace(10),
        //             SizedBox(
        //               height: 35,
        //               // -----for Name product
        //               child: Text(
        //                 //  AddLists[index]["Amount"],
        //                 "& ${postList[index].amount}",
        //                 style: themData.textTheme.headline5,

        //               ),
        //             ),
        //             SizedBox(
        //               height: 35,
        //               // -----for Name product
        //               child: Text(
        //                 // AddLists[index]["Name"],
        //                 postList[index].name,
        //                 style: themData.textTheme.titleSmall,
        //                 overflow: TextOverflow.ellipsis,
        //                 softWrap: false,
        //                 maxLines: 1,
        //               ),
        //             ),
        //             Row(
        //               mainAxisAlignment: MainAxisAlignment.start,
        //               children: [
        //                 const Icon(
        //                   Icons.location_on_outlined,
        //                   size: 15,
        //                 ),
        //                 addHorizontalSpace(5),
        //                 Text(
        //                   // AddLists[index]["Location"],
        //                   postList[index].location,
        //                   style: themData.textTheme.subtitle1,
        //                   overflow: TextOverflow.ellipsis,
        //                   softWrap: false,
        //                   maxLines: 1,
        //                 )
        //               ],
        //             ),
        //           ],
        //         ),
        //       ),
        //     );
        //   },
        // ),
