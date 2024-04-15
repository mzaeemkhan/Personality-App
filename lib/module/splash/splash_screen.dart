import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/src/extension_navigation.dart';
import 'package:page_transition/page_transition.dart';
import 'package:personality_test/module/home/home_page.dart';
import 'package:personality_test/shared/resources/images_assets.dart';
import 'package:personality_test/widgets/custom_image.dart';
import 'package:personality_test/widgets/custom_text.dart';

import '../../shared/app_font_family/font_family.dart';
import '../../shared/resources/app_color.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    screenCheck();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.primaryWhiteColor,
      body: Container(
        height: double.infinity,
        width: double.infinity,
        child: SafeArea(
          child: Column(
            children: [
              Expanded(
                flex: 3,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(
                        height: Get.size.height / 4,
                        width: Get.size.width / 2,
                        child: assetImage(ImageAssets.mbtiCharacter)),
                    customText("Personality Test", 28, AppColor.navyBlueColor,
                        FontWeight.bold,AppFontFamily.poppinsRegular),
                  ],
                ),
              ),
              Expanded(
                  flex: 0,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                        vertical: 20.0, horizontal: 20),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        logoImage(ImageAssets.atruleLogo, 50, 50),
                        logoTextWidget(
                          "ATRULE Technologies",
                          const TextStyle(
                              fontSize: 16.0, color: AppColor.logoColor),
                        ),
                      ],
                    ),
                  ))
            ],
          ),
        ),
      ),
    );
  }

  screenCheck() async {
    Timer(const Duration(seconds: 3), () {
      Navigator.pushReplacement(
        context,
        PageTransition(
            type: PageTransitionType.fade,
            duration: const Duration(milliseconds: 1200),
            child: const HomePage()),
      );
    });
  }
}
