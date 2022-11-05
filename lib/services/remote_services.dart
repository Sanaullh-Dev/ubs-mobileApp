import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:ubs/model/ads_post.dart';
import 'package:ubs/model/categories.dart';
import 'package:ubs/model/post_reaction.dart';
import 'package:ubs/model/user_login.dart';
import 'package:ubs/model/users_data.dart';
import 'package:ubs/utils/constants.dart';

class RemoteServices {
  static String HOST_URI = "http://10.0.2.2";
  static var HOST_PORT = 8080;

  // static var headers = {'Content-Type': 'application/json'};
  // static var encoding = Encoding.getByName('utf-8');

  // ---------- Get All Main Categories from API ------------------
  static Future<List<Categories>?> fetchMainCat() async {
    var uri = Uri.parse("$API_URL/category/main");
    var _client = http.Client();
    var response = await _client.get(uri);
    // print(response.statusCode);

    if (response.statusCode == 200) {
      var jsonString = response.body;
      return categoriesFromJson(jsonString);
    } else {
      return null;
    }
  }

  // ---------- Get All Sub Categories from API ------------------
  static Future<List<Categories>?> fetchSubCat(int subCat) async {
    var client = http.Client();
    var uri = Uri.parse("$API_URL/category/sub-$subCat");
    var response = await client.get(uri);

    if (response.statusCode == 200) {
      var jsonString = response.body;
      return categoriesFromJson(jsonString);
    } else {
      return null;
    }
  }

// **************************** Ads Post ************************************
  // ---------- Get All Ads post from API ------------------
  static Future<List<AdsPost>?> fetchAdsPost(String userId) async {
    var uri = Uri.parse("$API_URL/adspost");

    Map<String, dynamic> bodyData = {'uid': userId};
    var client = http.Client();

    http.Response response = await client.post(uri, body: bodyData);

    if (response.statusCode == 200) {
      var jsonString = response.body;
      return adsPostFromJson(jsonString);
    } else {
      return null;
    }
  }

  // ---------- Get one Ads post with PostId from API ------------------
  static Future<AdsPost?> getAdsPostDetails(
      String userId, String postId) async {
    var client = http.Client();

    var uri = Uri.parse("$API_URL/adspost/getPostDetails");
    Map<String, dynamic> bodyData = {'pid': postId, 'uid': userId};

    var headers = {'Content-Type': 'application/json'};
    var encoding = Encoding.getByName('utf-8');

    var res = await client.post(
      uri,
      headers: headers,
      body: json.encode(bodyData),
      encoding: encoding,
    );
    return res.statusCode == 200
        ? AdsPost.fromJson(json.decode(res.body))
        : null;
  }

  // ---------- Get All Ads post main Cat wise from API ------------------
  static Future<List<AdsPost>?> fetchCatWisedAds(
      String userId, int mCatId) async {
    var client = http.Client();

    var uri = Uri.parse("$API_URL/adspost/relatedAds/mainId");
    Map<String, dynamic> bodyData = {'mainId': mCatId, 'uid': userId};
    var headers = {'Content-Type': 'application/json'};
    var encoding = Encoding.getByName('utf-8');

    var response = await client.post(
      uri,
      headers: headers,
      body: json.encode(bodyData),
      encoding: encoding,
    );

    if (response.statusCode == 200) {
      var jsonString = response.body;
      return adsPostFromJson(jsonString);
    } else {
      return null;
    }
  }

  // ---------- Create Ads post into API ------------------
  static Future<dynamic> postAds(AdsPost adsPost) async {
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
    // print("Result: ${response.body}");

    return response.statusCode == 200 ? response.body : null;
  }

  // ---------- Get keyword list from API ------------------
  static Future<List<String>?> fetchAdsWiseKeyword(String keyword) async {
    List<String> li = [];
    var client = http.Client();

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
    var client = http.Client();

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

  // ---------- Insert Ads post view or favorites into API ------------------
  static Future<bool> addPostReaction(PostReaction postReaction) async {
    var client = http.Client();

    var uri = Uri.parse("$API_URL/adspost/userAction");
    Map<String, dynamic> bodyData = {
      'pid': postReaction.pid,
      'p_favorite': postReaction.pFavorite,
      'p_view': postReaction.pView,
      'uid': postReaction.uid
    };

    var headers = {'Content-Type': 'application/json'};
    var encoding = Encoding.getByName('utf-8');

    var res = await client.post(
      uri,
      headers: headers,
      body: json.encode(bodyData),
      encoding: encoding,
    );
    return res.statusCode == 200 ? true : false;
  }

  // ---------- Insert Ads post view or favorites into API ------------------
  static Future<bool> updatedFavorite(PostReaction postReaction) async {
    var client = http.Client();

    var uri = Uri.parse("$API_URL/adspost/favoritesUpdate");
    var bodyData = {
      'uid': postReaction.uid,
      'pid': postReaction.pid.toString(),
      'p_favorite': postReaction.pFavorite.toString()
    };

    var res = await client.post(
      uri,
      // headers: headers,
      body: bodyData,
    );
    if (res.statusCode == 200) {
      return true;
    } else {
      return false;
    }
  }

  // ---------- Get All favorites Ads from API ------------------
  static Future<List<AdsPost>?> fetchFavoritesAds(String userId) async {
    var client = http.Client();

    var uri = Uri.parse("$API_URL/adspost/favoriteList");
    Map<String, dynamic> bodyData = {'uid': userId};
    var headers = {'Content-Type': 'application/json'};
    var encoding = Encoding.getByName('utf-8');

    var response = await client.post(
      uri,
      headers: headers,
      body: json.encode(bodyData),
      encoding: encoding,
    );

    if (response.statusCode == 200) {
      var jsonString = response.body;
      return adsPostFromJson(jsonString);
    } else {
      return null;
    }
  }

  // ---------- Get All My Sales Ads from API ------------------
  static Future<List<AdsPost>?> fetchMySalesAds(String userId) async {
    var client = http.Client();

    var uri = Uri.parse("$API_URL/adspost/mySalesAds");
    Map<String, dynamic> bodyData = {'uid': userId};
    var headers = {'Content-Type': 'application/json'};
    var encoding = Encoding.getByName('utf-8');

    var response = await client.post(
      uri,
      headers: headers,
      body: json.encode(bodyData),
      encoding: encoding,
    );

    if (response.statusCode == 200) {
      var jsonString = response.body;
      return adsPostFromJson(jsonString);
    } else {
      return null;
    }
  }

  // ---------- Delete My Sales Ads Post from API ------------------
  static Future<bool> deleteMySalesAds(String userId, int pid) async {
    var client = http.Client();

    var uri = Uri.parse("$API_URL/adspost/deleteMySalesAds");
    Map<String, dynamic> bodyData = {'uid': userId, 'pid': pid};
    var headers = {'Content-Type': 'application/json'};
    var encoding = Encoding.getByName('utf-8');

    var response = await client.delete(
      uri,
      headers: headers,
      body: json.encode(bodyData),
      encoding: encoding,
    );

    if (response.statusCode == 200) {
      return true;
    } else {
      return false;
    }
  }

  // **************************** user login ************************************

  // ---------------- user registration ( user data save in database) --------------------
  static Future<dynamic> addUser(UsersData userData, String loginType) async {
    var client = http.Client();

    var uri = Uri.parse("$API_URL/userLogin/singUp");
    Map<String, dynamic> bodyData;
    bodyData = {
      'log_pass': userData.logPass,
      'u_name': userData.uName,
      'login_with': userData.loginWith,
      'u_phone': userData.uPhone,
      'u_email': userData.uEmail
    };

    http.Response res = await client.post(uri, body: bodyData);
    print(res.statusCode);
    if (res.statusCode == 200) {
      return res.body;
    } else {
      return null;
    }
  }

  // ---------- check user register or not ------------------
  static Future<UsersData?> checkUser(String userId) async {
    var client = http.Client();

    var uri = Uri.parse("$API_URL/userLogin/checkUser");

    // var url = Uri.http(API_URL, "/userLogin/checkUser");

    Map<String, dynamic> bodyData = {'uid': userId};

    var res = await client.post(uri, body: bodyData);

    if (res.statusCode == 200) {
      UsersData userData = UsersData.fromJson(json.decode(res.body));
      return userData;
    }
    return null;
  }

  // ---------- Post for Get OTP Login to API ------------------
  static Future<dynamic> getOTP(String phone, String app_signature) async {
    var client = http.Client();

    final uri = Uri.parse("$API_URL/userLogin/otpLogin");
    Map<String, dynamic> bodyData = {
      'phone': phone,
      'app_signature': app_signature
    };

    http.Response res = await client.post(uri, body: bodyData);
    // print("Result: ${res.body}");
    if (res.statusCode == 200) {
      return res.body;
    }
  }

  // ---------- Post OTP Verify OTP and Hash code to API ------------------
  static Future<dynamic> verifyOTP(String hash, int otp, String phoneNo) async {
    var client = http.Client();
    final uri = Uri.parse("$API_URL/userLogin/verifyOtp");
    Map<String, dynamic> bodyData = {
      'hash': hash,
      'otp': otp.toString(),
      'phone': phoneNo
    };

    http.Response res = await client.post(uri, body: bodyData);
    print("Result: ${res.body}");
    if (res.statusCode == 200) {
      return res.body;
    } else {
      return null;
    }
  }

  // ---------- user Login ------------------
  static Future<String?> userLogin(String loginId, String password) async {
    var uri = Uri.parse("$API_URL/userLogin/logIn");
    Map<String, String> bodyData = {'loginId': loginId, 'password': password};
    var _client = http.Client();
    http.Response res = await _client.post(uri, body: bodyData);

    if (res.statusCode == 200) {
      return "logged";
    }
    if (res.statusCode == 422) {
      return "invalid password";
    } else {
      return null;
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
