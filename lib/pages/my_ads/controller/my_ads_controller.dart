import 'package:get/get.dart';
import 'package:ubs/model/ads_post.dart';
import 'package:ubs/services/remote_services.dart';

class MyAdsController extends GetxController {
  RxList<AdsPost> adsList = List<AdsPost>.empty().obs;
  RxList<AdsPost> mySalesAdsList = List<AdsPost>.empty().obs;
  // RxBool loading = true.obs;

  void fetchFavoriteAds(String userId) async {
    var data = await RemoteServices.fetchFavoritesAds(userId);
    if (data != null) {
      adsList.value = data;
      // loading.value = false;
    }
  }

  void fetchMySalesAds(String userId) async {
    var data = await RemoteServices.fetchMySalesAds(userId);
    if (data != null) {
      mySalesAdsList.value = data;
    }
  }

}
