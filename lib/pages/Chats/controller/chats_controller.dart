import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:ubs/model/ads_post.dart';
import 'package:ubs/model/chats_room.dart';
import 'package:ubs/model/message_data.dart';
import 'package:ubs/services/firestore_service.dart';
import 'package:ubs/services/remote_services.dart';

class ChatsController extends GetxController {
  Rx<Stream<QuerySnapshot>> chatsRoom = const Stream<QuerySnapshot>.empty().obs;
  Stream<QuerySnapshot> chatsHistory = Stream.empty();
  Rx<bool> isLoading = false.obs;
  RxList<ChatsRoomModel> chatsRooms = List<ChatsRoomModel>.empty().obs;
  RxList<ChatUserList> chatUserList = List<ChatUserList>.empty().obs;

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
      String docId, String message, String loggedUid) async {
    final DateFormat formatter = DateFormat('yyyy-MMM-dd');

    MessageData messageData = MessageData.fromJson({
      "message": message,
      "sendBy": loggedUid,
      "messageType": "text", // this for text-message or offer-message
      "time": DateTime.now().toIso8601String(),
      "status": "unread"
    });

    return await FirestoreDatabaseHelper.saveMessage(
        docId: docId, messageData: messageData.toJson());
  }

  getChatsRoomsList(String userId) async {
    isLoading.value = true;
    await FirestoreDatabaseHelper.chatsRoom
        .where('users', arrayContains: userId)
        .get()
        .then((val) {
      val.docs.forEach((element) {
        chatUserList.value.add(ChatUserList(
            docId: element.id,
            pId: element.data()["adsPostId"],
            userId: element.data()["users"][0] == userId
                ? element.data()["users"][1]
                : element.data()["users"][0],
            postType:
                element.data()["sellingUser"] == userId ? "sale" : "buy"));
      });
    });
    getChatsDetails();
  }

  getChatsDetails() async {
    chatUserList.value.forEach((val) async {
      var res = await RemoteServices.getChatRoomDetails(val.userId, val.pId);
      if (res != null) {
        chatsRooms.value.add(res);
        chatsRooms.value[chatsRooms.length - 1].postType = val.postType;
        chatsRooms.value[chatsRooms.length - 1].docId = val.docId;
        await getUserLastMsg(val.docId, chatsRooms.length - 1);
      }
      isLoading.value = false;
    });
  }

  getUserLastMsg(String docId, int chatRoomIndex) async {
    await FirestoreDatabaseHelper.chatsRoom
        .doc(docId)
        .collection("chats")
        .orderBy("time", descending: true)
        .limit(1)
        .get()
        .then((value) {
      chatsRooms.value[chatRoomIndex].lastMag = value.docs[0].data()["message"];
      chatsRooms.value[chatRoomIndex].lastSeen = value.docs[0].data()["time"];
    });
  }

  getChatsHistory(String docId) {
    chatsHistory = FirestoreDatabaseHelper.chatsRoom
        .doc(docId)
        .collection("chats")
        .orderBy("time")
        .snapshots();
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
