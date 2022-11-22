import 'package:flutter/material.dart';
import 'package:ubs/utils/constants.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class FiltersButtons extends StatelessWidget {
  final String btnTitle;
  final bool isActive;
  const FiltersButtons(
      {super.key, required this.btnTitle, required this.isActive});

  @override
  Widget build(BuildContext context) {
    // final TextTheme textTheme = Theme.of(context).textTheme;

    return OutlinedButton(
      style: OutlinedButton.styleFrom(
        backgroundColor: isActive ? COLOR_PRIMARY : COLOR_WHITE,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(18.0),
        ),
        side: BorderSide(
            width: 1.5,
            color: isActive ? COLOR_PRIMARY : Colors.blueGrey.shade400),
      ),
      onPressed: () {},
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 8),
        child: Text(
          btnTitle,
          style: TextStyle(
              fontSize: 30.sp,
              color: Colors.blueGrey.shade400,
              fontWeight: FontWeight.w500),
        ),
      ),
    );
  }
}

class PriceTag extends StatelessWidget {
  final VoidCallback onPress;
  final String tagTitle;
  const PriceTag({super.key, required this.tagTitle, required this.onPress});

  @override
  Widget build(BuildContext context) {
    // final TextTheme textTheme = Theme.of(context).textTheme;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 5),
      child: OutlinedButton(
        style: OutlinedButton.styleFrom(
          // backgroundColor: isActive ? COLOR_PRIMARY : COLOR_WHITE,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(18.0),
          ),
          side: BorderSide(width: 1.5, color: Colors.blueGrey.shade400),
        ),
        onPressed: onPress,
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 2, horizontal: 8),
          child: Text(
            tagTitle,
            style: TextStyle(
                fontSize: 25.sp,
                color: Colors.blueGrey.shade800,
                fontWeight: FontWeight.w500),
          ),
        ),
      ),
    );
  }
}

class ChatsTag extends StatelessWidget {
  final VoidCallback onPress;
  final String tagTitle;
  const ChatsTag({super.key, required this.tagTitle, required this.onPress});

  @override
  Widget build(BuildContext context) {
    // final TextTheme textTheme = Theme.of(context).textTheme;

    return GestureDetector(
      onTap: onPress,
      child: Container(
        margin: const EdgeInsets.only(left: 15, bottom: 15),
        padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 8),
        decoration: BoxDecoration(
            color: Colors.white,
            border: Border.all(width: 1, color: Colors.blueGrey[300]!),
            borderRadius: BorderRadius.circular(5),
            boxShadow: [
              BoxShadow(
                offset: const Offset(1, 1),
                blurRadius: 1.0,
                color: Colors.grey.withAlpha(50),
              )
            ]),
        child: Text(
          tagTitle,
          style: TextStyle(
              fontSize: 28.sp,
              color: Colors.blueGrey.shade600,
              fontWeight: FontWeight.w500),
        ),
      ),
    );
  }
}
