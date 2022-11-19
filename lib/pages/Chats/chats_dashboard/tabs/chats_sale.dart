import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ubs/model/user_login.dart';
import 'package:ubs/pages/chats/chats_dashboard/widgets/chats_ListTiles.dart';
import 'package:ubs/pages/chats/controller/chats_controller.dart';
import 'package:ubs/utils/text_style.dart';

class ChatsRoomSale extends StatefulWidget {
  final UserLogin userLogin;
  const ChatsRoomSale({super.key, required this.userLogin});

  @override
  State<ChatsRoomSale> createState() => _ChatsRoomSaleState();
}

class _ChatsRoomSaleState extends State<ChatsRoomSale> {
  final ChatsController chatsController = Get.find<ChatsController>();
  Rx<bool> isEmpty = true.obs;

  @override
  void initState() {
    super.initState();
    for (var i = 0; i < chatsController.chatsRooms.length; i++) {
      if (chatsController.chatsRooms[i].postType == "sale") {
        isEmpty.value = false;
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    // final TextTheme textTheme = Theme.of(context).textTheme; recved
    return Obx(() => chatsController.isLoading.value == true
        ? const Center(child: CircularProgressIndicator())
        : isEmpty.value
            ? Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  SizedBox(
                    height: 150,
                    width: 150,
                    child: Image.asset("lib/assets/images/BiS.png"),
                  ),
                  const SizedBox(height: 25),
                  Text("You've got no message so far!", style: heading3),
                  const SizedBox(height: 15),
                  Text("As soon as someone sends you a message",
                      style: heading6),
                  const SizedBox(height: 10),
                  Text("It'll start appearing here.", style: heading6),
                  const SizedBox(height: 25),
                  SizedBox(
                    width: 280,
                    height: 60,
                    child: ElevatedButton(
                      onPressed: () {},
                      child: Text("Start Selling", style: buttonTextLight),
                    ),
                  ),
                  const SizedBox(height: 120),
                ],
              )
            : SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 15),
                    ListView.builder(
                      shrinkWrap: true,
                      itemCount: chatsController.chatsRooms.length,
                      itemBuilder: (BuildContext context, int index) {
                        var val = chatsController.chatsRooms[index];
                        return val.postType != "sale"
                            ? const SizedBox()
                            : ChatsListTitle(
                                chatRoom: val, userId: widget.userLogin.userId);
                      },
                    )
                  ],
                ),
              ));
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
            