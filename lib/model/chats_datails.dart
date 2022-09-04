// To parse this JSON data, do
//
//     final chatBord = chatBordFromJson(jsonString);

import 'package:meta/meta.dart';
import 'dart:convert';

class ChatBord {
    ChatBord({
      required this.msg,
      required this.msgDate,
      required this.msgSend,
      required this.msgStatus,
    });

    final String msg;
    final DateTime msgDate;
    final int msgSend;
    final String msgStatus;

    factory ChatBord.fromRawJson(String str) => ChatBord.fromJson(json.decode(str));

    String toRawJson() => json.encode(toJson());

    factory ChatBord.fromJson(Map<String, dynamic> json) => ChatBord(
        msg: json["msg"],
        msgDate: DateTime.parse(json["msgDate"]),
        msgSend: json["msgSend"],
        msgStatus: json["msgStatus"],
    );

    Map<String, dynamic> toJson() => {
        "msg": msg,
        "msgDate": "${msgDate.year.toString().padLeft(4, '0')}-${msgDate.month.toString().padLeft(2, '0')}-${msgDate.day.toString().padLeft(2, '0')}",
        "msgSend": msgSend,
        "msgStatus": msgStatus,
    };
}
