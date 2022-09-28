// To parse this JSON data, do
//
//     final adsPost = adsPostFromJson(jsonString);

import 'package:meta/meta.dart';
import 'dart:convert';

List<AdsPost> adsPostFromJson(String str) =>
    List<AdsPost>.from(json.decode(str).map((x) => AdsPost.fromJson(x)));

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
      };
}
