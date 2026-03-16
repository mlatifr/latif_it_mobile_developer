import 'package:get/get.dart';

import '../../product/model/product_model.dart';

class ProductDetailController extends GetxController {
  final Rxn<Product> product = Rxn<Product>();

  @override
  void onInit() {
    super.onInit();
    product.value = Get.arguments as Product?;
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }
}
