import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:latif_it_mobile_developer/app/modules/product/model/product_model.dart';
import 'package:latif_it_mobile_developer/app/modules/product/services/product_api.dart';

class ProductController extends GetxController {
  final _productServices = ProductServices();
  @override
  void onInit() {
    super.onInit();
    getProduct();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }

  var productList = <Product>[].obs;
  var filteredProducts = <Product>[].obs;

  final TextEditingController searchController = TextEditingController();

  Future<void> getProduct() async {
    final result = await _productServices.getProduct();

    if (result != null) {
      List<Product> products =
          (result as List).map((e) => Product.fromJson(e)).toList();

      productList.value = products;
      filteredProducts.value = products;
    }
  }

  void searchProduct(String keyword) {
    if (keyword.isEmpty) {
      filteredProducts.value = productList;
      return;
    }

    filteredProducts.value = productList
        .where((product) =>
            product.title!.toLowerCase().contains(keyword.toLowerCase()))
        .toList();
  }
}
