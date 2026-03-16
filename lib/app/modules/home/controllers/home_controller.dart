import 'package:get/get.dart';

class HomeController extends GetxController {
  //TODO: Implement HomeController

  final count = 0.obs;
  @override
  void onInit() {
    super.onInit();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }

  void increment() => count.value++;

  String getKataTerpanjang(String kata) {
    List<String> listKata = kata.split(' ');

    String terpanjang = '';

    for (int i = 0; i < listKata.length; i++) {
      if (listKata[i].length > terpanjang.length) {
        terpanjang = listKata[i];
      }
    }
    print(terpanjang);
    return terpanjang;
  }
}
