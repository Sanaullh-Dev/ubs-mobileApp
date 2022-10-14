import 'package:flutter/material.dart';
import 'package:ubs/utils/text_style.dart';

AppBar appBar(String titleName) {
  return AppBar(
    leading: IconButton(
      icon: const Icon(Icons.close),
      onPressed: () {},
    ),
    title: Text(titleName, style: appBarTitle),
  );
}
