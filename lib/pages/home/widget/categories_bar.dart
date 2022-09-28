import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ubs/model/categories.dart';
import 'package:ubs/pages/Categories/main_categories.dart';
import 'package:ubs/pages/Categories/sub_categories.dart';
import 'package:ubs/pages/home/controller/home_controller.dart';
import 'package:ubs/utils/constants.dart';
import 'package:ubs/utils/custom_fun.dart';

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
        padding: const EdgeInsets.symmetric(vertical: 8),
        height: 190,
        child: Obx(
          () => homeCont.mainCatList.value.length == 0
              ? const Center(child: CircularProgressIndicator())
              : Column(
                  children: [
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 12),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text("Browser categories",
                              style: textTheme.headline4),
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
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 20, vertical: 8),
                              decoration: BoxDecoration(
                                  color: COLOR_PRIMARY,
                                  borderRadius: BorderRadius.circular(8)),
                              child: Text(
                                "See all",
                                style: textTheme.button,
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                    const SizedBox(height: 5),
                    Expanded(
                      child: ListView.builder(
                        padding: const EdgeInsets.symmetric(horizontal: 7),
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
                                  borderRadius: BorderRadius.circular(10)),
                              padding: const EdgeInsets.all(8),
                              margin: const EdgeInsets.only(right: 4),
                              // color: categoriesList[index]["color"],
                              // width: 105,

                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Container(
                                    padding: const EdgeInsets.all(10),
                                    height: 70,
                                    child: Image.network(
                                      getLink(catData[index].catImg),
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                  // addVerticalSpace(8),
                                  SizedBox(
                                    width: 100,
                                    child: Text(catData[index].catName,
                                        textAlign: TextAlign.center,
                                        softWrap: true,
                                        overflow: TextOverflow.fade,
                                        maxLines: 2,
                                        style: const TextStyle(
                                            fontSize: 12,
                                            color: Colors.black,
                                            letterSpacing: 1)),
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
        ));
  }
}
