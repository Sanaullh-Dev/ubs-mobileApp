import 'package:flutter/material.dart';

class DetailsPoints extends StatelessWidget {
  const DetailsPoints({super.key, required this.title, required this.info});
  final String title;
  final String info;

  @override
  Widget build(BuildContext context) {
    final TextTheme textTheme = Theme.of(context).textTheme;

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: Row(
        children: [
          Expanded(
            flex: 1,
            child: Text(
              title,
              style: textTheme.bodyText1,
            ),
          ),
          Expanded(
            flex: 3,
            child: Text(
              info,
              style: textTheme.bodyText2,
            ),
          ),
        ],
      ),
    );
  }
}
