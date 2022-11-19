import 'package:cloud_firestore/cloud_firestore.dart';

class FirestoreDatabaseHelper {
  static final  chatsRoom = FirebaseFirestore.instance.collection('ChatsRoom');

  static Future<bool> addNewChatRoom(
      {required String docId,
      required Map<String, dynamic> chatRoomData}) async {
    return await chatsRoom
        .doc(docId)
        .set(chatRoomData)
        .catchError((e) => false)
        .then((val) => true);
  }

  static Future<bool> saveMessage(
      {required String docId,
      required Map<String, dynamic> messageData}) async {
    return await chatsRoom
        .doc(docId)
        .collection("chats")
        .doc()
        .set(messageData)
        .catchError((e) => false)
        .then((val) => true);
  }
}
