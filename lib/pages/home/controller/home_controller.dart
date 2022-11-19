import 'package:get/get.dart';
import 'package:ubs/model/ads_post.dart';
import 'package:ubs/model/categories.dart';
import 'package:ubs/pages/login/controller/login_controller.dart';
import 'package:ubs/services/remote_services.dart';
import 'package:ubs/utils/custom_fun.dart';

class HomeController extends GetxController {
  RxList<AdsPost> adsPostList = List<AdsPost>.empty().obs;
  RxList<AdsPost> catWiseAdsList = List<AdsPost>.empty().obs;
  RxList<AdsPost> relatedCatAdsList = List<AdsPost>.empty().obs;
  RxList<Categories> mainCatList = List<Categories>.empty().obs;
  RxList<Categories> subCatList = List<Categories>.empty().obs;
  RxBool isLoading = false.obs;

  RxBool listStatus = false.obs;

  RxString typeList = "all".obs;
  RxString hintText = "".obs;
  RxInt mainCat = 0.obs;
  RxInt subCat = 0.obs;

  // @override
  // void onInit() {
  //   // fetchMainCat();
  //   super.onInit();
  // }

  fetchMainCat() async {
    isLoading.value = true;
    var mainCat = await RemoteServices.fetchMainCat();
    if (mainCat != null) {
      mainCatList.value = mainCat;
      isLoading.value = false;
    }
  }

  void fetchSubCat(int mainCatId) async {
    var subCat = await RemoteServices.fetchSubCat(mainCatId);
    if (subCat != null) {
      subCatList.value = subCat;
    }

    // this code for view all list item
    subCatList.value.add(Categories.fromJson({
      "cat_id": mainCatId,
      "cat_name": "View All",
      "cat_subid": 0,
      "cat_img": ""
    }));
  }

  fetchAds() async {
    isLoading.value = true;
    var userId = await getLoginId();
    if (userId != "") {
      var adsPosts = await RemoteServices.fetchAdsPost(userId);
      if (adsPosts != null) {
        adsPostList.value = adsPosts;
        isLoading.value = false;
      }
    }
  }

  void fetchCatWiseAds(String userId, int mainCatId) async {
    listStatus.value = true;
    var adsPosts = await RemoteServices.fetchCatWisedAds(userId, mainCatId);
    listStatus.value = false;
    if (adsPosts != null) {
      catWiseAdsList.value = [];
      catWiseAdsList.value = adsPosts;
    }
  }

  void fetchRelatedCatWiseAds(String userId, int mainCatId) async {
    relatedCatAdsList.value = [];
    var adsPosts = await RemoteServices.fetchCatWisedAds(userId, mainCatId);
    if (adsPosts != null) {
      relatedCatAdsList.value = adsPosts;
    }
  }
}
