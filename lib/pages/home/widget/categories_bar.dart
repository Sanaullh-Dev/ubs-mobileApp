import 'package:flutter/material.dart';
import 'package:ubs/model/categories.dart';
import 'package:ubs/pages/Categories/main_categories.dart';
import 'package:ubs/pages/Categories/sub_categories.dart';
import 'package:ubs/utils/constants.dart';
import 'package:ubs/utils/sample_data.dart';

const double iconsSize = 40;

class CategoriesBar extends StatelessWidget {
  const CategoriesBar({super.key});

  @override
  Widget build(BuildContext context) {
    final TextTheme textTheme = Theme.of(context).textTheme;
    final Size size = MediaQuery.of(context).size;
    List<Categories> catData = [];

    for (var i = 0; i < categoriesList.length; i++) {
      catData.add(Categories.fromJson(categoriesList[i]));
    }

    return Container(
      color: COLOR_WHITE,
      padding: const EdgeInsets.symmetric(vertical: 8),
      height: 190,
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 12),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text("Browser categories", style: textTheme.headline4),
                InkWell(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => MainCategories(catData: catData),
                      ),
                    );
                  },
                  child: Container(
                    padding: EdgeInsets.symmetric(horizontal: 20, vertical: 8),
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
              padding: EdgeInsets.symmetric(horizontal: 7),
              scrollDirection: Axis.horizontal,
              itemCount: catData.length,
              itemBuilder: (BuildContext context, int index) {
                return GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => SubCategoriesPage(
                            gotoPage: "Buying",
                            catData: catData[index],
                            subCategoryData: catData[index].subCategories),
                      ),
                    );
                  },
                  child: Container(
                    decoration: BoxDecoration(
                        color: const Color(0x33C1C0C0),
                        border: Border.all(width: 2, color: Colors.white),
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
                          child: Image.asset(
                            catData[index].img,
                            fit: BoxFit.cover,
                          ),
                        ),
                        // addVerticalSpace(8),
                        SizedBox(
                          width: 100,
                          child: Text(catData[index].title,
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
    );
  }
}
