import 'package:get/get.dart';

import '../controllers/home_controller.dart';
import '../../product/controllers/product_controller.dart';
import '../../smart_cart/controllers/smart_cart_controller.dart';
import '../../profile/controllers/profile_controller.dart';

class HomeBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<HomeController>(
      () => HomeController(),
    );
    Get.lazyPut<ProductController>(
      () => ProductController(),
    );
    Get.lazyPut<SmartCartController>(
      () => SmartCartController(),
    );
    Get.lazyPut<ProfileController>(
      () => ProfileController(),
    );
  }
}
