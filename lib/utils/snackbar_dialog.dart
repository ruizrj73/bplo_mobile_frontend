import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:get/get.dart';

showSnackbar(String title, String message) {
  Get.snackbar(title, message,
    padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 20),
    dismissDirection: DismissDirection.horizontal,
    isDismissible: true,
    duration: const Duration(seconds: 3),
    colorText: Colors.white,
    backgroundColor: Colors.black,
    snackPosition: SnackPosition.BOTTOM,
    icon: const Icon(
      Feather.info,
      color: Colors.white,
    )
  );
}