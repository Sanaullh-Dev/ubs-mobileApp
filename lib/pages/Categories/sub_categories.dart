import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:ubs/model/categories.dart';
import 'package:ubs/model/user_login.dart';
import 'package:ubs/pages/Categories/controller/categories_controller.dart';
import 'package:ubs/pages/home/controller/home_controller.dart';
import 'package:ubs/pages/home/home_page.dart';
import 'package:ubs/pages/selling/sale_main_categories.dart';
import 'package:ubs/utils/constants.dart';

class SubCategories extends StatefulWidget {
  final UserLogin userData;
  final Categories catData;
  final String gotoPage;
  const SubCategories(
      {super.key,
      required this.userData,
      required this.catData,
      required this.gotoPage});

  @override
  State<SubCategories> createState() => _SubCategoriesState();
}

class _SubCategoriesState extends State<SubCategories> {
  final CategoriesController cateCont = Get.find<CategoriesController>();
  final HomeController homeController = Get.find<HomeController>();

  @override
  void dispose() {
    super.dispose();
    Get.delete<CategoriesController>();
  }

  @override
  Widget build(BuildContext context) {
    cateCont.fetchSubCat(widget.catData.catId);
    // cateCont.catWiseAdsList.value = [];
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
          widget.catData.catName,
          style: TextStyle(
              fontSize: 36.sp,
              fontWeight: FontWeight.w500,
              color: Colors.black,
              letterSpacing: 0.9),
        ),
      ),
      body: Column(
        children: [
          Expanded(
              child: Obx(
            () => cateCont.subCatList.value.isEmpty
                ? const Center(child: CircularProgressIndicator())
                : ListView.builder(
                    itemCount: cateCont.subCatList.value.length,
                    itemBuilder: (BuildContext context, int index) {
                      return GestureDetector(
                        onTap: () {
                          if (widget.gotoPage == "Sale") {
                            Navigator.of(context).push(
                              MaterialPageRoute(
                                builder: (context) => SaleMainCategories(
                                    userData: widget.userData),
                              ),
                            );
                          } else if (widget.gotoPage == "Buy") {
                            if (cateCont.subCatList[index].catName !=
                                "View All") {
                              cateCont.subCat.value =
                                  cateCont.subCatList[index].catId;
                            }
                            homeController.typeList.value = "catList";
                            homeController.mainCat.value = widget.catData.catId;
                            // Get.back();
                            Get.to(HomePage(
                                typeList: "catList",
                                mainCatId: widget.catData.catId,
                                userData: widget.userData));
                            // cateCont.hintText.value =
                            //     cateCont.subCatList[index].catName == "View All"
                            //         ? catData.catName
                            //         : cateCont.subCatList[index].catName;
                            
                          }
                        },
                        child: Container(
                          decoration: BoxDecoration(
                            border: Border(
                              bottom: BorderSide(
                                width: 0.8,
                                color: lightBlackColor.withAlpha(50),
                              ),
                            ),
                          ),
                          padding: const EdgeInsets.symmetric(
                              vertical: 6, horizontal: 8),
                          child: ListTile(
                            title: Text(
                              cateCont.subCatList.value[index].catName,
                              style: TextStyle(
                                  color: blackColor,
                                  fontWeight: FontWeight.w500,
                                  fontSize: 35.sp,
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
