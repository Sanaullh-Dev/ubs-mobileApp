import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';
import 'package:ubs/model/chats_room.dart';
import 'package:ubs/model/massage_model.dart';
import 'package:ubs/pages/chats/chat_individual/widget/own_message.dart';
import 'package:ubs/pages/chats/chat_individual/widget/replay_message.dart';
import 'package:ubs/pages/chats/chats_dashboard/widgets/chats_ListTiles.dart';
import 'package:ubs/pages/chats/controller/chats_controller.dart';
import 'package:ubs/sharing_widget/widget_fun.dart';
import 'package:ubs/utils/constants.dart';

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
  double maxHeight = 120;
  bool isTyping = false;
  TextEditingController messageBox = TextEditingController();

  final ChatsController chatsCont = Get.find<ChatsController>();

  @override
  void initState() {
    super.initState();
    _tabController = TabController(initialIndex: 0, length: 2, vsync: this);
    chatsCont.getChatsHistory(widget.chatRoom.docId!);
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
          Scaffold(
            backgroundColor: Colors.blueGrey.shade100.withAlpha(210),
            appBar: AppBar(
              title: const Text('Uer Name'),
              elevation: 0,
            ),
            body: Stack(
              children: [
                Column(
                  children: [
                    Container(
                      decoration: BoxDecoration(color: COLOR_WHITE, boxShadow: [
                        BoxShadow(
                          color: Colors.black.withAlpha(100),
                          blurRadius: 4.0,
                        )
                      ]),
                      padding: const EdgeInsets.only(
                          right: 46, top: 10, bottom: 10, left: 14),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            chatRoom.pTitle,
                            style: TextStyle(fontSize: 18, color: Colors.black),
                          ),
                          Text(
                            chatRoom.pPrice.toString(),
                            style: TextStyle(fontSize: 18, color: Colors.black),
                          ),
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
                                DocumentSnapshot data =
                                    snapshot.data!.docs[index];
                                var da = getMessageData(data);
                                return data["sendBy"] == widget.userId
                                    ? OwnMessage(messageData: da)
                                    : ReplyMessage(messageData: da);
                              },
                            );
                          }
                          return const Center(child: Text("Data not"));
                        }),
                  ],
                ),
                // Product Details Bar
                SlidingUpPanel(
                  maxHeight: isTyping == true ? maxHeight : 290,
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
                    margin: const EdgeInsets.only(top: 60),
                    child: TabBarView(
                      controller: _tabController,
                      children: [
                        Stack(
                          children: [
                            Align(
                              alignment: Alignment.bottomCenter,
                              child: Card(
                                margin: EdgeInsets.only(
                                    left: 2,
                                    right: 2,
                                    bottom: MediaQuery.of(context)
                                                .viewInsets
                                                .bottom >
                                            0
                                        ? 0
                                        : 8),
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(0)),
                                child: TextField(
                                  controller: messageBox,
                                  onTap: () {
                                    isTyping = true;
                                    setState(() {});
                                  },
                                  onChanged: (String e) {
                                    setState(() {
                                      double numLines =
                                          '\n'.allMatches(e).length + 1;
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
                                                  chatRoom.docId!,
                                                  messageBox.text,
                                                  widget.userId)
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
                            Visibility(
                              // visible: MediaQuery.of(context).viewInsets.bottom > 0 ? true : false,
                              visible: !isTyping,
                              child: Wrap(
                                children: [
                                  Text(
                                    "Is it available?",
                                  )
                                ],
                              ),
                            )
                          ],
                        ),
                        SizedBox(
                          height: 50,
                        )
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
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
