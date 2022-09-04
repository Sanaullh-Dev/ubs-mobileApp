import 'package:flutter/material.dart';
import 'package:ubs/model/categories.dart';
import 'package:ubs/pages/selling/sale_sub_categories.dart';
import 'package:ubs/sharing_widget/widget_fun.dart';
import 'package:ubs/utils/constants.dart';
import 'package:ubs/utils/sample_data.dart';

class SaleMainCategories extends StatelessWidget {
  
  const SaleMainCategories({super.key});

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    List<Categories> catData = [];
    final TextTheme textTheme = Theme.of(context).textTheme;

    for (var i = 0; i < categoriesList.length; i++) {
      catData.add(Categories.fromJson(categoriesList[i]));
    }

    return SafeArea(
        child: Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        leading: IconButton(onPressed: () {
          Navigator.pop(context);
        }, icon: Icon(Icons.close)),
        title: const Text("What are you offering?", 
        style: TextStyle(
      color: Colors.black, fontWeight: FontWeight.w500, fontSize: 20, letterSpacing: 1)),
      ),
      body: Container(
        width: size.width,
        height: size.height,
        padding: const EdgeInsets.fromLTRB(18, 10, 18, 0),
        child: GridView.builder(
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              childAspectRatio: 1.5,
              crossAxisCount: 2,
              crossAxisSpacing: 15,
              mainAxisSpacing: 15),
          itemCount: catData.length,
          itemBuilder: (BuildContext context, int index) {
            return GestureDetector(
              onTap: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) =>                    
                        SaleSubCategories(
                          catData: catData[index],
                          subCategoryData: catData[index].subCategories,
                           ),
                  ),
                );
              },
              child: cardCate(
                cat: catData[index],
                contSize: (size.width / 2) - 50,
              ),
            );
          },
        ),
      ),
    ));
  }
}

class cardCate extends StatelessWidget {
  final cat;
  final double contSize;
  const cardCate({Key? key, required this.cat, required this.contSize})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 20,
      height: 550,
      decoration: const BoxDecoration(
        border: Border(
            right: BorderSide(color: COLOR_BORDER, width: 1),
            bottom: BorderSide(color: COLOR_BORDER, width: 1)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(
            width: 50,
            height: 50,
            child: Image.asset(
              cat.img,
              // color: Colors.white.withAlpha(190),
              color: Colors.white,
              colorBlendMode: BlendMode.color,
              fit: BoxFit.cover,
            ),
          ),
          addVerticalSpace(10),
          Text(
            cat.title.toString(),
            textAlign: TextAlign.center,
          )
        ],
      ),
    );
  }
}
