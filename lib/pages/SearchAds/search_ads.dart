import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:ubs/utils/constants.dart';
import 'package:ubs/utils/text_style.dart';

class SearchAds extends StatelessWidget {
  const SearchAds({super.key});

  @override
  Widget build(BuildContext context) {
    bool isTyping = false;

    return SafeArea(
      child: Scaffold(
        body: Column(
          children: [
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 20.sp),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Expanded(
                    child: Container(
                      margin: EdgeInsets.symmetric(vertical: 15.sp),
                      // padding: EdgeInsets.symmetric(vertical: 10.sp),
                      height: 80.sp,
                      padding: EdgeInsets.zero,
                      decoration: BoxDecoration(
                          color: Colors.white,
                          border: Border.all(width: 2, color: Colors.cyan),
                          borderRadius: const BorderRadius.only(
                              topLeft: Radius.circular(10.0),
                              bottomLeft: Radius.circular(10.0))),
                      child: TextField(
                        style: textfield,
                        decoration: InputDecoration(
                            hintText: "Search city, area or neighborhood",
                            focusColor: Colors.cyan,
                            prefixIcon: IconButton(
                              onPressed: () {},
                              icon: Icon(
                                Icons.arrow_back,
                                size: 55.sp,
                              ),
                            ),
                            suffixIcon: isTyping == true
                                ? const Icon(Icons.close)
                                : null,
                            border: InputBorder.none),
                      ),
                    ),
                  ),
                  Container(
                      height: 80.sp,
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
          ],
        ),
      ),
    );
  }
}
