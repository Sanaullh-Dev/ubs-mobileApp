import 'dart:convert';

UserData userDataFromJson(String str) => UserData.fromJson(json.decode(str));

String userDataToJson(UserData data) => json.encode(data.toJson());

class UserData {
  UserData({
    required this.uname,
    required this.upass,
  });

  String uname;
  String upass;

  factory UserData.fromJson(Map<String, dynamic> json) => UserData(
        uname: json["Uname"],
        upass: json["Upass"],
      );

  Map<String, dynamic> toJson() => {
        "Uname": uname,
        "Upass": upass,
      };
}
