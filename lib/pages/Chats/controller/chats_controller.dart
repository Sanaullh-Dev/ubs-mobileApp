import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:ubs/model/ads_post.dart';
import 'package:ubs/model/chats_room.dart';
import 'package:ubs/model/message_data.dart';
import 'package:ubs/services/firestore_service.dart';
import 'package:ubs/services/remote_services.dart';

class ChatsController extends GetxController {
  Stream<QuerySnapshot> chatsRoomStream = const Stream.empty();
  Stream<QuerySnapshot> chatsHistory = const Stream.empty();
  Rx<bool> isLoading = false.obs;
  RxList<ChatsRoomModel> chatsRooms = List<ChatsRoomModel>.empty().obs;
  // RxList<ChatUserList> chatUserList = List<ChatUserList>.empty().obs;
  RxBool isTyping = false.obs;
  RxBool keyboardVisible = false.obs;
  RxInt tabIndex = 0.obs;
  RxDouble adsPrice = 0.0.obs;

  // getLoadData(String userId) async {
  //   if (chatsRooms.value.isEmpty) {
  //     getChatsRoomsList(userId);
  //     if (isLoading.value == true) {
  //       // await getChatsDetails();
  //       // await getUserMessage();
  //     }
  //   }
  // }

  getChatsRoomsList(String userId) async {
    var ck = await chatsRoomStream.isEmpty;
    if (ck) {
      chatsRoomStream = FirestoreDatabaseHelper.chatsRoom
          .where('users', arrayContains: userId)
          .snapshots();
    }
  }

  Future<ChatsRoomModel?> getUserData(var doc, String userId) async {
    var data = ChatUserList(
      docId: doc.id,
      pId: doc.get("adsPostId"),
      userId: doc.get("users")[0] == userId
          ? doc.get("users")[1]
          : doc.get("users")[0],
      postType: doc.get("sellingUser") == userId ? "sale" : "buy",
    );
    // getChatsDetails(data);
    ChatsRoomModel? chatsRoomData =
        await RemoteServices.getChatRoomDetails(data.userId, data.pId);
    if (chatsRoomData != null) {
      chatsRoomData.postType = data.postType;
      chatsRoomData.docId = data.docId;
      chatsRoomData.lastMag = "Loading...";
      chatsRoomData.magStatus = "";
      return chatsRoomData;
    }
    return null;
  }

  Future<ChatsRoomModel> getUserMessage(ChatsRoomModel chatRoom) async {
    await FirestoreDatabaseHelper.chatsRoom
        .doc(chatRoom.docId)
        .collection("chats")
        .orderBy("time", descending: true)
        .limit(1)
        .get()
        .then((value) {
      if (value.docs.isNotEmpty) {
        chatRoom.lastMag = value.docs[0].data()["message"];
        chatRoom.lastSeen = value.docs[0].data()["time"];
        chatRoom.magStatus = value.docs[0].data()["status"];
        return chatRoom;
      }
    });
    return chatRoom;
  }

  // getChatsDetails(ChatsRoomModel chatList) async {
  //   var res =
  //       await RemoteServices.getChatRoomDetails(chatList.userId, chatList.pId);
  //   if (res != null) {
  //     res.postType = chatList.postType;
  //     res.docId = chatList.docId;
  //     res.lastMag = "Loading...";
  //     res.magStatus = "";
  //     var ck =
  //         chatsRooms.value.where((element) => element.docId == chatList.docId);

  //     if (ck.isEmpty) {
  //       chatsRooms.value.add(res);
  //       getUserMessage(res);
  //     } else {
  //       print(ck);
  //     }
  //   }
  // }

  // getChatsDetails() async {
  //   chatsRooms.value = [];
  //   for (var i = 0; i < chatUserList.value.length; i++) {
  //     var val = chatUserList.value[i];
  //     var res = await RemoteServices.getChatRoomDetails(val.userId, val.pId);
  //     if (res != null) {
  //       isLoading.value = true;
  //       res.postType = val.postType;
  //       res.docId = val.docId;
  //       res.lastMag = "Loading...";
  //       res.magStatus = "";
  //       chatsRooms.value.add(res);
  //     }
  //   }
  //   isLoading.value = false;
  // }

  // getUserMessage() async {
  //   for (var i = 0; i < chatsRooms.value.length; i++) {
  //     await FirestoreDatabaseHelper.chatsRoom
  //         .doc(chatsRooms.value[i].docId)
  //         .collection("chats")
  //         .orderBy("time", descending: true)
  //         .limit(1)
  //         .get()
  //         .then((value) {
  //       chatsRooms[i].lastMag = value.docs[0].data()["message"];
  //       chatsRooms[i].lastSeen = value.docs[0].data()["time"];
  //       chatsRooms[i].magStatus = value.docs[0].data()["status"];
  //     });
  //   }
  // }

  getChatsHistory(String docId) {
    chatsHistory = FirestoreDatabaseHelper.chatsRoom
        .doc(docId)
        .collection("chats")
        .orderBy("time")
        .snapshots();
  }

  // Add new chats Room between tow users
  Future<String?> addChatRoom(
      {required String loggedUser, required AdsPost adsPostData}) async {
    // var chatRoomId = getChatRoomId(loggedUser, adsUser);
    // List<String> users = [loggedUser, adsUser];

    var documentId = "${adsPostData.pId}__$loggedUser";
    Map<String, dynamic> chatRoomData = {
      "users": [loggedUser, adsPostData.pUid],
      "sellingUser": adsPostData.pUid,
      "adsPostId": adsPostData.pId,
      "adsStatus": "active"
    };

    return await FirestoreDatabaseHelper.addNewChatRoom(
            docId: documentId, chatRoomData: chatRoomData)
        .then((value) {
      return documentId;
    });
  }

  Future<bool> saveMessage(
      {required String postType,
      required String docId,
      required String message,
      required String loggedUid}) async {
    // final DateFormat format = DateFormat('yyyy-MMM-dd');

    MessageData messageData = MessageData.fromJson({
      "message": message,
      "sendBy": loggedUid,
      "messageType": postType, // this for text-message or offer-message
      "time": DateTime.now().toIso8601String(),
      "status": "unread"
    });

    return await FirestoreDatabaseHelper.saveMessage(
        docId: docId, messageData: messageData.toJson());
  }
}

class ChatUserList {
  ChatUserList(
      {required this.pId,
      required this.userId,
      required this.postType,
      required this.docId});

  int pId;
  String userId;
  String postType;
  String docId;
}

// String getChatRoomId(String user1, String user2) {
//   if (user1.substring(0, 1).codeUnitAt(0) >
//       user2.substring(0, 1).codeUnitAt(0)) {
//     return "${user2}_$user1";
//   } else {
//     return "${user1}_$user2";
//   }
// }


// chatUserList.value.add(
//           ChatUserList(
//             docId: element.id,
//             pId: element.get("adsPostId"),
//             userId: element.get("users")[0] == userId
//                 ? element.get("users")[1]
//                 : element.get("users")[0],
//             postType: element.get("sellingUser") == userId ? "sale" : "buy",
//           ),
//         );


 // if (data.) {
    //   for (var element in data.docs) {
    //     chatUserList.value.add(ChatUserList(
    //         docId: element.id,
    //         pId: element.data()["adsPostId"],
    //         userId: element.data()["users"][0] == userId
    //             ? element.data()["users"][1]
    //             : element.data()["users"][0],
    //         postType:
    //             element.data()["sellingUser"] == userId ? "sale" : "buy"));
    //   }
    //   return true;
    // } else {
    //   isLoading.value = false;
    //   return false;
    // }
