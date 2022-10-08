import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:ubs/model/categories.dart';
import 'package:ubs/pages/home/controller/home_controller.dart';
import 'package:ubs/pages/main_controller.dart';
import 'package:ubs/pages/selling/sale_main_categories.dart';
import 'package:ubs/utils/constants.dart';

class SubCategoriesPage extends StatelessWidget {
  // final List<SubCategory> subCategoryData;
  final Categories catData;
  final String gotoPage;
  SubCategoriesPage(
      {super.key,
      // required this.subCategoryData,
      required this.catData,
      required this.gotoPage});

  MainController mainCont = Get.find<MainController>();
  HomeController homeCont = Get.find<HomeController>();

  @override
  Widget build(BuildContext context) {
    homeCont.fetchSubCat(catData.catId);
    homeCont.catWiseAdsList.value = [];
    return SafeArea(
        child: Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back_ios_new_rounded,
            size: 35.sp,
            color: Colors.black,
          ),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: Text(
          catData.catName,
          style: TextStyle(
              fontSize: 32.sp,
              fontWeight: FontWeight.w500,
              color: Colors.black,
              letterSpacing: 0.9),
        ),
      ),
      body: Column(
        children: [
          Expanded(
              child: Obx(
            () => homeCont.subCatList.value.isEmpty
                ? const Center(child: CircularProgressIndicator())
                : ListView.builder(
                    itemCount: homeCont.subCatList.value.length,
                    itemBuilder: (BuildContext context, int index) {
                      return GestureDetector(
                        onTap: () {
                          if (gotoPage == "Sale") {
                            Navigator.of(context).push(
                              MaterialPageRoute(
                                builder: (context) =>
                                    const SaleMainCategories(),
                              ),
                            );
                          } else if (gotoPage == "Buy") {
                            if (homeCont.subCatList[index].catName !=
                                "View All") {
                              homeCont.subCat.value =
                                  homeCont.subCatList[index].catId;
                            }

                            homeCont.mainCat.value = catData.catId;
                            homeCont.typeList.value = "catList";
                            homeCont.hintText.value =
                                homeCont.subCatList[index].catName == "View All"
                                    ? catData.catName
                                    : homeCont.subCatList[index].catName;
                            Navigator.of(context).pushNamedAndRemoveUntil(
                                '/', (Route<dynamic> route) => false);
                          }
                        },
                        child: Container(
                          decoration: BoxDecoration(
                            border: Border(
                              bottom: BorderSide(
                                width: 0.8,
                                color: COLOR_LIGHT_BLACK.withAlpha(50),
                              ),
                            ),
                          ),
                          padding: const EdgeInsets.symmetric(
                              vertical: 6, horizontal: 8),
                          child: ListTile(
                            title: Text(
                              homeCont.subCatList.value[index].catName,
                              style: TextStyle(
                                  color: COLOR_BLACK,
                                  fontWeight: FontWeight.w500,
                                  fontSize: 28.sp,
                                  fontFamily: "Roboto"),
                            ),
                          ),
                        ),
                      );
                    },
                  ),
          )),
        ],
      ),
    ));
  }
}
