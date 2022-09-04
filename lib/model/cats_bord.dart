// To parse this JSON data, do
//
//     final chatBoard = chatBoardFromJson(jsonString);

 import 'dart:convert';

class ChatBoard {
    ChatBoard({
      required this.userName,
      required this.userImg,
      required this.userLastSeen,
      required this.lastMessage,
      required this.messageStatus,
      required this.postTitle,
      required this.postImg,
      required this.price,
      required this.postType,
    });

    final String userName;
    final String userImg;
    final DateTime userLastSeen;
    final String lastMessage;
    final String messageStatus;
    final String postTitle;
    final String postImg;
    final int price;
    final String postType;

    factory ChatBoard.fromRawJson(String str) => ChatBoard.fromJson(json.decode(str));

    String toRawJson() => json.encode(toJson());

    factory ChatBoard.fromJson(Map<String, dynamic> json) => ChatBoard(
        userName: json["userName"],
        userImg: json["userImg"],
        userLastSeen: DateTime.parse(json["userLastSeen"]),
        lastMessage: json["lastMessage"],
        messageStatus: json["messageStatus"],
        postTitle: json["postTitle"],
        postImg: json["postImg"],
        price: json["price"],
        postType: json["postType"],
    );

    Map<String, dynamic> toJson() => {
        "userName": userName,
        "userImg": userImg,
        "userLastSeen": "${userLastSeen.year.toString().padLeft(4, '0')}-${userLastSeen.month.toString().padLeft(2, '0')}-${userLastSeen.day.toString().padLeft(2, '0')}",
        "lastMessage": lastMessage,
        "messageStatus": messageStatus,
        "postTitle": postTitle,
        "postImg": postImg,
        "price": price,
        "postType": postType,
    };
}
