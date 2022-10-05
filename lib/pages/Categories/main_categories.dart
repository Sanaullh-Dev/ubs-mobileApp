import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:ubs/model/categories.dart';
import 'package:ubs/pages/Categories/sub_categories.dart';
import 'package:ubs/utils/constants.dart';
import 'package:ubs/utils/custom_fun.dart';

class MainCategories extends StatelessWidget {
  final List<Categories> catData;
  const MainCategories({super.key, required this.catData});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: const Icon(
            Icons.arrow_back_ios_new_rounded,
            size: 25,
            color: Colors.black,
          ),
        ),
        title: const Text(
          "Categories",
          style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w500,
              color: Colors.black,
              letterSpacing: 0.9),
        ),
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: catData.length,
              itemBuilder: (BuildContext context, int index) {
                return Container(
                  decoration: BoxDecoration(
                    border: Border(
                      bottom: BorderSide(
                        width: 1,
                        color: COLOR_LIGHT_BLACK.withAlpha(50),
                      ),
                    ),
                  ),
                  padding:
                      const EdgeInsets.symmetric(vertical: 16, horizontal: 8),
                  // margin: EdgeInsets.symmetric(vertical: 8),
                  child: ListTile(
                    onTap: () {
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
                    leading: SizedBox(
                      height: 60,
                      child: Image.network(
                        getLink(catData[index].catImg),
                        fit: BoxFit.cover,
                      ),
                    ),
                    title: Text(
                      catData[index].catName,
                      style: TextStyle(
                          color: COLOR_BLACK,
                          fontWeight: FontWeight.w500,
                          fontSize: 28.sp,
                          fontFamily: "Roboto"),
                    ),
                    trailing: const Icon(Icons.chevron_right_outlined),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    ));
  }
}
