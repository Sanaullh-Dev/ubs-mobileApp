import 'package:get/get.dart';
import 'package:ubs/model/ads_post.dart';
import 'package:ubs/services/remote_services.dart';

class PostDetailsController extends GetxController {
  Rx<AdsPost> adsPost = AdsPost(
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
          pUid: "")
      .obs;

  @override
  void onInit() {
    super.onInit();
  }

  addAdsPostData(AdsPost adsPostData) {
      adsPost.value = adsPostData; 
  }
  
 

}
