import 'package:flutter/material.dart';
import 'package:ubs/utils/constants.dart';

class BorderBox extends StatelessWidget {
  final Widget child;
  final EdgeInsets? padding;
  final double? width, height;

  const BorderBox({
    Key? key,
    required this.child,
    this.padding,
    this.height,
    this.width,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: height,
      decoration: BoxDecoration(
        color: whiteColor,
        borderRadius: BorderRadius.circular(15),
        border: Border.all(color: greyColor.withAlpha(40), width: 2)
      ),
      padding: padding ?? const EdgeInsets.all(8.0),
      child: Center(child: child),
    );
  }
}
