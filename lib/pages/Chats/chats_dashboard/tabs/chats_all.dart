import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ubs/model/user_login.dart';
import 'package:ubs/pages/chats/chats_dashboard/widgets/chats_list_tiles.dart';
import 'package:ubs/pages/chats/chats_dashboard/widgets/empty_screen.dart';
import 'package:ubs/pages/chats/controller/chats_controller.dart';

class ChatsRoomAll extends StatefulWidget {
  final UserLogin userLogin;
  const ChatsRoomAll({super.key, required this.userLogin});

  @override
  State<ChatsRoomAll> createState() => _ChatsRoomAllState();
}

class _ChatsRoomAllState extends State<ChatsRoomAll> {
  final ChatsController chatsController = Get.find<ChatsController>();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // final TextTheme textTheme = Theme.of(context).textTheme;
    return Obx(() => chatsController.isLoading.value == true
        ? const Center(child: CircularProgressIndicator())
        : chatsController.chatsRooms.length == 0
            ? const EmptyScreen(
                title_1: "You've got no message so far!",
                btnTitle: "Start To Explore")
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
            