import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:personality_test/widgets/custom_text.dart';

import '../shared/app_font_family/font_family.dart';
import '../shared/resources/app_color.dart';

//region Get SnackBar Method
mySnackBar(String message) {
  if (Get.isSnackbarOpen) {
    Get.closeCurrentSnackbar();
  }
  Get.showSnackbar(
    GetSnackBar(
      barBlur: 10.0,
      snackPosition: SnackPosition.BOTTOM,
      messageText: alignText(message, 14.0, AppColor.primaryWhiteColor,
          FontWeight.bold, TextAlign.start,AppFontFamily.poppinsRegular),
      isDismissible: true,
      duration: const Duration(seconds: 2),
      animationDuration: const Duration(milliseconds: 500),
      borderRadius: 5.0,
      margin: const EdgeInsets.only(left: 5.0, right: 5.0, bottom: 5.0),
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
      backgroundColor: AppColor.headingSpaceCadetColor,
    ),
  );
}
//endregion
