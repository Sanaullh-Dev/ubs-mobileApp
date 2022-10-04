import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:ubs/utils/constants.dart';
import 'package:ubs/utils/text_style.dart';

class SearchAds extends StatelessWidget {
  const SearchAds({super.key});

  @override
  Widget build(BuildContext context) {
    Rx<bool> isTyping = false.obs;
    TextEditingController searchTextCont = TextEditingController();

    return SafeArea(
        child: Scaffold(
      body: Obx(() => Column(
            children: [
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 20.sp),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Expanded(
                      child: Container(
                        margin: EdgeInsets.symmetric(vertical: 15.sp),
                        // padding: EdgeInsets.symmetric(vertical: 10.sp),
                        height: 90.sp,
                        padding: EdgeInsets.zero,
                        decoration: BoxDecoration(
                            color: Colors.white,
                            border: Border.all(
                                width: 2,
                                color: isTyping.value == true
                                    ? COLOR_PRIMARY
                                    : COLOR_BLACK),
                            borderRadius: const BorderRadius.only(
                                topLeft: Radius.circular(10.0),
                                bottomLeft: Radius.circular(10.0))),
                        child: TextField(
                          controller: searchTextCont,
                          maxLines: 1,
                          textAlignVertical: TextAlignVertical.center,
                          onChanged: (val) {
                            isTyping.value = val == "" ? false : true;
                          },
                          style: TextStyle(
                              color: Colors.black,
                              fontSize: 35.sp,
                              fontFamily: "Poppins"),
                          decoration: InputDecoration(
                              contentPadding:
                                  EdgeInsets.symmetric(vertical: 18.sp),
                              hintText: "Search city, area or neighborhood",
                              focusColor: COLOR_PRIMARY,
                              prefixIcon: IconButton(
                                onPressed: () => Get.back(),
                                icon: Icon(
                                  Icons.arrow_back,
                                  size: 45.sp,
                                  color: Colors.black,
                                ),
                              ),
                              suffixIcon: isTyping.value == true
                                  ? IconButton(
                                      icon: Icon(Icons.close),
                                      onPressed: () {
                                        searchTextCont.text = "";
                                        isTyping.value = false;
                                      },
                                    )
                                  : null,
                              border: InputBorder.none),
                        ),
                      ),
                    ),
                    Container(
                        height: 90.sp,
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
                  ],
                ),
              ),
              const Divider(),
              Expanded(
                child: ListView.builder(
                  itemCount: 5,
                  itemBuilder: (BuildContext context, int index) {
                    return ListTile(
                      minLeadingWidth: 15.sp,
                      leading: const Icon(
                        Icons.search,
                        color: Colors.black,
                      ),
                      title: Text("Main Title", style: heading5),
                      subtitle: Text("Sub Title", style: heading6),
                      trailing: IconButton(
                        icon: Icon(Icons.close),
                        onPressed: () {},
                        color: Colors.black,
                      ),
                    );
                  },
                ),
              ),
            ],
          )),
    ));
  }
}
