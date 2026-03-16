import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
// import 'package:location/location.dart';

class ProfileController extends GetxController {
  final picker = ImagePicker();

  var imagePath = ''.obs;

  final nameController = TextEditingController(text: "Latif");
  final positionController = TextEditingController(text: "IT Mobile Developer");
  final emailController =
      TextEditingController(text: "Jl. Arjuno 38, pepelegi, waru, sidoarjo");
  var latController = TextEditingController();
  var longController = TextEditingController();

  @override
  void onInit() {
    loadImage();
    super.onInit();
  }

  Future pickFromCamera() async {
    final picked = await picker.pickImage(source: ImageSource.camera);

    if (picked != null) {
      await saveImage(File(picked.path));
    }
  }

  Future pickFromGallery() async {
    final picked = await picker.pickImage(source: ImageSource.gallery);

    if (picked != null) {
      await saveImage(File(picked.path));
    }
  }

  Future saveImage(File image) async {
    final directory = await getApplicationDocumentsDirectory();

    final fileName = "profile_${DateTime.now().millisecondsSinceEpoch}.jpg";

    final savedImage = await image.copy("${directory.path}/$fileName");

    final prefs = await SharedPreferences.getInstance();
    await prefs.setString("profile_image", savedImage.path);

    imagePath.value = savedImage.path;
  }

  Future loadImage() async {
    final prefs = await SharedPreferences.getInstance();
    imagePath.value = prefs.getString("profile_image") ?? "";
  }

  /// plugin error crash dengan gradle saya:
  ///
  ///
  // Future<void> getLocation() async {
  //   Location location = Location();

  //   bool serviceEnabled;
  //   PermissionStatus permissionGranted;
  //   LocationData locationData;

  //   serviceEnabled = await location.serviceEnabled();
  //   if (!serviceEnabled) {
  //     serviceEnabled = await location.requestService();
  //     if (!serviceEnabled) {
  //       Get.snackbar("Error", "GPS tidak aktif");
  //       return;
  //     }
  //   }

  //   permissionGranted = await location.hasPermission();
  //   if (permissionGranted == PermissionStatus.denied) {
  //     permissionGranted = await location.requestPermission();
  //     if (permissionGranted != PermissionStatus.granted) {
  //       Get.snackbar("Error", "Izin lokasi ditolak");
  //       return;
  //     }
  //   }

  //   if (permissionGranted == PermissionStatus.deniedForever) {
  //     Get.snackbar("Error",
  //         "Permission lokasi ditolak permanen. Silakan cek pengaturan HP.");
  //     return;
  //   }

  //   await location.changeSettings(accuracy: LocationAccuracy.high);

  //   try {
  //     locationData = await location.getLocation();

  //     latController.text = locationData.latitude.toString();
  //     longController.text = locationData.longitude.toString();
  //   } catch (e) {
  //     Get.snackbar("Error", "Gagal mengambil lokasi: $e");
  //   }
  // }
}
