import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:ubs/model/categories.dart';
import 'package:ubs/pages/Categories/main_categories.dart';
import 'package:ubs/pages/Categories/sub_categories.dart';
import 'package:ubs/pages/home/controller/home_controller.dart';
import 'package:ubs/utils/constants.dart';
import 'package:ubs/utils/custom_fun.dart';
import 'package:ubs/utils/text_style.dart';

const double iconsSize = 40;

class CategoriesBar extends StatelessWidget {
  const CategoriesBar({super.key});

  @override
  Widget build(BuildContext context) {
    final TextTheme textTheme = Theme.of(context).textTheme;
    final Size size = MediaQuery.of(context).size;
    HomeController homeCont = Get.find<HomeController>();
    List<Categories> catData = homeCont.mainCatList;

    return Container(
      color: COLOR_WHITE,
      padding: EdgeInsets.symmetric(vertical: 15.h, horizontal: 15.h),
      height: 350.sp,
      child: Obx(
        () => homeCont.mainCatList.value.isEmpty
            ? const Center(child: CircularProgressIndicator())
            : Column(
                children: [
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 45.w),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text("Browser categories", style: titleLabel),
                        InkWell(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) =>
                                    MainCategories(catData: catData),
                              ),
                            );
                          },
                          child: Container(
                            padding: EdgeInsets.symmetric(
                                horizontal: 30.w, vertical: 13.h),
                            decoration: BoxDecoration(
                                color: COLOR_PRIMARY,
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
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => SubCategoriesPage(
                                  gotoPage: "Buy",
                                  catData: catData[index],
                                  // subCategoryData: catData[index].subCategories
                                ),
                              ),
                            );
                          },
                          child: Container(
                            decoration: BoxDecoration(
                                color: const Color(0x33C1C0C0),
                                border:
                                    Border.all(width: 2, color: Colors.white),
                                borderRadius: BorderRadius.circular(20.r)),
                            padding: EdgeInsets.symmetric(horizontal: 20.sp),
                            margin: EdgeInsets.only(right: 15.w),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Container(
                                  padding: const EdgeInsets.all(10),
                                  height: 110.sp,
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
                                      style: heading5),
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
      ),
    );
  }
}
