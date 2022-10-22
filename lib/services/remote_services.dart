import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:ubs/model/ads_post.dart';
import 'package:ubs/model/categories.dart';
import 'package:ubs/utils/constants.dart';

class RemoteServices {
  static var client = http.Client();

    // ---------- Get All Main Categories from API ------------------
  static Future<List<Categories>?> fetchMainCat() async {
    var uri = Uri.parse("$API_URL/category/main");
    var response = await client.get(uri);
    print(response.statusCode);

    if (response.statusCode == 200) {
      var jsonString = response.body;
      return categoriesFromJson(jsonString);
    } else {
      return null;
    }
  }

  // ---------- Get All Sub Categories from API ------------------
  static Future<List<Categories>?> fetchSubCat(int subCat) async {
    var uri = Uri.parse("$API_URL/category/sub-$subCat");
    var response = await client.get(uri);

    if (response.statusCode == 200) {
      var jsonString = response.body;
      return categoriesFromJson(jsonString);
    } else {
      return null;
    }
  }

  // ---------- Get All Ads post from API ------------------
  static Future<List<AdsPost>?> fetchAdsPost() async {
    var uri = Uri.parse("$API_URL/adspost");
    var response = await client.get(uri);

    if (response.statusCode == 200) {
      var jsonString = response.body;
      return adsPostFromJson(jsonString);
    } else {
      return null;
    }
  }

  // static Future<List<String>?> fetchKeywordList() async {}

  // ---------- Get All Ads post from API ------------------
  static Future<List<AdsPost>?> fetchCatWisedAds(int mCatId) async {
    var uri = Uri.parse("$API_URL/adspost/relatedAds/mainId-$mCatId");
    var response =
        await client.get(uri, headers: {'Content-Type': 'application/json'});

    if (response.statusCode == 200) {
      var jsonString = response.body;
      return adsPostFromJson(jsonString);
    } else {
      return null;
    }
  }

  // ---------- Create Ads post into API ------------------
  static Future<dynamic?> postAds(AdsPost adsPost) async {
    var uri = Uri.parse("$API_URL/adspost");

    http.MultipartRequest request = http.MultipartRequest("POST", uri);

    request = await imgFileAdd(adsPost, request);
    request.fields["pTitle"] = adsPost.pTitle;
    request.fields["pBrand"] = adsPost.pBrand;
    request.fields["pDescribe"] = adsPost.pDescribe;
    request.fields["pImg1"] = adsPost.pImg1;
    request.fields["pImg2"] = adsPost.pImg2;
    request.fields["pImg3"] = adsPost.pImg3;
    request.fields["pImg4"] = adsPost.pImg4;
    request.fields["pImg5"] = adsPost.pImg5;
    request.fields["pPrice"] = adsPost.pPrice.toString();
    request.fields["pLocation"] = adsPost.pLocation;
    request.fields["mcat_id"] = adsPost.pMcat.toString();
    request.fields["scat_id"] = adsPost.pScat.toString();
    request.fields["pUid"] = adsPost.pUid.toString();
    request.headers.addAll({'Content-Type': 'application/json'});

    // var response = await request.send();
    http.Response response =
        await http.Response.fromStream(await request.send());
    print("Result: ${response.body}");

    if (response.statusCode == 200) {
      return response.body;
    }
  }

  // ---------- Get keyword list from API ------------------
  static Future<List<String>?> fetchAdsWiseKeyword(String keyword) async {
    List<String> li = [];
    var uri = Uri.parse("$API_URL/adspost/search-$keyword");
    var response =
        await client.get(uri, headers: {'Content-Type': 'application/json'});

    if (response.statusCode == 200) {
      var jsonString = response.body;
      (json.decode(jsonString) as List)
          .forEach((val) => li.add(val["keyword"]));
      return li;
    } else {
      return null;
    }
  }

  // ---------- Get All Ads post from API ------------------
  static Future<List<AdsPost>?> fetchKeywordWisedAds(String keyword) async {
    var uri = Uri.parse("$API_URL/adspost/keywordSearch-$keyword");
    var response =
        await client.get(uri, headers: {'Content-Type': 'application/json'});

    if (response.statusCode == 200) {
      var jsonString = response.body;
      return adsPostFromJson(jsonString);
    } else {
      return null;
    }
  }

  // ---------- Post for Get OTP Login to API ------------------
  static Future<dynamic> getOTP(
      String phone, String app_signature) async {
        const String _API_URL = "http://10.0.2.2:8080";

    // var uri = Uri.parse("$API_URL/userLogin/otpLogin");
    var uri = Uri.parse("$_API_URL/category/main");
      var response =
        await client.get(uri, headers: {'Content-Type': 'application/json'});

    // http.MultipartRequest request = http.MultipartRequest("POST", uri);

    // request.fields["phone"] = phone;
    // request.fields["app_signature"] = app_signature;
    // request.headers.addAll({'Content-Type': 'application/json'});

    // // var response = await request.send();
    // http.Response response =
    //     await http.Response.fromStream(await request.send());
    // print("Result: ${response.body}");

    if (response.statusCode == 200) {
      return response.body;
    }
  }
}

imgFileAdd(AdsPost adsPost, http.MultipartRequest request) async {
  if (adsPost.pImg1.isNotEmpty) {
    http.MultipartFile multipartFile =
        await http.MultipartFile.fromPath("ads_image", adsPost.pImg1);
    request.files.add(multipartFile);
  }

  if (adsPost.pImg2.isNotEmpty) {
    http.MultipartFile multipartFile =
        await http.MultipartFile.fromPath("ads_image", adsPost.pImg2);
    request.files.add(multipartFile);
  }

  if (adsPost.pImg3.isNotEmpty) {
    http.MultipartFile multipartFile =
        await http.MultipartFile.fromPath("ads_image", adsPost.pImg3);
    request.files.add(multipartFile);
  }

  if (adsPost.pImg4.isNotEmpty) {
    http.MultipartFile multipartFile =
        await http.MultipartFile.fromPath("ads_image", adsPost.pImg4);
    request.files.add(multipartFile);
  }

  if (adsPost.pImg5.isNotEmpty) {
    http.MultipartFile multipartFile =
        await http.MultipartFile.fromPath("ads_image", adsPost.pImg5);
    request.files.add(multipartFile);
  }
  return request;
}
