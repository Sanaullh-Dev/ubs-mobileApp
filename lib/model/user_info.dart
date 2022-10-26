// To parse this JSON data, do
//
//     final userInfo = userInfoFromJson(jsonString);

import 'dart:convert';

UserInfo userInfoFromJson(String str) => UserInfo.fromJson(json.decode(str));

String userInfoToJson(UserInfo data) => json.encode(data.toJson());

class UserInfo {
    UserInfo({
      this.logId,
       required this.logPass,
       required this.uName,
       required this.loginWith,
       this.uPhone,
       this.uEmail,
    });

    String? logId;
    String logPass;
    String uName;
    String loginWith;
    String? uPhone;
    String? uEmail;

    factory UserInfo.fromJson(Map<String, dynamic> json) => UserInfo(
        logId: json["log_id"],
        logPass: json["log_pass"],
        uName: json["u_name"],
        loginWith: json["login_with"],
        uPhone: json["u_phone"],
        uEmail: json["u_email"],
    );

    Map<String, dynamic> toJson() => {
        "log_id": logId,
        "log_pass": logPass,
        "u_name": uName,
        "login_with": loginWith,
        "u_phone": uPhone,
        "u_email": uEmail,
    };
}
