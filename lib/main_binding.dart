import 'package:get/get.dart';
import 'package:ubs/pages/PostDetails/post_details_controller.dart';
import 'package:ubs/pages/home/controller/home_controller.dart';
import 'package:ubs/pages/main_controller.dart';
import 'package:ubs/pages/searchAds/controller/search_controller.dart';
import 'package:ubs/pages/selling/controller/selling_controller.dart';

class MainBinding implements Bindings {
// default dependency
 @override
 void dependencies() {
   Get.lazyPut(() => HomeController());
   Get.lazyPut(() => SearchController());
   Get.lazyPut(() => MainController());
   Get.lazyPut(() => PostDetailsController());
   Get.lazyPut(() => SellingController());
 }


}
 