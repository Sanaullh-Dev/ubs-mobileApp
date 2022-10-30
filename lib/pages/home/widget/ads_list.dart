import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:ubs/model/ads_post.dart';
import 'package:ubs/model/post_reaction.dart';
import 'package:ubs/model/user_login.dart';
import 'package:ubs/pages/PostDetails/post_details.dart';
import 'package:ubs/services/remote_services.dart';
import 'package:ubs/sharing_widget/show_image.dart';
import 'package:ubs/sharing_widget/widget_fun.dart';
import 'package:ubs/utils/constants.dart';
import 'package:ubs/utils/custom_fun.dart';
import 'package:ubs/utils/text_style.dart';

class AdsList extends StatelessWidget {
  final UserLogin userData;
  final List<AdsPost> adsPost;
  const AdsList({Key? key, required this.adsPost, required this.userData})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    
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
                  userData: userData,
                  adsPostData: adsPost[index],
                ),
              ),
            );
          },
          child: Container(
            margin: EdgeInsets.symmetric(vertical: 15.h, horizontal: 13.w),
            padding: EdgeInsets.symmetric(vertical: 15.h, horizontal: 18.w),
            decoration: BoxDecoration(
                color: Colors.white,
                border: Border.all(width: 2, color: Colors.grey.shade400),
                borderRadius: BorderRadius.circular(20.r)),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Stack(
                  children: [
                    // --- For Cover Image
                    Container(
                      alignment: Alignment.center,
                      height: 230.sp,
                      child: Hero(
                          tag: "post${adsPost[index].pId}",
                          transitionOnUserGestures: true,
                          child: ShowImage(
                              imageUrl: getLink(adsPost[index].pImg1))),
                    ),
                    // ----- for features batch
                    // Positioned(
                    //   top: 15.h,
                    //   left: 0,
                    //   child: adsPost[index].pImg3 == null
                    //       ? const SizedBox()
                    //       : featuredTag(),
                    // ),
                    // ------ for favorite icon
                    Positioned(
                      right: 5.w,
                      top: 5.h,
                      child: GestureDetector(
                        onTap: () {
                          PostReaction postReaction = PostReaction(
                            uid: userData.userId, pid:  adsPost[index].pId!, 
                            pFavorite: 1, pView: 0);
                          RemoteServices.addPostReaction(postReaction);
                        },
                        child: Container(
                          padding: EdgeInsets.all(10.w),
                          decoration: favoriteBorder,
                          child: Icon(
                            adsPost[index].pFavorite == 1
                                ? Icons.favorite
                                : Icons.favorite_border,
                            size: 40.sp,
                            color: adsPost[index].pFavorite == 1
                                ? Colors.red
                                : Colors.black54,
                          ),
                        ),
                      ),
                    )
                  ],
                ),
                // addVerticalSpace(15.h),
                SizedBox(
                  height: 50.h,
                  // -----for Name product
                  child: Text(
                    "₹ ${adsPost[index].pPrice.toString()}",
                    style: heading3,
                  ),
                ),
                SizedBox(
                  height: 50.h,
                  // -----for Name product
                  child: Text(
                    adsPost[index].pTitle,
                    overflow: TextOverflow.ellipsis,
                    softWrap: false,
                    maxLines: 1,
                    style:
                        TextStyle(fontWeight: FontWeight.w400, fontSize: 30.sp),
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Icon(
                      Icons.location_on_outlined,
                      size: 35.sp,
                    ),
                    addHorizontalSpace(10.w),
                    Text(
                      // AddLists[index]["Location"],
                      adsPost[index].pLocation,
                      overflow: TextOverflow.ellipsis,
                      softWrap: false,
                      maxLines: 1,
                      style: TextStyle(
                          color: COLOR_BLACK,
                          fontWeight: FontWeight.w400,
                          fontSize: 32.sp),
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
