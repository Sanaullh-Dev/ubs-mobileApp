import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ubs/model/user_login.dart';
import 'package:ubs/pages/chats/chats_dashboard/widgets/chats_ListTiles.dart';
import 'package:ubs/pages/chats/controller/chats_controller.dart';

class ChartFirebase1 extends StatefulWidget {
  final UserLogin userLogin;
  const ChartFirebase1({super.key, required this.userLogin});

  @override
  State<ChartFirebase1> createState() => _ChartFirebase1State();
}

class _ChartFirebase1State extends State<ChartFirebase1> {
  final ChatsController chatsController = Get.find<ChatsController>();

  @override
  void initState() {
    super.initState();
    if (chatsController.chatsRooms.value.isEmpty) {
      chatsController.getChatsRoomsList(widget.userLogin.userId);
    }
  }

  @override
  Widget build(BuildContext context) {
    // final TextTheme textTheme = Theme.of(context).textTheme; recved
    return Obx(() => chatsController.isLoading.value == true
        ? const Center(child: CircularProgressIndicator())
        : SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 15),
                // Padding(
                //   padding: const EdgeInsets.only(top: 8, bottom: 4, left: 15),
                //   child: Text(
                //     "Quick Filters",
                //     style:
                //         TextStyle(fontSize: 35.sp, fontWeight: FontWeight.w500),
                //   ),
                // ),
                // Padding(
                //   padding:
                //       const EdgeInsets.symmetric(vertical: 3, horizontal: 10),
                //   child: Wrap(
                //     children: [
                //       const FiltersButtons(btnTitle: "All", isActive: true),
                //       addHorizontalSpace(15),
                //       const FiltersButtons(
                //         btnTitle: "Meeting",
                //         isActive: false,
                //       ),
                //       addHorizontalSpace(15),
                //       const FiltersButtons(
                //         btnTitle: "Unread",
                //         isActive: false,
                //       ),
                //       addHorizontalSpace(15),
                //       const FiltersButtons(
                //         btnTitle: "Imports",
                //         isActive: false,
                //       ),
                //     ],
                //   ),
                // ),
                ListView.builder(
                  shrinkWrap: true,
                  itemCount: chatsController.chatsRooms.length,
                  itemBuilder: (BuildContext context, int index) {
                    var val = chatsController.chatsRooms[index];
                    return ChatsListTitle(
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
            