import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../data/product_db.dart';
import '../../product/model/product_model.dart';

class ProductDetailController extends GetxController {
  final Rxn<Product> product = Rxn<Product>();

  final RxInt quantity = 1.obs;

  double get subtotal {
    return (product.value?.price ?? 0.0) * quantity.value;
  }

  double get discount {
    if (subtotal > 200) {
      return subtotal * 0.1;
    }
    return 0.0;
  }

  double get totalPrice {
    return subtotal - discount;
  }

  @override
  void onInit() {
    super.onInit();
    product.value = Get.arguments as Product?;
  }

  void incrementQuantity() {
    quantity.value++;
  }

  void decrementQuantity() {
    if (quantity.value > 1) {
      quantity.value--;
    }
  }

  Future<void> addToCart() async {
    final curProduct = product.value;
    if (curProduct == null) return;

    final item = {
      'product_id': curProduct.id,
      'product_title': curProduct.title,
      'product_image': curProduct.image,
      'category': categoryValues.reverse[curProduct.category] ?? '',
      'price': curProduct.price,
      'quantity': quantity.value,
      'subtotal': totalPrice,
      'created_at': DateTime.now().toIso8601String()
    };

    await ProductDb.instance.addToCart(item);
    Get.snackbar(
      'Success',
      'Added to cart successfully!',
      snackPosition: SnackPosition.BOTTOM,
    );
  }
}
