import 'package:flutter/material.dart';
import 'package:get/get.dart';

void showInf(String inf) {
  Get.snackbar("", "",
      snackPosition: SnackPosition.BOTTOM,
      snackStyle: SnackStyle.FLOATING,
      duration: const Duration(seconds: 2),
      animationDuration: const Duration(milliseconds: 300),
      messageText: Container(
        height: 110,
        alignment: Alignment.topCenter,
        child: Container(
            alignment: Alignment.center,
            height: 80,
            width: double.infinity,
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: Get.theme.secondaryHeaderColor,
              border: Border.all(color: Get.theme.primaryColor, width: 3),
              boxShadow: const [
                BoxShadow(
                  color: Color(0x19000000),
                  spreadRadius: 2.0,
                  blurRadius: 8.0,
                  offset: Offset(2, 4),
                )
              ],
              borderRadius: BorderRadius.circular(4),
            ),
            child: Text(
              inf,
              textAlign: TextAlign.center,
              style: const TextStyle(color: Colors.black),
            )),
      ),
      overlayBlur: 0.0,
      barBlur: 0.0,
      backgroundColor: Colors.blue.withOpacity(0));
}
