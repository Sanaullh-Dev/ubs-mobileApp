import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:page_transition/page_transition.dart';
import 'package:ubs/pages/selling/P1_info/sale_info-1.dart';
import 'package:ubs/pages/selling/controller/selling_controller.dart';
import 'package:ubs/utils/constants.dart';

class SaleSubCategories extends StatelessWidget {
  final int mainCatId;
  final String mainCatName;
  const SaleSubCategories({
    super.key,
    required this.mainCatId,
    required this.mainCatName,
  });

  @override
  Widget build(BuildContext context) {
    SellingController sellingController = Get.find<SellingController>();

    // this line of code for View all List
    // subCategoryData
    //     .add(SubCategory.fromJson({"subCatId": "0", "subCatName": "View All"}));

    return SafeArea(
        child: Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back_ios_new_rounded,
            size: 25,
            color: Colors.black,
          ),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: Text(
          mainCatName,
          style: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w500,
              color: Colors.black,
              letterSpacing: 0.9),
        ),
      ),
      body: Column(
        children: [
          Expanded(
            child: Obx(() => sellingController.subCatList == null
                ? const Center(child: CircularProgressIndicator())
                : ListView.builder(
                    itemCount: sellingController.subCatList.length,
                    itemBuilder: (BuildContext context, int index) {
                      return GestureDetector(
                        onTap: () {
                          var subCat =
                              sellingController.subCatList[index].catId;
                          sellingController.sellingPost.value.pScat = subCat;

                          Navigator.of(context).push(PageTransition(
                              type: PageTransitionType.rightToLeftJoined,
                              duration: const Duration(milliseconds: 300),
                              reverseDuration:
                                  const Duration(milliseconds: 300),
                              childCurrent: this,
                              child: SaleInfo1()));
                          // builder: (context) => GalleryPage()));
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
                              sellingController.subCatList[index].catName,
                              style: const TextStyle(
                                  color: COLOR_BLACK,
                                  fontWeight: FontWeight.w500,
                                  fontSize: 18,
                                  fontFamily: "Roboto"),
                            ),
                          ),
                        ),
                      );
                    },
                  )),
          ),
        ],
      ),
    ));
  }
}
