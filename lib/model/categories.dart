// To parse this JSON data, do
//
//     final categories = categoriesFromJson(jsonString);

import 'dart:convert';

List<Categories> categoriesFromJson(String str) =>
    List<Categories>.from(json.decode(str).map((x) => Categories.fromJson(x)));

String categoriesToJson(List<Categories> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Categories {
  Categories({
    required this.catId,
    required this.catName,
    required this.catSubid,
    required this.catImg,
  });

  final int catId;
  final String catName;
  final int catSubid;
  final String catImg;

  factory Categories.fromJson(Map<String, dynamic> json) => Categories(
        catId: json["cat_id"],
        catName: json["cat_name"],
        catSubid: json["cat_subid"],
        catImg: json["cat_img"],
      );

  Map<String, dynamic> toJson() => {
        "cat_id": catId,
        "cat_name": catName,
        "cat_subid": catSubid,
        "cat_img": catImg,
      };
}
