import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:latif_it_mobile_developer/app/modules/login/services/login_api.dart';
import 'package:latif_it_mobile_developer/app/routes/app_pages.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginController extends GetxController {
  @override
  void onInit() {
    super.onInit();
    isAlreadyLogin();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
    usernameController.dispose();
    passwordController.dispose();
  }

  final formKey = GlobalKey<FormState>();

  final usernameController = TextEditingController(text: 'mor_2314');
  final passwordController = TextEditingController(text: '83r5^_');

  final obscureText = true.obs;
  final isLoading = false.obs;

  final _userServices = UserServices();
  Future<void> login() async {
    if (!formKey.currentState!.validate()) return;

    isLoading.value = true;
    try {
      final result = await _userServices.login(
        username: usernameController.text.trim(),
        password: passwordController.text,
      );

      final token = result;
      const message = 'Login berhasil';

      if (token != null) {
        final prefs = await SharedPreferences.getInstance();
        await prefs.setString('accessToken', token);
        Get.snackbar('Sukses', message,
            snackPosition: SnackPosition.BOTTOM,
            duration: const Duration(seconds: 2));

        Get.offAllNamed(Routes.HOME);
        return;
      }

      const errorMessage = 'Login gagal';
      Get.snackbar('Kesalahan', errorMessage,
          snackPosition: SnackPosition.BOTTOM);
    } catch (err) {
      Get.snackbar('Kesalahan', err.toString(),
          snackPosition: SnackPosition.BOTTOM);
    } finally {
      isLoading.value = false;
    }
  }

  isAlreadyLogin() async {
    final prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString('accessToken');
    if (token != null && token.isNotEmpty) {
      Get.offAllNamed(Routes.HOME);
    }
  }
}
