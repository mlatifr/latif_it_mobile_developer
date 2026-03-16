import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:latif_it_mobile_developer/app/modules/login/views/login_form.dart';

import '../controllers/login_controller.dart';

class LoginView extends GetView<LoginController> {
  const LoginView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
      ),
      body: Center(
        child: ListView(
          padding: const EdgeInsets.all(20),
          children: [
            SizedBox(
              height: Get.height * 0.2,
              child: Image.asset(
                'assets/login_logo.png',
                fit: BoxFit.contain,
              ),
            ),
            const Text(
              'Login',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            LoginForm(controller: controller),
          ],
        ),
      ),
    );
  }
}
