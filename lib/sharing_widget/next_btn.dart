import 'package:flutter/material.dart';
import 'package:ubs/utils/constants.dart';
import 'package:ubs/utils/text_style.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class NextButton extends StatefulWidget {
  final VoidCallback onPress;
  final String labelText;
  final bool enable;
  const NextButton({super.key, required this.onPress, required this.labelText, required this.enable});

  @override
  State<NextButton> createState() => _NextButtonState();
}

class _NextButtonState extends State<NextButton> {
  @override
  Widget build(BuildContext context) {
    return Positioned(
        bottom: 0,
        left: 0,
        right: 0,
        child: Container(
          decoration: onlyTopBorder,
          child: Padding(
            padding: EdgeInsets.symmetric(vertical: 30.sp, horizontal: 50.sp),
            child: AbsorbPointer(
              absorbing: widget.enable,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF263238),
                  padding: EdgeInsets.symmetric(vertical: 25.w)
                ),
                onPressed: widget.onPress,
                child: Text(
                  widget.labelText,
                  style: buttonTextStyle,
                ),
              ),
            ),
          ),
        ));
  }
}
