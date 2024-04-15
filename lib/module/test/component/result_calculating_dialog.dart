import 'package:flutter/material.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/src/extension_navigation.dart';
import 'package:lottie/lottie.dart';
import 'package:personality_test/module/result/result_success_screen.dart';
import 'package:personality_test/widgets/custom_text.dart';

import '../../../shared/app_font_family/font_family.dart';
import '../../../shared/resources/app_color.dart';
import '../../../shared/resources/images_assets.dart';

Future calculatingResult(BuildContext context) {
  return showDialog(
      barrierDismissible: false,
      context: context,
      builder: (BuildContext ctx) {
        Future.delayed(const Duration(milliseconds: 3500), () {
          Navigator.pop(context, true);
          Get.off(() => const ResultSuccessPage());
        });
        return AlertDialog(
          content: SizedBox(
            width: Get.size.width,
            height: Get.size.height * 0.3,
            child: Column(
              children: [
                Expanded(
                  child: Center(
                    child: Lottie.asset(ImageAssets.calculating),
                  ),
                ),
                customText("Calculating Result", 20, AppColor.primaryColor,
                    FontWeight.bold,AppFontFamily.poppinsRegular),
              ],
            ),
          ),
        );
      });
}
