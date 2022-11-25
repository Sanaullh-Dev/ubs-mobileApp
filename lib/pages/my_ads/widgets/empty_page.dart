import 'package:flutter/material.dart';
import 'package:ubs/utils/text_style.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class EmptyPage extends StatelessWidget {
  final Size size;
  final VoidCallback onBtnPress;
  final String imagePath;
  final String btnName;
  const EmptyPage(
      {super.key,
      required this.size,
      required this.onBtnPress,
      required this.btnName,
      required this.imagePath});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      physics: const AlwaysScrollableScrollPhysics(),
      child: SizedBox(
        width: size.width,
        child: Column(
          children: [
            const SizedBox(height: 80),
            SizedBox(width: size.width * 0.5, child: Image.asset(imagePath)),
            const SizedBox(height: 20),
            Text("You have't listed anything yet", style: heading5),
            const SizedBox(height: 10),
            Text("let go of what you don't use anymore", style: cardSubTitle),
            const SizedBox(height: 40),
            SizedBox(
              width: size.width * 0.55,
              height: 80.sp,
              child: ElevatedButton(
                onPressed: onBtnPress,
                child: Text(btnName,
                    style: buttonTextStyle.copyWith(color: Colors.black)),
              ),
            )
          ],
        ),
      ),
    );
  }
}
