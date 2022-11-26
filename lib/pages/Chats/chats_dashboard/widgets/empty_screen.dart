import 'package:flutter/material.dart';
import 'package:ubs/utils/text_style.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class EmptyScreen extends StatelessWidget {
  final String title_1;
  final String? title_2;
  final String? title_3;
  final String btnTitle;
  const EmptyScreen(
      {super.key,
      required this.title_1,
      this.title_2,
      this.title_3,
      required this.btnTitle});

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;

    return SingleChildScrollView(
      physics: const AlwaysScrollableScrollPhysics(),
      child: SizedBox(
        height: size.height - 300.sp,
        width: size.width,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
              height: 150,
              width: 150,
              child: Image.asset("lib/assets/images/search.png"),
            ),
            const SizedBox(height: 25),
            Text(title_1, style: heading3),
            title_2 != null ? const SizedBox(height: 15) : const SizedBox(),
            title_2 != null ? Text(title_2!, style: heading6) : const SizedBox(),
            title_3 != null ? const SizedBox(height: 15) : const SizedBox(),
            title_3 != null
                ? Text(title_3!, style: heading6, textAlign: TextAlign.center)
                : const SizedBox(),
            const SizedBox(height: 25),
            SizedBox(
              width: 280,
              height: 60,
              child: ElevatedButton(
                onPressed: () {},
                child: Text(btnTitle, style: buttonTextLight),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
