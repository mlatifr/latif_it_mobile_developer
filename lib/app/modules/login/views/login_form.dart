import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:latif_it_mobile_developer/app/modules/login/controllers/login_controller.dart';

class LoginForm extends StatelessWidget {
  const LoginForm({
    super.key,
    required this.controller,
  });

  final LoginController controller;

  @override
  Widget build(BuildContext context) {
    return Form(
      key: controller.formKey,
      child: Column(
        children: [
          Obx(
            () {
              return TextFormField(
                controller: controller.usernameController,
                enabled: !controller.isLoading.value,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Mohon masukkan username';
                  }
                  return null;
                },
                decoration: const InputDecoration(
                  border: UnderlineInputBorder(),
                  labelText: 'Username',
                ),
              );
            },
          ),
          const SizedBox(height: 12),
          Obx(
            () {
              return TextFormField(
                controller: controller.passwordController,
                enabled: !controller.isLoading.value,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Mohon masukkan password';
                  }
                  return null;
                },
                obscureText: controller.obscureText.value,
                decoration: InputDecoration(
                  border: const UnderlineInputBorder(),
                  labelText: 'Password',
                  suffixIcon: IconButton(
                    icon: Icon(
                      controller.obscureText.value
                          ? Icons.visibility
                          : Icons.visibility_off,
                    ),
                    onPressed: () {
                      controller.obscureText.value =
                          !controller.obscureText.value;
                    },
                  ),
                ),
              );
            },
          ),
          const SizedBox(height: 20),
          Obx(
            () {
              return SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed:
                      controller.isLoading.value ? null : controller.login,
                  child: controller.isLoading.value
                      ? const SizedBox(
                          height: 20,
                          width: 20,
                          child: CircularProgressIndicator(
                            strokeWidth: 2,
                            color: Colors.blue,
                          ),
                        )
                      : const Text('Login'),
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
