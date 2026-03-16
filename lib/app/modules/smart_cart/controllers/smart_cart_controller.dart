import 'package:get/get.dart';
import '../../../data/product_db.dart';

class SmartCartController extends GetxController {
  var cartItems = <Map<String, dynamic>>[].obs;
  var isLoading = false.obs;

  @override
  void onInit() {
    getCartItems();
    super.onInit();
  }

  Future<void> getCartItems() async {
    // try {
    isLoading.value = true;

    final items = await ProductDb.instance.getCartItems();

    cartItems.assignAll(items);
    cartItems.refresh();
    print(cartItems);
    // // } catch (e) {
    //   Get.snackbar("Error", e.toString());
    // } finally {
    isLoading.value = false;
    // }
  }

  Future<void> deleteCartItem(int id) async {
    await ProductDb.instance.deleteCartItem(id);
    await getCartItems();
  }
}
