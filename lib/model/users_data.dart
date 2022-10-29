// To parse this JSON data, do
//
//     final usersData = usersDataFromJson(jsonString);

import 'dart:convert';

List<UsersData> usersDataFromJson(String str) =>
    List<UsersData>.from(json.decode(str).map((x) => UsersData.fromJson(x)));

String usersDataToJson(List<UsersData> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class UsersData {
  UsersData({
    this.uNo,
    required this.logId,
    required this.logPass,
    required this.uName,
    this.uAbout,
    this.uCountry,
    this.uPhone,
    this.uEmail,
    this.uPhoto,
    required this.loginWith,
  });

  int? uNo;
  String logId;
  String logPass;
  String uName;
  String? uAbout;
  String? uCountry;
  String? uPhone;
  String? uEmail;
  String? uPhoto;
  String loginWith;

  factory UsersData.fromJson(Map<String, dynamic> json) => UsersData(
        uNo: json["u_no"],
        logId: json["log_id"],
        logPass: json["log_pass"],
        uName: json["u_name"],
        uAbout: json["u_about"],
        uCountry: json["u_country"],
        uPhone: json["u_phone"],
        uEmail: json["u_email"],
        uPhoto: json["u_photo"],
        loginWith: json["login_with"],
      );

  Map<String, dynamic> toJson() => {
        "u_no": uNo,
        "log_id": logId,
        "log_pass": logPass,
        "u_name": uName,
        "u_about": uAbout,
        "u_country": uCountry,
        "u_phone": uPhone,
        "u_email": uEmail,
        "u_photo": uPhoto,
        "login_with": loginWith,
      };
}
