import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:ubs/model/user_login.dart';
import 'package:ubs/pages/chats/chats_dashboard/widgets/chats_list_tiles.dart';
import 'package:ubs/pages/chats/chats_dashboard/widgets/empty_screen.dart';
import 'package:ubs/pages/chats/controller/chats_controller.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ChatsRoomAll extends StatelessWidget {
  final UserLogin userLogin;
  List<QueryDocumentSnapshot<Object?>> userList;
  ChatsRoomAll({super.key, required this.userLogin, required this.userList});

  @override
  Widget build(BuildContext context) {
    var userData = userList;
    return userList.isNotEmpty
        ? Padding(
            padding: EdgeInsets.only(top: 20.sp),
            child: ListView.builder(
              shrinkWrap: true,
              itemCount: userData.length,
              itemBuilder: (BuildContext context, int index) {
                // DocumentSnapshot doc = data!.docs[index];
                DocumentSnapshot doc = userData[index];
                var data = ChatUserList(
                  docId: doc.id,
                  pId: doc.get("adsPostId"),
                  userId: doc.get("users")[0] == userLogin.userId
                      ? doc.get("users")[1]
                      : doc.get("users")[0],
                  postType: doc.get("sellingUser") == userLogin.userId
                      ? "sale"
                      : "buy",
                );
                return ChatsListTitle(userList: data, userId: userLogin.userId);
              },
            ),
          )
        : const EmptyScreen(
            title_1: "You've got no message so far!",
            btnTitle: "Start To Explore");
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
            