import 'package:get/get.dart';
import 'package:ubs/pages/Chats/controller/chats_controller.dart';
import 'package:ubs/pages/Post_details/controller/post_details_controller.dart';
import 'package:ubs/pages/accounts/controller/account_controller.dart';
import 'package:ubs/pages/home/controller/home_controller.dart';
import 'package:ubs/pages/login/controller/login_controller.dart';
import 'package:ubs/pages/my_ads/controller/my_ads_controller.dart';
import 'package:ubs/pages/search_ads/controller/search_controller.dart';
import 'package:ubs/pages/selling/controller/selling_controller.dart';

class MainBinding implements Bindings {
// default dependency
  @override
  void dependencies() {
    Get.lazyPut<LoginController>(() => LoginController(), fenix: true);
    Get.lazyPut<HomeController>(() => HomeController(), fenix: true);
    Get.lazyPut<SearchController>(() => SearchController(), fenix: true);
    // Get.lazyPut<MainController>(() => MainController(), fenix: true);
    Get.lazyPut<PostDetailsController>(() => PostDetailsController(),
        fenix: true);
    Get.lazyPut<SellingController>(() => SellingController(), fenix: true);    
    Get.lazyPut<MyAdsController>(() => MyAdsController(), fenix: true);    
    Get.lazyPut<AccountController>(() => AccountController(), fenix: true);    
    Get.lazyPut<ChatsController>(() => ChatsController(), fenix: true);    
  }
}
