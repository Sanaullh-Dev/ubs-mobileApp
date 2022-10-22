import 'package:get/get.dart';
import 'package:ubs/pages/PostDetails/post_details_controller.dart';
import 'package:ubs/pages/home/controller/home_controller.dart';
import 'package:ubs/pages/login/controller/login_controller.dart';
import 'package:ubs/pages/main_controller.dart';
import 'package:ubs/pages/searchAds/controller/search_controller.dart';
import 'package:ubs/pages/selling/controller/selling_controller.dart';

class MainBinding implements Bindings {
// default dependency
  @override
  void dependencies() {
    Get.lazyPut<logging>(() => logging(), fenix: true);
    Get.lazyPut<HomeController>(() => HomeController(), fenix: true);
    Get.lazyPut<SearchController>(() => SearchController(), fenix: true);
    Get.lazyPut<MainController>(() => MainController(), fenix: true);
    Get.lazyPut<PostDetailsController>(() => PostDetailsController(),
        fenix: true);
    Get.lazyPut<SellingController>(() => SellingController(), fenix: true);
  }
}
