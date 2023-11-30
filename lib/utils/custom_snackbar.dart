import 'package:flutter/material.dart';
import 'package:get/get.dart' show ExtensionSnackbar, Get, SnackPosition;

class CustomSnackbar {
  static void show(String title, String message) {
    Get.snackbar(
      title,
      message,
      snackPosition: SnackPosition.BOTTOM,
      duration: const Duration(seconds: 3),
      backgroundColor: Colors.black,
      colorText: Colors.white,
      borderRadius: 10,
      margin: const EdgeInsets.all(10),
      padding: const EdgeInsets.all(15),
      borderWidth: 2,
      borderColor: Colors.white,
      animationDuration: const Duration(milliseconds: 300),
    );
  }
}
