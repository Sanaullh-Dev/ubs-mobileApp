import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:ubs/pages/searchAds/controller/search_controller.dart';
import 'package:ubs/pages/home/controller/home_controller.dart';
import 'package:ubs/utils/constants.dart';
import 'package:ubs/utils/text_style.dart';

class SearchAds extends StatefulWidget {
  const SearchAds({super.key});

  @override
  State<SearchAds> createState() => _SearchAdsState();
}

class _SearchAdsState extends State<SearchAds> {
  Rx<bool> isTyping = false.obs;
  List<String> keywordList = [];
  TextEditingController searchTextCont = TextEditingController();
  final SearchController searchController = Get.find<SearchController>();
  final HomeController homeCont = Get.find<HomeController>();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      body: Obx(() => Column(
            children: [
              Padding(
                padding: EdgeInsets.all(40.sp),
                child: SizedBox(
                  height: 100.sp,
                  child: Row(
                    children: [
                      // Search Box
                      Expanded(
                        child: SizedBox(
                          height: 100.sp,
                          child: searchTextBox(),
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          searchController.searchWord.value = searchTextCont.text;
                          searchController
                              .fetchKeywordWiseAds(searchTextCont.text);
                          homeCont.typeList.value = "keywordList";
                          Navigator.of(context).pushNamedAndRemoveUntil(
                              '/', (Route<dynamic> route) => false);
                        },
                        child: Container(
                            height: 100.sp,
                            padding: EdgeInsets.symmetric(horizontal: 20.sp),
                            decoration: BoxDecoration(
                                color: Colors.blueGrey[800],
                                borderRadius: const BorderRadius.only(
                                  topRight: Radius.circular(5),
                                  bottomRight: Radius.circular(5),
                                )),
                            child: Icon(
                              Icons.search,
                              size: 48.sp,
                              color: Colors.white,
                            )),
                      )
                    ],
                  ),
                ),
              ),
              const Divider(),
              Expanded(
                child: ListView.builder(
                  itemCount: searchController.keywordList.length,
                  itemBuilder: (BuildContext context, int index) {
                    return Column(
                      children: [
                        ListTile(
                          minLeadingWidth: 15.sp,
                          leading: const Icon(
                            Icons.search,
                            color: Colors.black,
                          ),
                          title: Text(searchController.keywordList.value[index],
                              style: heading5),
                          subtitle: Text("from All Category", style: heading6),
                          trailing: IconButton(
                            icon: Icon(Icons.close),
                            onPressed: () {
                              searchController.keywordList.removeAt(index);
                            },
                            color: Colors.black,
                          ),
                          onTap: () {
                            searchController.searchWord.value = searchController.keywordList.value[index];
                            searchController.fetchKeywordWiseAds(
                                searchController.keywordList.value[index]);
                            homeCont.typeList.value = "keywordList";
                            Navigator.of(context).pushNamedAndRemoveUntil(
                                '/', (Route<dynamic> route) => false);
                          },
                        ),
                        const Divider()
                      ],
                    );
                  },
                ),
              ),
            ],
          )),
    ));
  }

  Widget searchTextBox() {
    return TextFormField(
      controller: searchTextCont,
      autofocus: true,
      maxLines: 1,
      maxLength: 35,
      // enableSuggestions: false,
      textAlignVertical: TextAlignVertical.center,
      onChanged: (val) {
        isTyping.value = val == "" ? false : true;
        if (val != "") {
          searchController.fetchAdsWiseKeyword(val);
        }
      },
      style: TextStyle(
          color: Colors.black, fontSize: 35.sp, fontFamily: "Poppins"),
      decoration: InputDecoration(
        counterText: "",
        contentPadding: EdgeInsets.symmetric(vertical: 25.sp, horizontal: 20.sp),
        isDense: true,
        border: textBoxBorder(),
        prefixIcon: IconButton(
          onPressed: () => Get.back(),
          icon: Icon(
            Icons.arrow_back,
            size: 55.sp,
            color: Colors.black,
          ),
        ),
        suffixIcon: isTyping.value == true
            ? IconButton(
                color: Colors.black,
                icon: Icon(Icons.close, size: 60.sp),
                onPressed: () {
                  searchTextCont.text = "";
                  isTyping.value = false;
                },
              )
            : const SizedBox(),
        focusedBorder: textBoxBorder(),
      ),
    );
  }
}

textBoxBorder() {
  return OutlineInputBorder(
    borderRadius: BorderRadius.only(
      topLeft: Radius.circular(15.r),
      bottomLeft: Radius.circular(15.r),
    ),
    borderSide: BorderSide(width: 2, color: Colors.blueGrey.shade800),
  );
}
// Padding(
  //   padding: EdgeInsets.symmetric(horizontal: 20.sp),
  //   child: 
  //   Row(
  //     crossAxisAlignment: CrossAxisAlignment.center,
  //     children: [
  //       Expanded(
  //         child: Container(
  //           margin: EdgeInsets.symmetric(vertical: 15.sp),
  //           // padding: EdgeInsets.symmetric(vertical: 10.sp),
  //           height: 90.sp,
  //           padding: EdgeInsets.zero,
  //           decoration: BoxDecoration(
  //               color: Colors.white,
  //               border: Border.all(
  //                   width: 2,
  //                   color: isTyping.value == true
  //                       ? COLOR_PRIMARY
  //                       : COLOR_BLACK),
  //               borderRadius: const BorderRadius.only(
  //                   topLeft: Radius.circular(10.0),
  //                   bottomLeft: Radius.circular(10.0))),
  //           child: TextField(
  //             // controller: searchTextCont,
  //             // maxLines: 1,
  //             // textAlignVertical: TextAlignVertical.center,
  //             // onChanged: (val) {
  //             //   isTyping.value = val == "" ? false : true;
  //             //   if (val == "") {
  //             //     searchController.fetchAdsWiseKeyword(val);
  //             //   }
  //             // },
  //             // style: TextStyle(
  //             //     color: Colors.black,
  //             //     fontSize: 35.sp,
  //             //     fontFamily: "Poppins"),

  //             decoration: InputDecoration(
  //                 contentPadding:
  //                     EdgeInsets.symmetric(vertical: 18.sp),
  //                 hintText: "Search product or Category",
  //                 focusColor: COLOR_PRIMARY,
  //                 prefixIcon: IconButton(
  //                   onPressed: () => Get.back(),
  //                   icon: Icon(
  //                     Icons.arrow_back,
  //                     size: 45.sp,
  //                     color: Colors.black,
  //                   ),
  //                 ),
  //                 suffixIcon: isTyping.value == true
  //                     ? IconButton(
  //                         icon: const Icon(Icons.close),
  //                         onPressed: () {
  //                           searchTextCont.text = "";
  //                           isTyping.value = false;
  //                         },
  //                       )
  //                     : null,
  //                 border: InputBorder.none),
  //           ),
  //         ),
  //       ),
  //       GestureDetector(
  //         onTap: () {
  //           searchController
  //               .fetchKeywordWiseAds(searchTextCont.text);
  //           homeCont.typeList.value = "keywordList";
  //           Navigator.of(context).pushNamedAndRemoveUntil(
  //               '/', (Route<dynamic> route) => false);
  //         },
  //         child: Container(
  //             height: 90.sp,
  //             padding: EdgeInsets.symmetric(horizontal: 20.sp),
  //             decoration: BoxDecoration(
  //                 color: Colors.blueGrey[800],
  //                 borderRadius: const BorderRadius.only(
  //                   topRight: Radius.circular(5),
  //                   bottomRight: Radius.circular(5),
  //                 )),
  //             child: Icon(
  //               Icons.search,
  //               size: 48.sp,
  //               color: Colors.white,
  //             )),
  //       ),
  //     ],
  //   ),
  // ),
