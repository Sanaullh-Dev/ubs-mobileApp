import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:page_transition/page_transition.dart';
import 'package:ubs/pages/selling/controller/selling_controller.dart';
import 'package:ubs/pages/selling/sale_sub_categories.dart';
import 'package:ubs/pages/selling/widgets/card_category.dart';

class SaleMainCategories extends StatefulWidget {
  const SaleMainCategories({super.key});

  @override
  State<SaleMainCategories> createState() => _SaleMainCategoriesState();
}

class _SaleMainCategoriesState extends State<SaleMainCategories> {
  final SellingController sellingController = Get.find<SellingController>();

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    final TextTheme textTheme = Theme.of(context).textTheme;

    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          backgroundColor: Colors.white,
          leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: const Icon(Icons.close),
          ),
          title: Text("What are you offering?",
              style: TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.w500,
                  fontSize: 38.sp,
                  letterSpacing: 1)),
        ),
        body: Container(
          width: size.width,
          height: size.height,
          padding: const EdgeInsets.fromLTRB(18, 10, 18, 0),
          child: Obx(
            () => sellingController.mainCatList.isEmpty
                ? const Center(child: CircularProgressIndicator())
                : GridView.builder(
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                            childAspectRatio: 1.5,
                            crossAxisCount: 2,
                            crossAxisSpacing: 15,
                            mainAxisSpacing: 15),
                    itemCount: sellingController.mainCatList.length,
                    itemBuilder: (BuildContext context, int index) {
                      return GestureDetector(
                        onTap: () {
                          var mainId =
                              sellingController.mainCatList[index].catId;
                          sellingController.getSubCat(mainId);
                          sellingController.sellingPost.value.pMcat = mainId;

                          Navigator.of(context).push(
                            PageTransition(
                              type: PageTransitionType.rightToLeftJoined,
                              duration: const Duration(milliseconds: 400),
                              reverseDuration:
                                  const Duration(milliseconds: 400),
                              childCurrent: widget,
                              child: SaleSubCategories(
                                mainCatId:
                                    sellingController.mainCatList[index].catId,
                                mainCatName: sellingController
                                    .mainCatList[index].catName,
                              ),
                            ),
                          );
                        },
                        child: CardCategory(
                          categories: sellingController.mainCatList[index],
                          contSize: (size.width / 2) - 50,
                        ),
                      );
                    },
                  ),
          ),
        ),
      ),
    );
  }
}
