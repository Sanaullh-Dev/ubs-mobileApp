import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:ubs/model/ads_post.dart';
import 'package:ubs/model/categories.dart';
import 'package:ubs/model/user_info.dart';
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

// **************************** user login ************************************

  // ---------------- user registration ( user data save in database) --------------------
  static Future<dynamic> addUser(UserInfo userData, String loginType) async {
    var uri = Uri.parse("$API_URL/userLogin/singUp");
    Map<String, dynamic> bodyData;
      bodyData = {
        'log_pass': userData.logPass,
        'u_name': userData.uName,
        'login_with': userData.loginWith,
        'u_phone': userData.uPhone,
        'u_email' : userData.uEmail
      };
   
    http.Response res = await http.post(uri, body: bodyData);
    print(res.statusCode);
    if (res.statusCode == 200) {
      return res.body;
    } else {
      return null;
    }
  }

  // ---------- check user register or not ------------------
  static Future<dynamic> checkUser(String userId) async {
    var uri = Uri.parse("$API_URL/userLogin/checkUser");

    Map<String, dynamic> bodyData = {'uid': userId};

    http.Response res = await http.post(uri, body: bodyData);

    if (res.statusCode == 200) {
      var jsonString = res.body;
      return jsonString;
    } else {
      return null;
    }
  }

  // ---------- Post for Get OTP Login to API ------------------
  static Future<dynamic> getOTP(String phone, String app_signature) async {
    final uri = Uri.parse("$API_URL/userLogin/otpLogin");
    Map<String, dynamic> bodyData = {
      'phone': phone,
      'app_signature': app_signature
    };

    http.Response res = await http.post(uri, body: bodyData);
    // print("Result: ${res.body}");
    if (res.statusCode == 200) {
      return res.body;
    }
  }

  // ---------- Post OTP Verify OTP and Hash code to API ------------------
  static Future<dynamic> verifyOTP(String hash, int otp, String phoneNo) async {
    final uri = Uri.parse("$API_URL/userLogin/verifyOtp");
    Map<String, dynamic> bodyData = {
      'hash': hash,
      'otp': otp.toString(),
      'phone': phoneNo
    };

    http.Response res = await http.post(uri, body: bodyData);
    print("Result: ${res.body}");
    if (res.statusCode == 200) {
      return res.body;
    } else {
      return null;
    }
  }

  // ---------- user Login ------------------
  static Future<dynamic> userLogin(String loginId, String password) async {
    var uri = Uri.parse("$API_URL/userLogin/logIn");
    Map<String, dynamic> bodyData = {'loginId': loginId, 'password': password};
    http.Response res = await http.post(uri, body: bodyData);

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
