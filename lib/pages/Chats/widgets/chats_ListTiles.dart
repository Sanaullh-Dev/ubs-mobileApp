import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:ubs/model/cats_bord.dart';
import 'package:ubs/pages/Chats/widgets/style.dart';
import 'package:ubs/sharing_widget/widget_fun.dart';
import 'package:ubs/utils/constants.dart';

class ChatsListTitle extends StatelessWidget {
  final ChatBoard chatData;
  const ChatsListTitle({Key? key, required this.chatData}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final DateFormat formatter = DateFormat('yyyy-MMM-dd');

    return GestureDetector(
      onTap: () {
        Navigator.pushNamed(context, "/chatdetails");
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
                          chatData.postImg,
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
                          chatData.userImg,
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
                        chatData.userName,
                        style: titleTextStyle,
                      ),
                      Text(
                        chatData.postTitle,
                        maxLines: 1,
                        softWrap: false,
                        overflow: TextOverflow.ellipsis,
                        style: postTitleStyle,
                      ),
                      Row(
                        children: [
                          Icon(
                            chatData.messageStatus == "read"
                                ? Icons.done_all_outlined
                                : Icons.done,
                            color: Colors.blueGrey.shade200,
                            size: 20,
                          ),
                          addHorizontalSpace(5),
                          Text(
                            chatData.lastMessage,
                            style: lmsgStyle,
                          )
                        ],
                      ),
                    ],
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      Text(
                        formatter.format(chatData.userLastSeen) + "   ",
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
