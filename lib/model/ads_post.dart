// To parse this JSON data, do
//
//     final adsPost = adsPostFromJson(jsonString);

import 'dart:convert';

List<AdsPost> adsPostFromJson(String str) => List<AdsPost>.from(json
    .decode(str)
    .map((x) => AdsPost.fromJson(x as Map<String, dynamic>))
    .toList() as List<dynamic>);

String adsPostToJson(List<AdsPost> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class AdsPost {
  AdsPost({
    this.pId,
    this.pDate,
    required this.pTitle,
    required this.pBrand,
    required this.pDescribe,
    required this.pImg1,
    required this.pImg2,
    required this.pImg3,
    required this.pImg4,
    required this.pImg5,
    required this.pPrice,
    required this.pLocation,
    required this.pMcat,
    required this.pScat,
    required this.pUid,
    required this.uName,
    this.uPhoto,
    this.pFavorite,
    this.pView,
  });

  int? pId;
  DateTime? pDate;
  String pTitle;
  String pBrand;
  String pDescribe;
  String pImg1;
  String pImg2;
  String pImg3;
  String pImg4;
  String pImg5;
  int pPrice;
  String pLocation;
  int pMcat;
  int pScat;
  String pUid;
  String uName;
  String? uPhoto;
  int? pFavorite;
  int? pView;

  factory AdsPost.fromJson(Map<String, dynamic> json) => AdsPost(
        pId: json["p_id"],
        pDate: DateTime.parse(json["p_date"]),
        pTitle: json["p_title"],
        pBrand: json["p_brand"],
        pDescribe: json["p_describe"],
        pImg1: json["p_img1"],
        pImg2: json["p_img2"],
        pImg3: json["p_img3"],
        pImg4: json["p_img4"],
        pImg5: json["p_img5"],
        pPrice: json["p_price"],
        pLocation: json["p_location"],
        pMcat: json["p_mcat"],
        pScat: json["p_scat"],
        pUid: json["p_uid"],
        uName: json["u_name"],
        uPhoto: json["u_photo"],
        pFavorite: json["p_favorite"],
        pView: json["p_view"],
      );

  Map<String, dynamic> toJson() => {
        "p_id": pId,
        "p_date": pDate!.toIso8601String(),
        "p_title": pTitle,
        "p_brand": pBrand,
        "p_describe": pDescribe,
        "p_img1": pImg1,
        "p_img2": pImg2,
        "p_img3": pImg3,
        "p_img4": pImg4,
        "p_img5": pImg5,
        "p_price": pPrice,
        "p_location": pLocation,
        "p_mcat": pMcat,
        "p_scat": pScat,
        "p_uid": pUid,
        "u_name": uName,
        "u_photo": uPhoto,
        "p_favorite": pFavorite,
        "p_view": pView,
      };
}




// To parse this JSON data, do
//
//     final adsPost = adsPostFromJson(jsonString);

// import 'dart:convert';


// List<AdsPost> adsPostFromJson(String str) =>
//     List<AdsPost>.from(json.decode(str).map((x) => AdsPost.fromJson(x)));

// String adsPostToJson(AdsPost data) => json.encode(data.toJson());

// class AdsPost {
//     AdsPost({
//       this.pId,
//         this.pDate,
//       required this.pTitle,
//       required this.pBrand,
//       required this.pDescribe,
//       required this.pImg1,
//       required this.pImg2,
//       required this.pImg3,
//       required this.pImg4,
//       required this.pImg5,
//       required this.pPrice,
//       required this.pLocation,
//       required this.pMcat,
//       required this.pScat,
//       required this.pUid,
//       required this.userId,
//     });

//     int? pId;
//     DateTime? pDate;
//     String pTitle;
//     String pBrand;
//     String pDescribe;
//     String pImg1;
//     String pImg2;
//     String pImg3;
//     String pImg4;
//     String pImg5;
//     int pPrice;
//     String pLocation;
//     int pMcat;
//     int pScat;
//     String pUid;
//     String userId;

//     factory AdsPost.fromJson(Map<String, dynamic> json) => AdsPost(
//         pId: json["p_id"],
//         pDate: DateTime.parse(json["p_date"]),
//         pTitle: json["p_title"],
//         pBrand: json["p_brand"],
//         pDescribe: json["p_describe"],
//         pImg1: json["p_img1"],
//         pImg2: json["p_img2"],
//         pImg3: json["p_img3"],
//         pImg4: json["p_img4"],
//         pImg5: json["p_img5"],
//         pPrice: json["p_price"],
//         pLocation: json["p_location"],
//         pMcat: json["p_mcat"],
//         pScat: json["p_scat"],
//         pUid: json["p_uid"],
//         userId: json["userId"],
//     );

//     Map<String, dynamic> toJson() => {
//         "p_id": pId,
//         "p_date": pDate!.toIso8601String(),
//         "p_title": pTitle,
//         "p_brand": pBrand,
//         "p_describe": pDescribe,
//         "p_img1": pImg1,
//         "p_img2": pImg2,
//         "p_img3": pImg3,
//         "p_img4": pImg4,
//         "p_img5": pImg5,
//         "p_price": pPrice,
//         "p_location": pLocation,
//         "p_mcat": pMcat,
//         "p_scat": pScat,
//         "p_uid": pUid,
//         "userId": userId,
//     };
// }


