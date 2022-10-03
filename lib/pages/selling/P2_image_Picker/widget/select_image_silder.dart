import 'dart:io';

import 'package:flutter/material.dart';
import 'package:ubs/utils/constants.dart';
import 'package:carousel_pro/carousel_pro.dart';

class SelectImageSlider extends StatelessWidget {
  final List<String> imgList;
  const SelectImageSlider({Key? key, required this.imgList}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;

    return Container(
      height: size.height * 0.35,
      width: size.width,
      color: Colors.black,
      child: Carousel(
        autoplay: false,
        boxFit: BoxFit.cover,
        dotBgColor: Colors.transparent,
        dotColor: COLOR_WHITE,
        dotIncreasedColor: COLOR_PRIMARY,
        dotSize: 8,
        dotSpacing: 25,
        images: imgList
            .map((e) => Image.file(File(e), fit: BoxFit.fitHeight))
            .toList(),
      ),
    );
  }
}
