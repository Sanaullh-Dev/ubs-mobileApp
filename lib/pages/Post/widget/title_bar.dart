import 'package:flutter/material.dart';
import 'package:ubs/model/post_model.dart';
import 'package:ubs/sharing_widget/widget_fun.dart';
import 'package:ubs/utils/constants.dart';

class TitleBar extends StatelessWidget {
  final PostModel postData;
  const TitleBar({super.key, required this.postData});

  @override
  Widget build(BuildContext context) {
    final TextTheme textTheme = Theme.of(context).textTheme;

    return Container(
      padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 15),
      decoration: BoxDecoration(
          color: Colors.yellow.withAlpha(200),
          border: Border(
              bottom: BorderSide(width: 2, color: Colors.blueGrey.shade200))),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                // "& 5,000",
                postData.amount.toString(),
                style: textTheme.headline1,
              ),
              Padding(
                  padding: const EdgeInsets.only(right: 15),
                  child: Container(
                    padding: const EdgeInsets.all(5),
                    decoration: favoriteBorder,
                    child: Icon(
                      postData.favorite == "no"
                          ? Icons.favorite_border
                          : Icons.favorite,
                      size: 30,
                      color:
                          postData.favorite == "no" ? Colors.black : Colors.red,
                    ),
                  ))
            ],
          ),
          addVerticalSpace(8),
          Text(
            // "Sub Title About post and more details",
            postData.name,
            style: textTheme.headline4,
          ),
          addVerticalSpace(8),
          Text(
            // "Sub Title About post and more details",
            postData.subtitle,
            style: textTheme.headline6,
          ),
          addVerticalSpace(8),
          Row(
            children: [
              const Icon(Icons.location_on),
              Text(
                // "Location name about post",
                postData.location,
                style: textTheme.headline6,
              ),
              const Expanded(child: SizedBox()),
              Text(
                "Today",
                style: textTheme.headline4,
              )
            ],
          ),
        ],
      ),
    );
  }
}
