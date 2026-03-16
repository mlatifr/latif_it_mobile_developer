import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:latif_it_mobile_developer/app/modules/smart_cart/controllers/smart_cart_controller.dart';

class HomeController extends GetxController {
  final count = 0.obs;

  final currentIndex = 0.obs;
  late PageController pageController;

  @override
  void onInit() {
    super.onInit();
    pageController = PageController(initialPage: currentIndex.value);
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    pageController.dispose();
    super.onClose();
  }

  Future<void> changePage(int index) async {
    currentIndex.value = index;
    print(index);
    pageController.jumpToPage(index);
    if (index == 1) {
      Get.find<SmartCartController>().getCartItems();
    }
  }
}
