import 'package:get/get.dart';
import 'package:ubs/model/ads_post.dart';
import 'package:ubs/services/remote_services.dart';

class MyAdsController extends GetxController {
  RxList<AdsPost> adsList = List<AdsPost>.empty().obs;
  RxList<AdsPost> mySalesAdsList = List<AdsPost>.empty().obs;
  RxBool myAdsLoading = false.obs;
  RxBool favoritesAdsLoading = false.obs;

  void fetchFavoriteAds(String userId) async {
    favoritesAdsLoading.value = true;
    var data = await RemoteServices.fetchFavoritesAds(userId);
    if (data != null) {
      adsList.value = data;
      favoritesAdsLoading.value = false;
    }
  }

  void fetchMySalesAds(String userId) async {
    myAdsLoading.value = true;
    var data = await RemoteServices.fetchMySalesAds(userId);
    if (data != null) {
      mySalesAdsList.value = data;
      myAdsLoading.value = false;
    }
  }

}
