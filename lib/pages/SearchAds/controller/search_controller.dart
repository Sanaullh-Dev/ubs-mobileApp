import 'package:get/get.dart';
import 'package:ubs/model/ads_post.dart';
import 'package:ubs/pages/home/controller/home_controller.dart';
import 'package:ubs/services/remote_services.dart';

class SearchController extends GetxController {
  RxList<String> keywordList = List<String>.empty().obs;
  RxList<AdsPost> keywordWiseAdsList = List<AdsPost>.empty().obs;
  RxString searchWord = "".obs;
  // RxBool listStatus = false.obs;

  // RxBool allAds = true.obs;
    

  @override
  void onInit() {
    super.onInit();
  }

  void fetchAdsWiseKeyword(String keyword) async {
    var subCat = await RemoteServices.fetchAdsWiseKeyword(keyword);
    if (subCat != null) {
      keywordList.value = subCat;
    }
  }

  void fetchKeywordWiseAds(String keyword) async {
    searchWord.value = keyword;
    var adsPosts = await RemoteServices.fetchKeywordWisedAds(keyword);
    if (adsPosts != null) {
      keywordWiseAdsList.value = [];
      keywordWiseAdsList.value = adsPosts;
    }
  }
}
