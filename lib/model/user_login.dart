import 'dart:convert';

UserLogin userDataFromJson(String str) => UserLogin.fromJson(json.decode(str));

String userDataToJson(UserLogin data) => json.encode(data.toJson());

class UserLogin {
  UserLogin({
    required this.userId,
    required this.uPass,
  });

  String userId;
  String uPass;

  factory UserLogin.fromJson(Map<String, dynamic> json) => UserLogin(
        userId: json["userId"],
        uPass: json["uPass"],
      );

  Map<String, dynamic> toJson() => {
        "userId": userId,
        "uPass": uPass,
      };
}
