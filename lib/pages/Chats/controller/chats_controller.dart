import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:ubs/model/ads_post.dart';
import 'package:ubs/model/message_data.dart';
import 'package:ubs/services/firestore_service.dart';

class ChatsController extends GetxController {
  Rx<Stream<QuerySnapshot>> chatsRoom = const Stream<QuerySnapshot>.empty().obs;
  Rx<Stream<QuerySnapshot>> chatsHistory =
      const Stream<QuerySnapshot>.empty().obs;
  RxList<String> chatsUserId = <String>["917499604663"].obs;

  // Add new chats Room between tow users
  Future<String?> addChatRoom(
      {required String loggedUser, required AdsPost adsPostData}) async {
    // var chatRoomId = getChatRoomId(loggedUser, adsUser);
    // List<String> users = [loggedUser, adsUser];

    var documentId = "${adsPostData.pId}__$loggedUser";
    Map<String, dynamic> chatRoomData = {
      "users": [loggedUser, adsPostData.pUid],
      "adsPostUsers": adsPostData.pUid,
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
    MessageData messageData = MessageData.fromJson({
      "message": message,
      "sendBy": loggedUid,
      "messageType": "text", // this for text-message or offer-message
      "time": DateTime.now().toString(),
      "status": "unread"
    });

    return await FirestoreDatabaseHelper.saveMessage(
        docId: docId, messageData: messageData.toJson());
  }

  // void getChatsBoard(String loginUser) async {
  //   // chatsRoom.value = await FirestoreDatabaseHelper.chatsObj.snapshots();
  //   chatsRoom.value = FirebaseFirestore.instance
  //       .collection('ChatsRoom')
  //       .where('users', arrayContains: loginUser)
  //       .snapshots(); dashboard
  //   // print("data : " + chatsRoom.value.toString());
  // }

  getChatsUsersList(String userId) async {
    chatsRoom.value = FirestoreDatabaseHelper.chatsRoom
        .where('users', arrayContains: userId)
        .snapshots();
    // getBuyerUser(userId);
    // getSellerUser(userId);
  }

  getChatsHistory(String docId) {
    chatsHistory.value = FirestoreDatabaseHelper.chatsRoom
        .doc(docId)
        .collection("chats")
        .snapshots();
  }

  // In this function for user get all buyer of user of ads
  getBuyerUser(String userId) async {
    chatsRoom.value = FirestoreDatabaseHelper.chatsRoom
        .where('adsPostUsers', isEqualTo: userId)
        .snapshots();

    FirestoreDatabaseHelper.chatsRoom
        .where('adsPostUsers', isEqualTo: userId)
        .get()
        .then((value) {
      value.docs.forEach((element) {
        element.data()["chatsUser"].forEach((name) {
          // this line code if user id already added than do'n add into list
          if (!chatsUserId.value.any((element) => element == name)) {
            chatsUserId.value.add(name);
          }
        }) as List<String>;
        // print(chatsUserId.value);
        // print("getBuyerUser");
      });
    });
  }

  // In this function for user get all Seller to user
  getSellerUser(String userId) async {
    FirestoreDatabaseHelper.chatsRoom
        .where('chatsUser', arrayContains: userId)
        .get()
        .then((value) {
      value.docs.forEach((element) {
        var uid = element.data()["adsPostUsers"];
        if (!chatsUserId.value.any((element) => element == uid)) {
          chatsUserId.value.add(uid);
        }
      });
      // print(chatsUserId.value);
      // print("getSellerUser");
    });
  }
}

  // String getChatRoomId(String user1, String user2) {
  //   if (user1.substring(0, 1).codeUnitAt(0) >
  //       user2.substring(0, 1).codeUnitAt(0)) {
  //     return "${user2}_$user1";
  //   } else {
  //     return "${user1}_$user2";
  //   }
  // }
