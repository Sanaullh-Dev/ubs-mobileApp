import 'package:flutter/material.dart';
import 'package:ubs/utils/text_style.dart';

class PrimaryButton extends StatelessWidget {
  final VoidCallback onPress;
  final String title;
  const PrimaryButton({super.key,required this.onPress, required this.title});

  @override
  Widget build(BuildContext context) {
    return OutlinedButton(
      style: OutlinedButton.styleFrom(
        backgroundColor: Colors.blueGrey[900],
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8.0),
        ),
        
      ),
      onPressed: onPress,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 8),
        child: Text(
          title,
          style: buttonTextStyle,
        ),
      ),
    );
  }
}
