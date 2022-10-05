import 'package:flutter/material.dart';
import 'package:ubs/model/categories.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:ubs/sharing_widget/widget_fun.dart';
import 'package:ubs/utils/constants.dart';
import 'package:ubs/utils/custom_fun.dart';

class CardCategory extends StatelessWidget {
  final Categories categories;
  final double contSize;
  const CardCategory(
      {Key? key, required this.categories, required this.contSize})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    // var uri = API_URL + "/" + categories.catImg.replaceAll("\\", "/");

    return Container(
      width: 20.sp,
      height: 550.sp,
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
            width: 90.sp,
            height: 90.sp,
            child: Image.network(
              getLink(categories.catImg),
              color: Colors.white,
              colorBlendMode: BlendMode.color,
              fit: BoxFit.cover,
            ),
          ),
          addVerticalSpace(10),
          Text(
            categories.catName,
            textAlign: TextAlign.center,
            style: TextStyle(color: Colors.black, fontSize: 23.sp),
          )
        ],
      ),
    );
  }
}
