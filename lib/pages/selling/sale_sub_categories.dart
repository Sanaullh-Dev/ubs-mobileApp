import 'package:flutter/material.dart';
import 'package:ubs/model/categories.dart';
import 'package:ubs/pages/selling/P1_info/mobile_sale1.dart';
import 'package:ubs/pages/selling/P2_image_Picker/photo_gallery.dart';
import 'package:ubs/utils/constants.dart';

class SaleSubCategories extends StatelessWidget {
  final List<SubCategory> subCategoryData;
  final Categories catData;
  const SaleSubCategories({
    super.key,
    required this.subCategoryData,
    required this.catData,
  });

  @override
  Widget build(BuildContext context) {
    // this line of code for View all
    subCategoryData
        .add(SubCategory.fromJson({"subCatId": "0", "subCatName": "View All"}));

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
          catData.title,
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
            child: ListView.builder(
              itemCount: subCategoryData.length,
              itemBuilder: (BuildContext context, int index) {
                return GestureDetector(
                  onTap: () {
                    Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => MobileSale()));
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
                    padding:
                        const EdgeInsets.symmetric(vertical: 6, horizontal: 8),
                    child: ListTile(
                      title: Text(
                        subCategoryData[index].subCatName,
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
            ),
          ),
        ],
      ),
    ));
  }
}
