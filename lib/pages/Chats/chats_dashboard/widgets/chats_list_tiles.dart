import 'package:badges/badges.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:ubs/model/chats_room.dart';
import 'package:ubs/pages/chats/chat_individual/charts_individual.dart';
import 'package:ubs/sharing_widget/show_image.dart';
import 'package:ubs/sharing_widget/widget_fun.dart';
import 'package:ubs/utils/constants.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:ubs/utils/custom_fun.dart';
import 'package:ubs/utils/text_style.dart';

class ChatsListTitle extends StatelessWidget {
  final ChatsRoomModel chatRoom;
  final String userId;
  ChatsListTitle({super.key, required this.chatRoom, required this.userId});
  // const ChatsListTitle({required this.userId});

  final DateFormat formatter = DateFormat('yyyy-MMM-dd');
  final DateFormat showFormat = DateFormat('dd-MMM-yy');
  @override
  Widget build(BuildContext context) {
    // var message = "";
    // DateTime dt = DateTime.now();
    // if (chatRoom.lastSeen != null) {
    //   dt = DateTime.parse(chatRoom.lastSeen!);
    // } else {
    //   dt = DateTime.now();
    //   message = "";
    // }

    return GestureDetector(
      onTap: () => Get.to(ChatsIndividual(chatRoom: chatRoom, userId: userId)),
      child: Container(
        width: double.infinity,
        height: 200.sp,
        padding: EdgeInsets.symmetric(vertical: 25.sp, horizontal: 10),
        decoration: BoxDecoration(
          color: COLOR_WHITE,
          border: Border(
            bottom: BorderSide(
              width: 2.sp,
              color: Colors.blueGrey.shade100,
            ),
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Container(
                padding: const EdgeInsets.all(0),
                width: 170.sp,
                height: 180.sp,
                child: Badge(
                  badgeColor: Colors.white,
                  padding: const EdgeInsets.all(0),
                  badgeContent: SizedBox(
                      height: 80.sp,
                      width: 80.sp,
                      child: ShowUPhoto(imageUrl: getLink(chatRoom.userPhoto))),
                  position: BadgePosition.bottomEnd(),
                  child: SizedBox(
                      width: 150.sp,
                      height: 150.sp,
                      child: ShowImage(imageUrl: getLink(chatRoom.pImage))),
                )),
            addHorizontalSpace(40.sp),
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  SizedBox(height: 10.sp),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(chatRoom.userName.toUpperCase(), style: heading6.copyWith(fontWeight: FontWeight.w600)),
                      Padding(
                        padding: EdgeInsets.only(right: 40.sp),
                        child: chatRoom.lastSeen == null
                            ? const SizedBox()
                            : Text(
                                showFormat
                                    .format(DateTime.parse(chatRoom.lastSeen!)),
                                style: trailingTestStyle),
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(
                            width: 510.sp,
                            child: Text(
                              chatRoom.pTitle,
                              maxLines: 1,
                              softWrap: false,
                              overflow: TextOverflow.ellipsis,
                              style: subtitleLabel.copyWith(fontSize: 29.sp),
                            ),
                          ),
                          // const SizedBox(height: 5),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Icon(
                                // widget.chatRoom.messageStatus == "read"
                                "read" == "read"
                                    ? Icons.done_all_outlined
                                    : Icons.done,
                                color: Colors.blueGrey.shade200,
                                size: 35.sp,
                              ),
                              const SizedBox(width: 5),
                              chatRoom.lastMag == null
                                  ? const SizedBox()
                                  : SizedBox(
                                    width: 260.sp,
                                    child: Text(
                                        chatRoom.lastMag!,
                                        maxLines: 1,
                                        softWrap: false,
                                        overflow: TextOverflow.ellipsis,
                                        style:
                                            subTitle2.copyWith(fontSize: 24.sp),
                                      ),
                                  )
                            ],
                          ),
                        ],
                      ),
                      IconButton(
                          onPressed: () {},
                          icon: Icon(Icons.more_vert_outlined,
                              size: 65.sp, color: COLOR_BLACK))
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

class ShowUPhoto extends StatelessWidget {
  final String imageUrl;
  const ShowUPhoto({super.key, required this.imageUrl});

  @override
  Widget build(BuildContext context) {
    return imageUrl == "" || imageUrl == null
        ? Image.asset(
            "lib/assets/images/user.png",
            fit: BoxFit.cover,
          )
        : Image.network(
            imageUrl,
            fit: BoxFit.fill,
            errorBuilder: (context, error, stackTrace) => Image.asset(
              "lib/assets/images/user.png",
              fit: BoxFit.cover,
            ),
          );
  }
}
