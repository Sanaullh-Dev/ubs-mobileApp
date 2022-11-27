import 'package:badges/badges.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:ubs/model/chats_room.dart';
import 'package:ubs/pages/chats/chat_individual/charts_individual.dart';
import 'package:ubs/pages/chats/controller/chats_controller.dart';
import 'package:ubs/sharing_widget/show_image.dart';
import 'package:ubs/sharing_widget/widget_fun.dart';
import 'package:ubs/utils/constants.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:ubs/utils/custom_fun.dart';
import 'package:ubs/utils/text_style.dart';

class ChatsListTitle extends StatefulWidget {
  // final ChatsRoomModel chatRoom;
  final String userId;
  final DocumentSnapshot doc;
  const ChatsListTitle(
      {super.key,
      // required this.chatRoom,
      required this.userId,
      required this.doc});

  @override
  State<ChatsListTitle> createState() => _ChatsListTitleState();
}

class _ChatsListTitleState extends State<ChatsListTitle> {
  final DateFormat formatter = DateFormat('yyyy-MMM-dd');
  final DateFormat showFormat = DateFormat('dd-MMM-yy');
  final ChatsController chatsController = Get.find<ChatsController>();
  Rx<bool> loading = true.obs;
  Rx<ChatsRoomModel> chatRoom = ChatsRoomModel(
    pId: 1,
    pTitle: "",
    pPrice: 0,
    pImage: "",
    userId: "",
    userName: "",
  ).obs;

  @override
  void initState() {
    super.initState();
    getTileData();
  }

  getTileData() async {
    loading.value = true;
    chatRoom.value =
        await chatsController.getUserData(widget.doc, widget.userId) ??
            chatRoom.value;
    loading.value = false;
    chatRoom.value = await chatsController.getUserMessage(chatRoom.value);
  }

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => loading.value
          ? const SizedBox()
          : GestureDetector(
              onTap: () => Get.to(ChatsIndividual(
                  chatRoom: chatRoom.value, userId: widget.userId)),
              child: Container(
                width: double.infinity,
                height: 200.sp,
                padding: EdgeInsets.symmetric(vertical: 25.sp, horizontal: 10),
                decoration: BoxDecoration(
                  color: whiteColor,
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
                          borderRadius: BorderRadius.circular(100),
                          badgeContent: Container(
                              decoration: BoxDecoration(
                                  border: Border.all(
                                      width: 5.sp, color: primaryColor),
                                  borderRadius: BorderRadius.circular(50)),
                              height: 90.sp,
                              width: 90.sp,
                              child: ClipRRect(
                                  borderRadius: BorderRadius.circular(50),
                                  child: ShowUPhoto(
                                      imageUrl:
                                          getLink(chatRoom.value.userPhoto)))),
                          position: BadgePosition.bottomEnd(),
                          child: SizedBox(
                              width: 150.sp,
                              height: 150.sp,
                              child: ShowImage(
                                  imageUrl: getLink(chatRoom.value.pImage))),
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
                              Text(chatRoom.value.userName.toUpperCase(),
                                  style: heading6.copyWith(
                                      fontWeight: FontWeight.w600)),
                              Padding(
                                padding: EdgeInsets.only(right: 40.sp),
                                child: chatRoom.value.lastSeen == null
                                    ? const SizedBox()
                                    : Text(
                                        showFormat.format(DateTime.parse(
                                            chatRoom.value.lastSeen!)),
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
                                      chatRoom.value.pTitle,
                                      maxLines: 1,
                                      softWrap: false,
                                      overflow: TextOverflow.ellipsis,
                                      style: subtitleLabel.copyWith(
                                          fontSize: 29.sp),
                                    ),
                                  ),
                                  // const SizedBox(height: 5),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      chatRoom.value.magStatus == ""
                                          ? const SizedBox()
                                          : Icon(
                                              Icons.done_all_outlined,
                                              color: chatRoom.value.magStatus ==
                                                      "read"
                                                  ? Colors.blueAccent
                                                  : Colors.blueGrey.shade200,
                                              size: 35.sp,
                                            ),
                                      const SizedBox(width: 5),
                                      SizedBox(
                                        width: 260.sp,
                                        child: Text(
                                          chatRoom.value.lastMag!,
                                          maxLines: 1,
                                          softWrap: false,
                                          overflow: TextOverflow.ellipsis,
                                          style: subTitle2.copyWith(
                                              fontSize: 24.sp),
                                        ),
                                      )
                                    ],
                                  ),
                                ],
                              ),
                              IconButton(
                                  onPressed: () {},
                                  icon: Icon(Icons.more_vert_outlined,
                                      size: 65.sp, color: blackColor))
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
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
