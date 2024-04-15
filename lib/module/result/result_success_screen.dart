import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../controller/result_controller.dart';
import '../../shared/app_font_family/font_family.dart';
import '../../shared/resources/app_color.dart';
import '../../shared/resources/images_assets.dart';
import '../../widgets/button_widgets.dart';
import '../../widgets/custom_image.dart';
import '../../widgets/custom_text.dart';
import 'result_screen.dart';

class ResultSuccessPage extends StatefulWidget {
  const ResultSuccessPage({Key? key}) : super(key: key);

  @override
  State<ResultSuccessPage> createState() => _ResultSuccessPageState();
}

class _ResultSuccessPageState extends State<ResultSuccessPage> {
  late ResultController _resultController;
  List<String>? resultIndicator;
  String name = "";

  @override
  void initState() {
    try {
      _resultController = Get.find();
    } catch (exception) {
      _resultController = Get.put(ResultController());
    }
    resultIndicator = _resultController
        .newModel.combinations![_resultController.personalityIndex].name
        ?.split("");
    super.initState();
    getName();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.primaryWhiteColor,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Stack(
               alignment: Alignment.topCenter,
                children: [
                  SizedBox(
                    width: Get.width,
                    child: assetImage(
                      ImageAssets.resultHeadCongratulations,
                    ),
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SizedBox(height: Get.height * 0.2,),
                      customText("Congratulations!", 25.0,
                          AppColor.textBlackColor, FontWeight.normal,AppFontFamily.poppinsMedium),
                      customText(name.toUpperCase(), 30.0,
                          AppColor.textBlackColor, FontWeight.bold,AppFontFamily.poppinsSemiBold),
                      assetImage(ImageAssets.resultCongratulations),
                    ],
                  ),
                ],
              ),
              customTextAllInCaps("Your 4 - Letter Code is", 13.0,
                  AppColor.darkGrayColor, FontWeight.bold,AppFontFamily.poppinsSemiBold),
              customTextAllInCaps(
                  "${_resultController.newModel.combinations![_resultController.personalityIndex].name}",
                  60.0,
                  AppColor.resultCodeColor,
                  FontWeight.bold,AppFontFamily.poppinsSemiBold),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20.0),
                child: customAlignTextAllInCaps(
                    _resultController.newModel
                        .combinations![_resultController.personalityIndex].abr,
                    17.0,
                    AppColor.darkGrayColor,
                    FontWeight.bold,AppFontFamily.poppinsSemiBold),
              ),
              const SizedBox(height: 30.0),
            ],
          ),
        ),
      ),
      bottomNavigationBar: Container(
        margin: const EdgeInsets.all(20.0),
        child: defaultButton("CONTINUE TO RESULT", 50.0, () {
          Get.off(() => const ResultPage());
        }),
      ),
    );
  }

  getName() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    setState(() {
      name = preferences.getString("name")!;
    });
  }
}
