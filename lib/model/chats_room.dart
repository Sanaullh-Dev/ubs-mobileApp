import 'dart:convert';

List<ChatsRoomModel> chatsRoomModelFromJson(String str) =>
    List<ChatsRoomModel>.from(json.decode(str).map((x) => ChatsRoomModel.fromJson(x)));

String chatsRoomModelToJson(List<ChatsRoomModel> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class ChatsRoomModel {
  ChatsRoomModel({
    required this.pId,
    required this.pTitle,
    required this.pPrice,
    required this.pImage,
    required this.userId,
    required this.userName,
    this.userPhoto,
    this.lastMag,
    this.magStatus,
    this.postType,
    this.docId,
    this.lastSeen,
  });

  int pId;
  String pTitle;
  int pPrice;
  String pImage;
  String userId;
  String userName;
  String? userPhoto;
  String? lastMag;
  String? magStatus;
  String? postType;
  String? docId;
  String? lastSeen;

  factory ChatsRoomModel.fromJson(Map<String, dynamic> json) => ChatsRoomModel(
        pId: json["pId"],
        pTitle: json["pTitle"],
        pPrice: json["pPrice"],
        pImage: json["pImage"],
        userId: json["userId"],
        userName: json["userName"],
        userPhoto: json["userPhoto"],
        lastMag: json["lastMag"],
        magStatus: json["magStatus"],
        postType: json["postType"],
        docId: json["docId"],
        lastSeen: json["lastSeen"],
      );

  Map<String, dynamic> toJson() => {
        "pId": pId,
        "pTitle": pTitle,
        "pPrice": pPrice,
        "pImage": pImage,
        "userId": userId,
        "userName": userName,
        "userPhoto": userPhoto,
        "lastMag": lastMag,
        "magStatus": magStatus,
        "postType": postType,
        "docId": docId,
        "lastSeen": lastSeen,
      };
}
