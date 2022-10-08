import 'package:get/get.dart';
import 'package:ubs/model/ads_post.dart';
import 'package:ubs/model/categories.dart';
import 'package:ubs/services/remote_services.dart';

class HomeController extends GetxController {
  RxList<AdsPost> adsPostList = List<AdsPost>.empty().obs;
  RxList<AdsPost> catWiseAdsList = List<AdsPost>.empty().obs;
  RxList<AdsPost> relatedCatAdsList = List<AdsPost>.empty().obs;
  RxList<Categories> mainCatList = List<Categories>.empty().obs;
  RxList<Categories> subCatList = List<Categories>.empty().obs;
  
  RxBool listStatus = false.obs;

  RxString typeList = "all".obs;
  RxString hintText = "".obs;
  RxInt mainCat = 0.obs;
  RxInt subCat = 0.obs;

  @override
  void onInit() {
    fetchAds();
    fetchMainCat();
    super.onInit();
  }

  void fetchMainCat() async {
    var mainCat = await RemoteServices.fetchMainCat();
    if (mainCat != null) {
      mainCatList.value = mainCat;
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
    var adsPosts = await RemoteServices.fetchAdsPost();
    if (adsPosts != null) {
      adsPostList.value = adsPosts;
    }
  }

  void fetchCatWiseAds(int mainCatId) async {
    listStatus.value = true;
    var adsPosts = await RemoteServices.fetchCatWisedAds(mainCatId);
    listStatus.value = false;
    if (adsPosts != null) {
      catWiseAdsList.value = [];
      catWiseAdsList.value = adsPosts;
    }
  }

  void fetchRelatedCatWiseAds(int mainCatId) async {
    relatedCatAdsList.value = [];
    var adsPosts = await RemoteServices.fetchCatWisedAds(mainCatId);
    if (adsPosts != null) {
      relatedCatAdsList.value = adsPosts;
    }
  }
}
