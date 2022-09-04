import 'package:flutter/material.dart';
import 'package:ubs/utils/constants.dart';

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
        padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 1),
        child: Text(
          btnTitle,
          style: TextStyle(
              fontSize: 12,
              color: Colors.blueGrey.shade400,
              fontWeight: FontWeight.w500),
        ),
      ),
    );
  }
}
