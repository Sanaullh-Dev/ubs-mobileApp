import 'dart:convert';

UserLogin userDataFromJson(String str) => UserLogin.fromJson(json.decode(str));

String userDataToJson(UserLogin data) => json.encode(data.toJson());

class UserLogin {
  UserLogin({
    required this.userId,
    required this.upass,
  });

  String userId;
  String upass;

  factory UserLogin.fromJson(Map<String, dynamic> json) => UserLogin(
        userId: json["userId"],
        upass: json["Upass"],
      );

  Map<String, dynamic> toJson() => {
        "userId": userId,
        "Upass": upass,
      };
}
