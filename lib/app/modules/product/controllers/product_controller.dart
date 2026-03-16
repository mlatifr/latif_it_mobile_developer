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
  var selectedCategory = Rxn<Category>();
  var sortOrder = RxnString(); // 'asc' for Low->High, 'desc' for High->Low

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
    applyFilter();
  }

  void applyFilter() {
    String keyword = searchController.text.toLowerCase();

    var result = productList.where((product) {
      final matchesSearch =
          keyword.isEmpty || product.title!.toLowerCase().contains(keyword);
      final matchesCategory = selectedCategory.value == null ||
          product.category == selectedCategory.value;

      return matchesSearch && matchesCategory;
    }).toList();

    if (sortOrder.value == 'asc') {
      result.sort((a, b) => (a.price ?? 0).compareTo(b.price ?? 0));
    } else if (sortOrder.value == 'desc') {
      result.sort((a, b) => (b.price ?? 0).compareTo(a.price ?? 0));
    }

    filteredProducts.value = result;
  }
}
