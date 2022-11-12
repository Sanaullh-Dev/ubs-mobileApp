import 'package:badges/badges.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:ubs/model/cats_board.dart';
import 'package:ubs/sharing_widget/widget_fun.dart';
import 'package:ubs/utils/constants.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:ubs/utils/text_style.dart';

class ChatsListTitle extends StatelessWidget {
  final ChatBoard chatData;
  const ChatsListTitle({Key? key, required this.chatData}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final DateFormat formatter = DateFormat('yyyy-MMM-dd');

    return GestureDetector(
      onTap: () {
        Navigator.pushNamed(context, "/chatDetails");
        // Navigator.pushNamed(context, "/demo");
      },
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 10),
        decoration: BoxDecoration(
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
            Container(
                padding: const EdgeInsets.all(6),
                width: 100,
                height: 110,
                child: Badge(
                  // badgeColor: Colors.white,
                  padding: EdgeInsets.zero,
                  borderSide: const BorderSide(color: Colors.white, width: 2),
                  badgeContent: SizedBox(
                      height: 45,
                      width: 45,
                      child: ClipOval(
                        // borderRadius: BorderRadius.circular(50),
                        child: Image.asset(
                          chatData.userImg,
                          fit: BoxFit.fitWidth,
                        ),
                      )),
                  position: BadgePosition.bottomEnd(),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(5.0),
                    child: Image.asset(
                      chatData.postImg,
                      fit: BoxFit.cover,
                    ),
                  ),
                )),
            addHorizontalSpace(15),
            Expanded(
              child: Column(
                children: [
                  const SizedBox(height: 10),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(chatData.userName, style: heading6),
                      Text(formatter.format(chatData.userLastSeen) + "   ",
                          style: trailingTestStyle)
                    ],
                  ),
                  const SizedBox(height: 5),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            chatData.postTitle,
                            maxLines: 1,
                            softWrap: false,
                            overflow: TextOverflow.ellipsis,
                            style: subtitleLabel.copyWith(fontSize: 26.sp),
                          ),
                          const SizedBox(height: 5),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Icon(
                                chatData.messageStatus == "read"
                                    ? Icons.done_all_outlined
                                    : Icons.done,
                                color: Colors.blueGrey.shade200,
                                size: 20,
                              ),
                              const SizedBox(width: 5),
                              Text(
                                chatData.postTitle,
                                maxLines: 1,
                                softWrap: false,
                                overflow: TextOverflow.ellipsis,
                                style: subTitle2,
                              )
                            ],
                          ),
                        ],
                      ),
                      const Icon(Icons.more_vert_outlined,
                          size: 28, color: COLOR_BLACK)
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
