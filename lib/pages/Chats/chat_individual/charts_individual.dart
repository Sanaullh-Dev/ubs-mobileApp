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
import 'package:ubs/pages/chats/chats_dashboard/widgets/chats_ListTiles.dart';
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
  RxBool isTyping = false.obs;
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
                preferredSize:
                    const Size.fromHeight(80.0), // here the desired height
                child: AppBar(
                  toolbarHeight: 70,
                  leadingWidth: 40,
                  leading: IconButton(
                      padding: const EdgeInsets.all(17),
                      icon: const Icon(Icons.arrow_back),
                      onPressed: () => Get.back()),
                  title: Row(
                    children: [
                      SizedBox(
                        height: 50,
                        width: 50,
                        child: Badge(
                          badgeColor: Colors.white,
                          padding: const EdgeInsets.all(0),
                          badgeContent: SizedBox(
                              height: 30,
                              width: 30,
                              child: ShowUPhoto(
                                  imageUrl: getLink(chatRoom.userPhoto))),
                          position: BadgePosition.bottomEnd(),
                          child: SizedBox(
                              width: 50,
                              height: 50,
                              child: ShowImage(
                                  imageUrl: getLink(chatRoom.pImage))),
                        ),
                      ),
                      const SizedBox(width: 15),
                      Text(chatRoom.userName,
                          style:
                              titleLabel.copyWith(fontWeight: FontWeight.w800)),
                      const Spacer(),
                      const Icon(FontAwesomeIcons.phone),
                      const SizedBox(width: 15),
                      IconButton(
                          onPressed: () {}, icon: const Icon(Icons.more_vert))
                    ],
                  ),
                  elevation: 0,
                ),
              ),
              body: Stack(
                children: [
                  Column(
                    children: [
                      Container(
                        decoration:
                            BoxDecoration(color: COLOR_WHITE, boxShadow: [
                          BoxShadow(
                            color: Colors.black.withAlpha(100),
                            blurRadius: 4.0,
                          )
                        ]),
                        padding: const EdgeInsets.symmetric(
                            vertical: 15, horizontal: 30),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(chatRoom.pTitle, style: buttonTextLight),
                            Text("₹ ${chatRoom.pPrice}",
                                style: buttonTextLight),
                          ],
                        ),
                      ),
                      const SizedBox(height: 10),
                      StreamBuilder<QuerySnapshot>(
                          stream: chatsCont.chatsHistory,
                          builder: (context, snapshot) {
                            if (snapshot.hasError) {
                              return const Center(
                                  child: Text('Something went wrong'));
                            }
                            if (snapshot.connectionState ==
                                ConnectionState.waiting) {
                              return const Center(child: Text("Loading"));
                            }
                            if (snapshot.data!.docs.isNotEmpty) {
                              return ListView.builder(
                                shrinkWrap: true,
                                itemCount: snapshot.data!.docs.length,
                                itemBuilder: (BuildContext context, int index) {
                                  // here update ther message status to red
                                  DocumentSnapshot data =
                                      snapshot.data!.docs[index];
                                  if (data["sendBy"] != widget.userId) {
                                    FirestoreDatabaseHelper.updateMessageStatus(
                                        chatRoomId: chatRoom.docId!,
                                        docId: data.id);
                                  }
                                  var da = getMessageData(data);
                                  return data["sendBy"] == widget.userId
                                      ? data["messageType"] == "text"
                                          ? OwnMessage(messageData: da)
                                          : OwnOfferMessage(messageData: da)
                                      : data["messageType"] == "text"
                                          ? ReplyMessage(messageData: da)
                                          : ReplyOfferMessage(messageData: da);
                                },
                              );
                            }
                            return const Center(child: Text("Data not"));
                          }),
                    ],
                  ),
                  slidingUpBox(size, _visible)
                ],
              ),
            );
          }),
        ],
      ),
    );
  }

  Widget slidingUpBox(Size size, bool visible) {
    double maxHeight = 140;

    return SlidingUpPanel(
      maxHeight: visible ? maxHeight : 350,
      minHeight: 60,
      defaultPanelState: PanelState.OPEN,
      controller: _panelController,
      header: Container(
        padding: const EdgeInsets.symmetric(horizontal: 15),
        width: size.width,
        height: 60,
        color: Colors.white70,
        child: Stack(
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 20),
              child: TabBar(
                controller: _tabController,
                indicatorWeight: 3,
                indicatorColor: COLOR_INDICATOR,
                labelPadding: const EdgeInsets.only(bottom: 15),
                tabs: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Icon(
                        FontAwesomeIcons.message,
                        size: 25,
                      ),
                      addHorizontalSpace(12),
                      const Text(
                        "Chart",
                        style: TextStyle(fontSize: 16),
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Icon(
                        FontAwesomeIcons.handPointer,
                        size: 25,
                      ),
                      addHorizontalSpace(12),
                      const Text(
                        "Make Offer",
                        style: TextStyle(fontSize: 16),
                      ),
                    ],
                  )
                ],
              ),
            ),
          ],
        ),
      ),
      panel: Container(
        margin: const EdgeInsets.only(top: 70),
        child: TabBarView(
          controller: _tabController,
          children: [
            Stack(
              children: [
                // suggestion Text
                Visibility(
                  visible: !visible,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 15, vertical: 15),
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
                ),
                Align(
                  alignment: Alignment.bottomCenter,
                  child: Container(
                    padding:
                        const EdgeInsets.symmetric(vertical: 10, horizontal: 12),
                    margin: EdgeInsets.only(left: 2, right: 2, bottom: 2),
                    decoration: const BoxDecoration(
                        border: Border(
                      top: BorderSide(width: 2, color: COLOR_BLACK),
                      // bottom: BorderSide(width: 1, color: COLOR_BLACK),
                    )),
                    child: Padding(
                      padding: const EdgeInsets.all(0),
                      child: TextField(
                        controller: messageBox,
                        onTap: () {
                          isTyping.value = true;
                          setState(() {});
                        },
                        onChanged: (String e) {
                          setState(() {
                            double numLines = '\n'.allMatches(e).length + 1;
                            if (numLines >= 1 && numLines < 5) {
                              maxHeight = 90 + (25 * numLines);
                            }
                          });
                        },
                        textAlignVertical: TextAlignVertical.center,
                        keyboardType: TextInputType.multiline,
                        maxLines: 5,
                        minLines: 1,
                        style: const TextStyle(
                          fontSize: 20,
                        ),
                        decoration: InputDecoration(
                          hintText: "Type a message",
                          border: InputBorder.none,
                          prefixIcon: const Padding(
                            padding: EdgeInsets.only(right: 8),
                            child: Icon(
                              // FontAwesomeIcons.paperclip,
                              FontAwesomeIcons.pen,
                              color: COLOR_INDICATOR,
                              size: 25,
                            ),
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
                                backgroundColor: COLOR_PRIMARY,
                                shape: const CircleBorder(),
                              ),
                              child: const Icon(
                                Icons.send,
                                color: Colors.white,
                              )),
                          hintStyle: const TextStyle(
                            fontSize: 20,
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
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Wrap(children: [
                    for (var item in priceList)
                      PriceTag(
                          tagTitle: item.toString(),
                          onPress: () => chatsCont
                              .saveMessage(
                                  docId: widget.chatRoom.docId!,
                                  message: item.toString(),
                                  loggedUid: widget.userId,
                                  postType: "offer")
                              .then((value) =>
                                  value == true ? messageBox.text = "" : null))
                  ]),
                  const SizedBox(height: 20),
                  SizedBox(
                    width: 250,
                    child: TextField(
                      controller: priceText,
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(
                          contentPadding: EdgeInsets.zero,
                          prefixIcon: Text("₹", style: heading2InBold)),
                      style: heading2InBold,
                    ),
                  ),
                  const SizedBox(height: 20),
                  Row(
                    children: [
                      Expanded(
                        child: Container(
                          color: COLOR_INDICATOR,
                          padding: const EdgeInsets.symmetric(
                              vertical: 10, horizontal: 15),
                          // height: 15,
                          // color: Colors.red,
                          child: Row(
                            children: [
                              const Icon(FontAwesomeIcons.handHoldingHand,
                                  color: Colors.black, size: 30),
                              const SizedBox(width: 20),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text("Good offer!", style: heading6),
                                  Text("High chances of response",
                                      style: buttonTextStyle),
                                ],
                                // save
                              )
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(width: 30),
                      ElevatedButton(
                          onPressed: () {
                            if (priceText.text != "") {
                              chatsCont
                                  .saveMessage(
                                      docId: widget.chatRoom.docId!,
                                      message: messageBox.text,
                                      loggedUid: widget.userId,
                                      postType: "offer")
                                  .then((value) => value == true
                                      ? messageBox.text = ""
                                      : null);
                            }
                          },
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                                vertical: 18, horizontal: 18),
                            child: Text("Send", style: btnText),
                          )),
                      const SizedBox(width: 10),
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

  MessageModel getMessageData(DocumentSnapshot data) {
    return MessageModel(
        message: data["message"],
        messageType: data["messageType"],
        sendBy: data["sendBy"],
        status: data["status"],
        time: DateTime.parse(data["time"]));
  }
}
