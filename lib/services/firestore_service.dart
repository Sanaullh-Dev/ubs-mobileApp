import 'package:cloud_firestore/cloud_firestore.dart';

class FirestoreDatabaseHelper {
  static final chatsRoom = FirebaseFirestore.instance.collection('ChatsRoom');
  

  static Future<bool> addNewChatRoom(
      {required String adsPostId, required Map<String, dynamic> chatRoomData
      }) async {
    return await chatsRoom
        .doc(adsPostId)
        .set(chatRoomData)
        .catchError((e) => false)
        .then((val) => true);
  }

 


  // static F

}
