import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/smart_cart_controller.dart';

class SmartCartView extends GetView<SmartCartController> {
  const SmartCartView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('SmartCartView'),
        centerTitle: true,
      ),
      body: const Center(
        child: Text(
          'SmartCartView is working',
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}
