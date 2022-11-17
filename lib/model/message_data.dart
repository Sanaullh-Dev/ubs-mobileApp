// To parse this JSON data, do
//
//     final messageData = messageDataFromJson(jsonString);

import 'dart:convert';

List<MessageData> messageDataFromJson(String str) => List<MessageData>.from(json.decode(str).map((x) => MessageData.fromJson(x)));

String messageDataToJson(List<MessageData> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class MessageData {
    MessageData({
      required this.message,
      required this.sendBy,
      required this.messageType,
      required this.time,
      required this.status,
    });

    String message;
    String sendBy;
    String messageType;
    DateTime time;
    String status;

    factory MessageData.fromJson(Map<String, dynamic> json) => MessageData(
        message: json["message"],
        sendBy: json["sendBy"],
        messageType: json["messageType"],
        time: DateTime.parse(json["time"]),
        status: json["status"],
    );

    Map<String, dynamic> toJson() => {
        "message": message,
        "sendBy": sendBy,
        "messageType": messageType,
        "time": "${time.year.toString().padLeft(4, '0')}-${time.month.toString().padLeft(2, '0')}-${time.day.toString().padLeft(2, '0')}",
        "status": status,
    };
}
