import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:ubs/model/categories.dart';
import 'package:ubs/model/user_login.dart';
import 'package:ubs/pages/Categories/main_categories.dart';
import 'package:ubs/pages/Categories/sub_categories.dart';
import 'package:ubs/pages/home/controller/home_controller.dart';
import 'package:ubs/utils/constants.dart';
import 'package:ubs/utils/custom_fun.dart';
import 'package:ubs/utils/text_style.dart';

const double iconsSize = 40;

class CategoriesBar extends StatelessWidget {
  final UserLogin userData;
  const CategoriesBar({super.key, required this.userData});

  @override
  Widget build(BuildContext context) {
    HomeController homeCont = Get.find<HomeController>();
    List<Categories> catData = homeCont.mainCatList;

    return Container(
      color: whiteColor,
      padding: EdgeInsets.symmetric(vertical: 15.h, horizontal: 15.h),
      height: 380.sp,
      child: Column(
        children: [
          Container(
            padding: EdgeInsets.symmetric(horizontal: 45.w),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text("Browser categories", style: titleLabel),
                InkWell(
                  onTap: () {
                    Get.to(
                        MainCategories(userData: userData, catData: catData));
                  },
                  child: Container(
                    padding:
                        EdgeInsets.symmetric(horizontal: 30.w, vertical: 13.h),
                    decoration: BoxDecoration(
                        color: primaryColor,
                        borderRadius: BorderRadius.circular(8)),
                    child: Text("See all", style: btnText),
                  ),
                )
              ],
            ),
          ),
          SizedBox(height: 15.h),
          Expanded(
            child: ListView.builder(
              padding: EdgeInsets.symmetric(horizontal: 30.sp),
              scrollDirection: Axis.horizontal,
              itemCount: catData.length,
              itemBuilder: (BuildContext context, int index) {
                return GestureDetector(
                  onTap: () {
                    homeCont.subCatList.value = [];
                    Get.to(SubCategories(
                      userData: userData,
                      gotoPage: "Buy",
                      catData: catData[index],
                    ));
                  },
                  child: Container(
                    width: 210.sp,
                    decoration: BoxDecoration(
                        color: const Color(0x33C1C0C0),
                        border: Border.all(width: 2, color: Colors.white),
                        borderRadius: BorderRadius.circular(20.r)),
                    padding: EdgeInsets.symmetric(horizontal: 20.sp),
                    margin: EdgeInsets.only(right: 15.w),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          padding: const EdgeInsets.all(10),
                          height: 140.sp,
                          child: Image.network(
                            getLink(catData[index].catImg),
                            fit: BoxFit.cover,
                          ),
                        ),
                        SizedBox(
                          width: 140.w,
                          child: Text(catData[index].catName,
                              textAlign: TextAlign.center,
                              softWrap: true,
                              overflow: TextOverflow.fade,
                              maxLines: 2,
                              style: cardTitle),
                        )
                      ],
                    ),
                  ),
                );
              },
            ),
          )
        ],
      ),
    );
  }
}
