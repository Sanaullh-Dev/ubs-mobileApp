import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ubs/model/user_login.dart';
import 'package:ubs/pages/chats/chats_dashboard/widgets/chats_list_tiles.dart';
import 'package:ubs/pages/chats/chats_dashboard/widgets/empty_screen.dart';
import 'package:ubs/pages/chats/controller/chats_controller.dart';

class ChatsRoomBuy extends StatefulWidget {
  final UserLogin userLogin;
  const ChatsRoomBuy({super.key, required this.userLogin});

  @override
  State<ChatsRoomBuy> createState() => _ChatsRoomBuyState();
}

class _ChatsRoomBuyState extends State<ChatsRoomBuy> {
  final ChatsController chatsController = Get.find<ChatsController>();
  Rx<bool> isEmpty = true.obs;

  @override
  void initState() {
    super.initState();
    for (var i = 0; i < chatsController.chatsRooms.length; i++) {
      if (chatsController.chatsRooms[i].postType == "buy") {
        isEmpty.value = false;
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    // final TextTheme textTheme = Theme.of(context).textTheme;
    return RefreshIndicator(
      onRefresh: () async {
        chatsController.getChatsRoomsList(widget.userLogin.userId);
      },
      child: Obx(() => chatsController.isLoading.value == true
          ? const Center(child: CircularProgressIndicator())
          : isEmpty.value
              ? const EmptyScreen(
                  title_1: "You've got no message so far!",
                  title_2: "Be the first one to begin a conversation.",
                  btnTitle: "Start Messaging")
              : Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 15),
                    ListView.builder(
                      shrinkWrap: true,
                      itemCount: chatsController.chatsRooms.length,
                      itemBuilder: (BuildContext context, int index) {
                        var val = chatsController.chatsRooms[index];
                        return val.postType != "buy"
                            ? const SizedBox()
                            : ChatsListTitle(
                                chatRoom: val, userId: widget.userLogin.userId);
                      },
                    )
                  ],
                )),
    );
  }
}


  // StreamBuilder<QuerySnapshot>(
  //   stream: chatsController.chatsRoom.value,
  //   builder: (context, snapshot) {
  //     if (snapshot.hasError) {
  //       return const Text('Something went wrong');
  //     }
  //     if (snapshot.connectionState == ConnectionState.waiting) {
  //       return const Text("Loading");
  //     }
  //     if (snapshot.data!.docs.isNotEmpty) {
        
  //       return ListView.builder(
  //         shrinkWrap: true,
  //         itemCount: snapshot.data!.docs.length,
  //         itemBuilder: (BuildContext context, int index) {
  //           DocumentSnapshot data = snapshot.data!.docs[index];
  //           String userName = getAdsUser( data['chatsUser']);
  //           // return ChatsListTitle(chatData: ,);
  //           return ListTile(title: Text(data['adsPostUsers']));
  //         },
  //       );
  //     }
  //     return const Center(child: Text("Data not"));

  //     // return ListView(
  //     //   shrinkWrap: true,
  //     //   children:
  //     //       snapshot.data!.docs.map((DocumentSnapshot document) {
  //     //     Map<String, dynamic> data =
  //     //         document.data()! as Map<String, dynamic>;
  //     //     return ListTile(
  //     //       title: Text(data['name']),
  //     //     );
  //     //   }).toList(),
  //     // );
  //   }),
            