import 'package:flutter/material.dart';
import 'package:ubs/utils/constants.dart';

Future<String> DialogPicker(
    BuildContext context, Size size) async {
  final TextTheme textTheme = Theme.of(context).textTheme;
  String select= "";

  await showDialog(
    context: context,
    builder: (BuildContext context) => Dialog(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            decoration: onlyBottomBorder,
            padding: const EdgeInsets.fromLTRB(15, 20, 0, 20),
            child: Row(
              children: [
                Text(
                  "Brand Names".toUpperCase(),
                  style: const TextStyle(
                      fontSize: 18,
                      color: COLOR_BLACK,
                      letterSpacing: 1,
                      fontWeight: FontWeight.w600),
                ),
              ],
            ),
          ),
          ConstrainedBox(
            constraints: BoxConstraints(
              minHeight: 0,
              maxHeight: size.height * 0.73,
            ),
            child: SizedBox(
              height: (130 * 10) + 100,
              child: ListView.builder(
                itemCount: 130,
                itemBuilder: (BuildContext context, int index) {
                  return ListTile(
                    minVerticalPadding: 12,
                    title: Text(
                      "Option - $index",
                      style: textTheme.bodyText1,
                    ),
                    onTap: () {
                      select = "Option - $index";
                      Navigator.pop(context);
                    },
                  );
                },
              ),
            ),
          ),
          Container(
            padding: const EdgeInsets.fromLTRB(0, 6, 10, 6),
            decoration: onlyTopBorder,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                InkWell(
                  onTap: () {
                    Navigator.pop(context);
                  },
                  child: Padding(
                    padding: const EdgeInsets.all(15.0),
                    child: Text(
                      "CANCEL".toUpperCase(),
                      style: const TextStyle(
                          fontSize: 16,
                          color: COLOR_BLACK,
                          fontWeight: FontWeight.w600),
                    ),
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    ),
  );

  return select;
}
