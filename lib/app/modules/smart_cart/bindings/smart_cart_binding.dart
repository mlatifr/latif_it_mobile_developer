import 'package:get/get.dart';

import '../controllers/smart_cart_controller.dart';

class SmartCartBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<SmartCartController>(
      () => SmartCartController(),
    );
  }
}
