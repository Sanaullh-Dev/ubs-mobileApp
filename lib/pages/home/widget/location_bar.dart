import 'package:flutter/material.dart';
import 'package:ubs/sharing_widget/widget_fun.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:ubs/utils/text_style.dart';

class LocationBar extends StatelessWidget {
  const LocationBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Icon(
          Icons.location_on,
          size: 50.sp,
          color: Colors.black87,
        ),
        addHorizontalSpace(5),
        Text("Location, Maharashtra", style: heading4),
        Icon(Icons.keyboard_arrow_down, size: 60.sp, color: Colors.black87),
      ],
    );
  }
}
