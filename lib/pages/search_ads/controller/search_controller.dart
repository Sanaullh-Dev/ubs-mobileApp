import 'package:get/get.dart';
import 'package:ubs/pages/home/controller/home_controller.dart';
import 'package:ubs/services/remote_services.dart';

class SearchController extends GetxController {
  RxList<String> keywordList = List<String>.empty().obs;
  // RxList<AdsPost> keywordWiseAdsList = List<AdsPost>.empty().obs;
  RxString searchWord = "".obs;
  final HomeController homeCont = Get.find<HomeController>();
  

  void fetchAdsWiseKeyword(String keyword) async {
    var subCat = await RemoteServices.fetchAdsWiseKeyword(keyword);
    if (subCat != null) {
      keywordList.value = subCat;
    }
  }

void fetchKeywordWiseAds(String keyword) async {
    var adsPosts = await RemoteServices.fetchKeywordWisedAds(keyword);
    if (adsPosts != null) {
      // keywordWiseAdsList.value = [];
      // keywordWiseAdsList.value = adsPosts;
      homeCont.catWiseAdsList.value = adsPosts;
    } 
  }
}
