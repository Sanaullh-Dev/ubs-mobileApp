import 'package:badges/badges.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_keyboard_visibility/flutter_keyboard_visibility.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';
import 'package:ubs/model/chats_room.dart';
import 'package:ubs/model/massage_model.dart';
import 'package:ubs/pages/chats/chat_individual/widget/own_message.dart';
import 'package:ubs/pages/chats/chat_individual/widget/own_offer_message.dart';
import 'package:ubs/pages/chats/chat_individual/widget/replay_message.dart';
import 'package:ubs/pages/chats/chat_individual/widget/replay_offer_message.dart';
import 'package:ubs/pages/chats/chats_dashboard/widgets/chats_list_tiles.dart';
import 'package:ubs/pages/chats/chats_dashboard/widgets/filters_btn.dart';
import 'package:ubs/pages/chats/controller/chats_controller.dart';
import 'package:ubs/services/firestore_service.dart';
import 'package:ubs/sharing_widget/show_image.dart';
import 'package:ubs/sharing_widget/widget_fun.dart';
import 'package:ubs/utils/constants.dart';
import 'package:ubs/utils/custom_fun.dart';
import 'package:ubs/utils/text_style.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ChatsIndividual extends StatefulWidget {
  final String userId;
  final ChatsRoomModel chatRoom;
  const ChatsIndividual(
      {super.key, required this.userId, required this.chatRoom});

  @override
  State<ChatsIndividual> createState() => _ChatsIndividualState();
}

class _ChatsIndividualState extends State<ChatsIndividual>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  final PanelController _panelController = PanelController();
  TextEditingController messageBox = TextEditingController();
  List<int> priceList = [];
  List<String> chatsList = [
    "Is it sill available?",
    "Let's meet up?",
    "What's is last prices?",
    "Could you share some picture?"
  ];
  TextEditingController priceText = TextEditingController();
  final ChatsController chatsCont = Get.find<ChatsController>();

  @override
  void initState() {
    super.initState();
    _tabController = TabController(initialIndex: 0, length: 2, vsync: this);
    chatsCont.getChatsHistory(widget.chatRoom.docId!);
    chatsCont.adsPrice.value = widget.chatRoom.pPrice.toDouble();
    priceText.text = chatsCont.adsPrice.value.toString();
    getPriceList();
  }

  getPriceList() {
    var price = widget.chatRoom.pPrice;
    var amt = price - (price * 20 / 100);
    for (var i = 0; i < 4; i++) {
      priceList.add(amt.round());
      amt = amt + (price * 10 / 100);
    }
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    ChatsRoomModel chatRoom = widget.chatRoom;

    return SafeArea(
      child: Stack(
        children: [
          ColorFiltered(
            colorFilter:
                const ColorFilter.mode(Colors.white, BlendMode.saturation),
            child: Image.asset(
              "lib/assets/images/bgimg.jpg",
              height: size.height,
              width: size.width,
              fit: BoxFit.cover,
            ),
          ),
          KeyboardVisibilityBuilder(builder: (context, _visible) {
            return Scaffold(
                backgroundColor: Colors.blueGrey.shade100.withAlpha(210),
                appBar: PreferredSize(
                  preferredSize: Size.fromHeight(160.sp),
                  // here the desired height
                  child: AppBar(
                    toolbarHeight: 150.sp,
                    leadingWidth: 80.sp,
                    leading: IconButton(
                        padding: EdgeInsets.all(32.sp),
                        icon: const Icon(Icons.arrow_back),
                        onPressed: () => Get.back()),
                    title: Row(
                      children: [
                        SizedBox(
                          height: 120.sp,
                          width: 120.sp,
                          child: Badge(
                            badgeColor: Colors.white,
                            padding: const EdgeInsets.all(0),
                            badgeContent: SizedBox(
                                height: 60.sp,
                                width: 60.sp,
                                child: ShowUPhoto(
                                    imageUrl: getLink(chatRoom.userPhoto))),
                            position: BadgePosition.bottomEnd(),
                            child: SizedBox(
                                width: 130.sp,
                                height: 130.sp,
                                child: ShowImage(
                                    imageUrl: getLink(chatRoom.pImage))),
                          ),
                        ),
                        const SizedBox(width: 15),
                        SizedBox(
                          width: size.width * 0.40,
                          child: Text(chatRoom.userName,
                              overflow: TextOverflow.ellipsis,
                              softWrap: false,
                              maxLines: 2,                              
                              style: titleLabel.copyWith(
                                fontSize: 28.sp,
                                  fontWeight: FontWeight.w800)),
                        ),
                        const Spacer(),
                        Icon(FontAwesomeIcons.phone, size: 45.sp),
                        const SizedBox(width: 15),
                        IconButton(
                            onPressed: () {},
                            icon: Icon(Icons.more_vert, size: 60.sp))
                      ],
                    ),
                    elevation: 0,
                  ),
                ),
                body: Obx(
                  () => Stack(
                    children: [
                      SizedBox(
                        height: size.height - 360.sp,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Container(
                              decoration:
                                  BoxDecoration(color: whiteColor, boxShadow: [
                                BoxShadow(
                                  color: Colors.black.withAlpha(100),
                                  blurRadius: 4.0,
                                )
                              ]),
                              padding: EdgeInsets.symmetric(
                                  vertical: 30.sp, horizontal: 60.sp),
                              // margin: EdgeInsets.zero,
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    chatRoom.pTitle,
                                    style: buttonTextLight,
                                    overflow: TextOverflow.ellipsis,
                                    softWrap: false,
                                    maxLines: 1,
                                  ),
                                  Text("₹ ${chatRoom.pPrice}",
                                      style: buttonTextLight),
                                ],
                              ),
                            ),
                            const SizedBox(height: 2),
                            Expanded(
                              child: StreamBuilder<QuerySnapshot>(
                                  stream: chatsCont.chatsHistory,
                                  builder: (context, snapshot) {
                                    if (snapshot.hasError) {
                                      return const Center(
                                          child: Text('Something went wrong'));
                                    }
                                    if (snapshot.connectionState ==
                                        ConnectionState.waiting) {
                                      return const Center(
                                          child: Text("Loading"));
                                    }
                                    if (snapshot.data!.docs.isNotEmpty) {
                                      return ListView.builder(
                                        shrinkWrap: true,
                                        itemCount: snapshot.data!.docs.length,
                                        itemBuilder:
                                            (BuildContext context, int index) {
                                          // here update message status to red
                                          DocumentSnapshot data =
                                              snapshot.data!.docs[index];
                                          if (data["sendBy"] != widget.userId) {
                                            FirestoreDatabaseHelper
                                                .updateMessageStatus(
                                                    chatRoomId: chatRoom.docId!,
                                                    docId: data.id);
                                          }
                                          var da = getMessageData(data);
                                          return data["sendBy"] == widget.userId
                                              ? data["messageType"] == "text"
                                                  ? OwnMessage(messageData: da)
                                                  : OwnOfferMessage(
                                                      messageData: da)
                                              : data["messageType"] == "text"
                                                  ? ReplyMessage(
                                                      messageData: da)
                                                  : ReplyOfferMessage(
                                                      messageData: da);
                                        },
                                      );
                                    }
                                    return const SizedBox();
                                  }),
                            ),
                          ],
                        ),
                      ),
                      slidingUpBox(size, _visible)
                    ],
                  ),
                ));
          }),
        ],
      ),
    );
  }

  Widget slidingUpBox(Size size, bool visible) {
    // RxBool keyboardVisible = visible.obs;
    double maxHeight = 280.sp;
    return SlidingUpPanel(
      maxHeight: chatsCont.tabIndex.value == 0
          ? chatsCont.isTyping.value
              ? maxHeight
              : 700.sp
          : 700.sp,
      minHeight: 170.sp,
      defaultPanelState: PanelState.OPEN,
      controller: _panelController,
      header: Container(
        padding: const EdgeInsets.symmetric(horizontal: 15),
        width: size.width,
        height: 170.sp,
        color: Colors.transparent,
        child: Stack(
          children: [
            Padding(
                padding: EdgeInsets.only(top: 35.sp, bottom: 35.sp),
                child: KeyboardDismissOnTap(
                  dismissOnCapturedTaps: true,
                  child: TabBar(
                    controller: _tabController,
                    indicatorWeight: 2,
                    indicatorColor: indicatorColor,
                    labelPadding: EdgeInsets.only(bottom: 30.sp, top: 15.sp),
                    onTap: ((index) {
                      chatsCont.isTyping.value = false;
                      chatsCont.tabIndex.value = index;
                      _panelController.open();
                    }),
                    tabs: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(FontAwesomeIcons.message, size: 45.sp),
                          addHorizontalSpace(12),
                          Text("Chart", style: TextStyle(fontSize: 32.sp)),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(FontAwesomeIcons.handPointer, size: 45.sp),
                          addHorizontalSpace(12),
                          Text("Make Offer", style: TextStyle(fontSize: 32.sp)),
                        ],
                      ),
                    ],
                  ),
                )),
          ],
        ),
      ),
      panel: Container(
        color: Colors.white,
        margin: EdgeInsets.only(top: 150.sp),
        child: TabBarView(
          physics: const NeverScrollableScrollPhysics(),
          controller: _tabController,
          children: [
            Stack(
              children: [
                Padding(
                  padding:
                      EdgeInsets.symmetric(horizontal: 15.sp, vertical: 25.sp),
                  child: Wrap(children: [
                    for (var item in chatsList)
                      ChatsTag(
                        tagTitle: item,
                        onPress: () => chatsCont
                            .saveMessage(
                                docId: widget.chatRoom.docId!,
                                message: item,
                                loggedUid: widget.userId,
                                postType: "text")
                            .then((value) =>
                                value == true ? messageBox.text = "" : null),
                      )
                  ]),
                ),
                Align(
                  alignment: Alignment.bottomCenter,
                  child: Container(
                    padding: EdgeInsets.symmetric(
                        vertical: 20.sp, horizontal: 20.sp),
                    margin:
                        EdgeInsets.only(left: 4.sp, right: 4.sp, bottom: 4.sp),
                    decoration: BoxDecoration(
                        color: Colors.white,
                        border: Border(
                          top: BorderSide(width: 2.sp, color: blackColor),
                          // bottom: BorderSide(width: 1, color: blackColor),
                        )),
                    child: Padding(
                      padding: const EdgeInsets.all(0),
                      child: TextField(
                        controller: messageBox,
                        onTap: () {
                          chatsCont.isTyping.value = true;
                        },
                        onChanged: (String e) {
                          double numLines = '\n'.allMatches(e).length + 1;
                          if (numLines >= 1 && numLines < 5) {
                            maxHeight = 90 + (25 * numLines);
                          }
                        },
                        textAlignVertical: TextAlignVertical.center,
                        keyboardType: TextInputType.multiline,
                        maxLines: 5,
                        minLines: 1,
                        style: TextStyle(
                          fontSize: 38.sp,
                        ),
                        decoration: InputDecoration(
                          hintText: "Type a message",
                          border: InputBorder.none,
                          prefixIcon: Padding(
                            padding: EdgeInsets.only(right: 16.sp),
                            child: Icon(FontAwesomeIcons.pen,
                                color: indicatorColor, size: 40.sp),
                          ),
                          suffixIcon: TextButton(
                              onPressed: () async {
                                chatsCont
                                    .saveMessage(
                                        docId: widget.chatRoom.docId!,
                                        loggedUid: widget.userId,
                                        message: messageBox.text,
                                        postType: "text")
                                    .then((value) => value == true
                                        ? messageBox.text = ""
                                        : null);
                              },
                              style: TextButton.styleFrom(
                                backgroundColor: primaryColor,
                                shape: const CircleBorder(),
                              ),
                              child: Icon(
                                Icons.send,
                                color: Colors.white,
                                size: 50.sp,
                              )),
                          hintStyle: TextStyle(
                            fontSize: 35.sp,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
            Container(
              height: double.infinity,
              width: double.infinity,
              padding: EdgeInsets.symmetric(horizontal: 20.sp),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Wrap(children: [
                    for (var item in priceList)
                      PriceTag(
                        tagTitle: item.toString(),
                        onPress: () {
                          priceText.text = item.toString();
                          chatsCont
                              .saveMessage(
                                  docId: widget.chatRoom.docId!,
                                  message: item.toString(),
                                  loggedUid: widget.userId,
                                  postType: "offer")
                              .then((value) =>
                                  value == true ? messageBox.text = "" : null);
                        },
                      ),
                  ]),
                  SizedBox(height: 30.sp),
                  Row(
                    children: [
                      SizedBox(width: 50.sp),
                      SizedBox(
                        width: 500.sp,
                        height: 80.sp,
                        child: TextField(
                            controller: priceText,
                            keyboardType: TextInputType.number,
                            decoration: InputDecoration(
                                contentPadding:
                                    EdgeInsets.symmetric(vertical: 25.sp),
                                prefixIconConstraints: BoxConstraints(
                                    maxWidth: 55.sp,
                                    minWidth: 50.sp,
                                    maxHeight: 45.sp),
                                prefixIcon: Text("₹", style: heading2InBold)),
                            style: heading2InBold,
                            onChanged: (val) {
                              if (val == "") {
                                chatsCont.adsPrice.value = 0;
                              } else if (val.isNum) {
                                chatsCont.adsPrice.value = double.parse(val);
                              }
                            }),
                      ),
                      const Spacer(),
                      ElevatedButton(
                          onPressed: () {
                            if (priceText.text != "") {
                              chatsCont
                                  .saveMessage(
                                      docId: widget.chatRoom.docId!,
                                      message: priceText.text,
                                      loggedUid: widget.userId,
                                      postType: "offer")
                                  .then((value) => value == true
                                      ? messageBox.text = ""
                                      : null);
                            }
                          },
                          child: Padding(
                            padding: EdgeInsets.symmetric(
                                vertical: 35.sp, horizontal: 45.sp),
                            child: Text("Send", style: btnText),
                          )),
                      SizedBox(width: 20.sp),
                    ],
                  ),
                  SizedBox(height: 40.sp),
                  Row(
                    children: [
                      Container(
                        width: size.width - 40,
                        color: getOffersColor(widget.chatRoom.pPrice.toDouble(),
                            chatsCont.adsPrice.toDouble()),
                        padding: EdgeInsets.symmetric(
                            vertical: 18.sp, horizontal: 30.sp),
                        // height: 15,
                        // color: Colors.red,
                        child: Row(
                          children: [
                            Icon(FontAwesomeIcons.handHoldingHand,
                                color: Colors.black, size: 55.sp),
                            SizedBox(width: 40.sp),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                    getOffersTitle(
                                        widget.chatRoom.pPrice.toDouble(),
                                        chatsCont.adsPrice.toDouble()),
                                    style: titleLabel.copyWith(
                                        fontWeight: FontWeight.w700)),
                                SizedBox(
                                  width: size.width - 160,
                                  child: Text(
                                      getOffersSubtitle(
                                          widget.chatRoom.pPrice.toDouble(),
                                          chatsCont.adsPrice.toDouble()),
                                      overflow: TextOverflow.ellipsis,
                                      softWrap: false,
                                      maxLines: 2,
                                      style: subtitleLabel.copyWith(
                                          fontSize: 23.sp)),
                                ),
                              ],
                              // save
                            )
                          ],
                        ),
                      ),
                    ],
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  Color getOffersColor(double orgPrice, double offersPrice) {
    var minPrice = orgPrice - (orgPrice * 0.4);

    if (offersPrice < minPrice) {
      return Colors.redAccent;
    } else if (offersPrice >= minPrice && offersPrice <= orgPrice) {
      return Colors.greenAccent;
    }
    return Colors.yellowAccent;
  }

  String getOffersTitle(double orgPrice, double offersPrice) {
    var minPrice = orgPrice - (orgPrice * 0.4);

    if (offersPrice < minPrice) {
      return "Offers price is low!";
    } else if (offersPrice >= minPrice && offersPrice <= orgPrice) {
      return "Good offers!";
    }
    return "Rickey offer";
  }

  String getOffersSubtitle(double orgPrice, double offersPrice) {
    var minPrice = orgPrice - (orgPrice * 0.4);

    if (offersPrice < minPrice) {
      return "Please increase the offer price,so better chance to deal.";
    } else if (offersPrice >= minPrice && offersPrice <= orgPrice) {
      return "This offer to high changes of responses.";
    }
    return "Please original price for offering";
  }

  MessageModel getMessageData(DocumentSnapshot data) {
    return MessageModel(
        message: data["message"],
        messageType: data["messageType"],
        sendBy: data["sendBy"],
        status: data["status"],
        time: DateTime.parse(data["time"]));
  }
}
