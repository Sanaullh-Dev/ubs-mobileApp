import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:ubs/model/user_login.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:ubs/pages/chats/chats_dashboard/widgets/chats_list_tiles.dart';
import 'package:ubs/pages/chats/chats_dashboard/widgets/empty_screen.dart';
import 'package:ubs/pages/chats/controller/chats_controller.dart';

class ChatsRoomBuy extends StatelessWidget {
  final UserLogin userLogin;
  List<QueryDocumentSnapshot<Object?>> userList;
  ChatsRoomBuy({super.key, required this.userLogin, required this.userList});

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
                if (doc.get("sellingUser") != userLogin.userId) {
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
                  return ChatsListTitle(
                      userList: data, userId: userLogin.userId);
                }
                return const SizedBox();
              },
            ),
          )
        : const EmptyScreen(
            title_1: "You've got no message so far!",
            title_2: "Be the first one to begin a conversation.",
            btnTitle: "Start Messaging");
  }
}
