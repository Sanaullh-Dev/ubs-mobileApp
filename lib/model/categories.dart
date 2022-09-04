// To parse this JSON data, do
//
//     final categories = categoriesFromJson(jsonString);

import 'dart:convert';

List<Categories> categoriesFromJson(String str) => List<Categories>.from(json.decode(str).map((x) => Categories.fromJson(x)));

String categoriesToJson(List<Categories> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Categories {
    Categories({
      required this.title,
      required this.img,
      required this.subCategories,
    });

    String title;
    String img;
    List<SubCategory> subCategories;

    factory Categories.fromJson(Map<String, dynamic> json) => Categories(
        title: json["title"],
        img: json["img"],
        subCategories: List<SubCategory>.from(json["SubCategories"].map((x) => SubCategory.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "title": title,
        "img": img,
        "SubCategories": List<dynamic>.from(subCategories.map((x) => x.toJson())),
    };
}

class SubCategory {
    SubCategory({
      required this.subCatId,
      required this.subCatName,
    });

    String subCatId;
    String subCatName;

    factory SubCategory.fromJson(Map<String, dynamic> json) => SubCategory(
        subCatId: json["subCatId"],
        subCatName: json["subCatName"],
    );

    Map<String, dynamic> toJson() => {
        "subCatId": subCatId,
        "subCatName": subCatName,
    };
}
