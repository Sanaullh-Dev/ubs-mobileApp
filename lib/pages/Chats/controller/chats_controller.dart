import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:ubs/model/ads_post.dart';
import 'package:ubs/model/cats_board.dart';
import 'package:ubs/services/firestore_service.dart';

class ChatsController extends GetxController {
  Rx<Stream<QuerySnapshot>> chatsRoom = const Stream<QuerySnapshot>.empty().obs;
  RxList<String> chatsUserId = <String>["917499604663"].obs;

  String getChatRoomId(String user1, String user2) {
    if (user1.substring(0, 1).codeUnitAt(0) >
        user2.substring(0, 1).codeUnitAt(0)) {
      return "${user2}_$user1";
    } else {
      return "${user1}_$user2";
    }
  }

  // Add new chats Room between tow users
  Future<bool> addChatRoom(
      {required String loggedUser, required AdsPost adsPostData}) async {
    // var chatRoomId = getChatRoomId(loggedUser, adsUser);
    // List<String> users = [loggedUser, adsUser];

    Map<String, dynamic> chatRoomData = {
      "adsPostUsers": adsPostData.pUid,
      "adsStatus": "active"
    };

    return await FirestoreDatabaseHelper.addNewChatRoom(
            adsPostId: adsPostData.pId.toString(), chatRoomData: chatRoomData)
        .then((value) {
      return value;
    });
  }

  // void getChatsBoard(String loginUser) async {
  //   // chatsRoom.value = await FirestoreDatabaseHelper.chatsObj.snapshots();
  //   chatsRoom.value = FirebaseFirestore.instance
  //       .collection('ChatsRoom')
  //       .where('users', arrayContains: loginUser)
  //       .snapshots();
  //   // print("data : " + chatsRoom.value.toString());
  // }

  getChatsUsersList(String userId) async {
    getBuyerUser(userId);
    getSellerUser(userId);
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


// FirestoreDatabaseHelper.chatsRoom.get().then((value) {
    //   value.docs.forEach((element) {
    // });
    // });
