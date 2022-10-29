import 'package:flutter/material.dart';
import 'package:ubs/utils/text_style.dart';

AppBar appBar({required String titleName , VoidCallback? onPress}) {
  return AppBar(
    leading: IconButton(
      icon: const Icon(Icons.close),
      onPressed: onPress,
    ),
    title: Text(titleName, style: appBarTitle),
  );
}
