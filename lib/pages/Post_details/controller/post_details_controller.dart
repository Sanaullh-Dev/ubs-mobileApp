import 'package:get/get.dart';
import 'package:ubs/model/ads_post.dart';
import 'package:ubs/model/users_data.dart';
import 'package:ubs/services/remote_services.dart';

class PostDetailsController extends GetxController {
  Rx<AdsPost> adsPost = AdsPost(
          pId: 0,
          pDate: DateTime.now(),
          pTitle: "",
          pBrand: "",
          pDescribe: "",
          pImg1: "",
          pImg2: "",
          pImg3: "",
          pImg4: "",
          pImg5: "",
          pPrice: 0,
          pLocation: "",
          pMcat: 0,
          pScat: 0,
          pUid: "",
          uName: '',
          pFavorite: 0,
          pView: 0,
          uPhoto: "")
      .obs;
    Rx<int> postFavorite = 0.obs;
  

  getAdsPostDetails(String uid, int pid) async {
    var res = await RemoteServices.getAdsPostDetails(
        uid, pid);
    if (res != null) {
      postFavorite.value = res.pFavorite ?? 0;
      adsPost.value = res;
      fetchUserInfo(res.pUid);
    }
  }

  Rx<UsersData> userData =
      UsersData(uName: "", logId: "", logPass: "", loginWith: "").obs;
   
   fetchUserInfo(String userId) async {
    var res = await RemoteServices.getUserData(userId);
    if (res != null) {
      userData.value = res;
    }
  }
}
