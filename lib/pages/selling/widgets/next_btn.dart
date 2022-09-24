import 'package:flutter/material.dart';
import 'package:ubs/utils/constants.dart';

class NextButton extends StatefulWidget {
  final VoidCallback onPress;
  final String labelText;
  const NextButton({super.key, required this.onPress, required this.labelText});

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
            padding: const EdgeInsets.fromLTRB(20, 12, 20, 25),
            child: TextButton(
              onPressed: widget.onPress,
              child: Text(
                widget.labelText,
                style: buttonTextStyle,
              ),
            ),
          ),
        ));
  }
}
