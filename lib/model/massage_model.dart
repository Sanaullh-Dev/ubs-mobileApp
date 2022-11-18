// To parse this JSON data, do
//
//     final MessageModel = MessageModelFromJson(jsonString);

import 'dart:convert';

List<MessageModel> messageModelFromJson(String str) => List<MessageModel>.from(
    json.decode(str).map((x) => MessageModel.fromJson(x)));

String messageModelToJson(List<MessageModel> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class MessageModel {
  MessageModel({
   required this.message,
   required this.messageType,
   required this.sendBy,
   required this.status,
   required this.time,
  });

  String message;
  String messageType;
  String sendBy;
  String status;
  DateTime time;

  factory MessageModel.fromJson(Map<String, dynamic> json) => MessageModel(
        message: json["message"],
        messageType: json["messageType"],
        sendBy: json["sendBy"],
        status: json["status"],
        time: DateTime.parse(json["time"]),
      );

  Map<String, dynamic> toJson() => {
        "message": message,
        "messageType": messageType,
        "sendBy": sendBy,
        "status": status,
        "time":
            "${time.year.toString().padLeft(4, '0')}-${time.month.toString().padLeft(2, '0')}-${time.day.toString().padLeft(2, '0')}",
      };
}
