import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:ubs/model/ads_post.dart';
import 'package:ubs/pages/Chats/widgets/style.dart';
import 'package:ubs/sharing_widget/widget_fun.dart';
import 'package:ubs/utils/constants.dart';

class FavoritesTitle extends StatelessWidget {
  final AdsPost adsData;
  const FavoritesTitle({Key? key, required this.adsData}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final DateFormat formatter = DateFormat('yyyy-MMM-dd');

    return GestureDetector(
      onTap: () {
        Navigator.pushNamed(context, "/chatDetails");
        // Navigator.pushNamed(context, "/demo");
      },
      child: Container(
        padding: const EdgeInsets.all(8),
        height: 90,
        decoration: BoxDecoration(
          // color: Colors.amber,
          // color: const Color(0x33C1C0C0),
          color: COLOR_WHITE,
          border: Border(
            bottom: BorderSide(
              width: 1,
              color: Colors.blueGrey.shade100,
            ),
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            SizedBox(
              width: 75,
              height: 80,
              child: Stack(
                children: [
                  Positioned.fill(
                    child: Padding(
                      padding: const EdgeInsets.all(6),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(5.0),
                        child: Image.asset(
                          adsData.pImg1,
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                  ),
                  Positioned(
                    bottom: 0,
                    right: 0,
                    child: Container(
                      width: 35,
                      clipBehavior: Clip.antiAliasWithSaveLayer,
                      decoration: BoxDecoration(
                          border: Border.all(width: 3, color: COLOR_WHITE),
                          borderRadius: BorderRadius.circular(100)),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(20),
                        child: Image.asset(
                          adsData.pImg2,
                          fit: BoxFit.fitWidth,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            addHorizontalSpace(10),
            Expanded(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        adsData.pBrand,
                        style: titleTextStyle,
                      ),
                      Text(
                        adsData.pTitle,
                        maxLines: 1,
                        softWrap: false,
                        overflow: TextOverflow.ellipsis,
                        style: postTitleStyle,
                      ),
                    ],
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      const Text(
                        // formatter.format(adsData.) + "   ",
                        "15-5-55",
                        style: trailingTestStyle,
                      ),
                      addVerticalSpace(8),
                      const Icon(Icons.more_vert_outlined,
                          size: 28, color: COLOR_BLACK),
                      addVerticalSpace(4),
                    ],
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
