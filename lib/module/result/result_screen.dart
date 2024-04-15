import 'dart:async';
import 'dart:io';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter_signin_button/button_list.dart';
import 'package:flutter_signin_button/button_view.dart';
import 'package:get/get.dart';
import 'package:path_provider/path_provider.dart' as path_provider;
import 'package:personality_test/shared/resources/images_assets.dart';
import 'package:screenshot/screenshot.dart';
import 'package:share_extend/share_extend.dart';
import '../../controller/result_controller.dart';
import '../../models/data_model.dart';
import '../../shared/app_font_family/font_family.dart';
import '../../shared/resources/app_color.dart';
import '../../utils/my_utils.dart';
import '../../widgets/button_widgets.dart';
import '../../widgets/custom_image.dart';
import '../../widgets/custom_text.dart';
import '../../widgets/radial_painter.dart';
import '../home/home_page.dart';
import '../profile/profile_screen.dart';

class ResultPage extends StatefulWidget {
  const ResultPage({Key? key}) : super(key: key);

  @override
  State<ResultPage> createState() => _ResultPageState();
}

class _ResultPageState extends State<ResultPage> {
  bool isVisible = true;
  late ScreenshotController screenshotController;
  late ResultController _resultController;
  List<String>? resultIndicator;
  String shareText = "";

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

    screenshotController = ScreenshotController();

    shareText = "Hey, I gave the personality test and its result are "
        "surprisingly accurate.\n\nIt says I am an ${_resultController.newModel.combinations![_resultController.personalityIndex].name}"
        " - ${_resultController.newModel.combinations![_resultController.personalityIndex].personality}\n\n${_resultController.newModel.combinations![_resultController.personalityIndex].overview}\n\n\""
        "In few minutes you will learn about yourself then in last 10 "
        "years.\"\n\nGive it a shot, take this test, it may changes the "
        "way you look at yourself forever.\n\nDownload the App from PlayStore";
  }

  String getDataUsingKey(Indicator? indicator, String key) {
    String s = "";
    if (indicator != null) {
      s = indicator.toJson()[key];
    }
    return s;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          color: AppColor.primaryWhiteColor,
          width: double.infinity,
          height: double.infinity,
          child: SingleChildScrollView(
            physics: AlwaysScrollableScrollPhysics(),
            child: Screenshot(
              controller: screenshotController,
              child:  Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
              Stack(
              children: [
                Column(
                  children: [
                    Container(
                      width: Get.width,
                      height: Get.height * 0.4,
                      decoration: const BoxDecoration(
                          image: DecorationImage(
                            fit: BoxFit.fill,
                            image: AssetImage(ImageAssets.resultBg),
                          )),
                      child: Padding(
                        padding: EdgeInsets.all(20),
                        child: customSvgImage(
                          _resultController
                              .newModel
                              .combinations![
                          _resultController.personalityIndex]
                              .svgCharacter!,
                          MediaQuery.of(context).size.width * 0.6,
                          MediaQuery.of(context).size.width * 0.5,
                        ),
                      ),
                    ),
                    Container(
                      width: MediaQuery.of(context).size.width,
                      margin: EdgeInsets.only(top: 20),
                      child: Column(
                        children: [
                          customTextAllInCaps(
                              "Your Test Result is Below",
                              18,
                              AppColor.headingSpaceCadetColor,
                              FontWeight.bold,AppFontFamily.poppinsRegular),
                          RichText(
                            textAlign: TextAlign.center,
                            text: TextSpan(
                              children: [
                                TextSpan(
                                  text:
                                  "${_resultController.newModel.combinations![_resultController.personalityIndex].name} = ",
                                  style: const TextStyle(
                                      fontSize: 16.0,
                                      color:
                                      AppColor.textBlackColor,
                                      fontWeight: FontWeight.bold),
                                ),
                                TextSpan(
                                  text:
                                  "${_resultController.newModel.combinations![_resultController.personalityIndex].abr}",
                                  style: const TextStyle(
                                      fontSize: 18.0,
                                      color: AppColor
                                          .headingSpaceCadetColor,
                                      fontWeight:
                                      FontWeight.normal),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              Visibility(
              visible: isVisible,
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 10.0),
                  child: RawMaterialButton(
                    onPressed: () {
                      Get.offAll(() => const HomePage());
                    },
                    elevation: 1.0,
                    fillColor: Colors.white,
                    child: const Icon(
                      Icons.arrow_back,
                      size: 35.0,
                      color: AppColor.primaryDarkColor,
                    ),
                    padding: const EdgeInsets.all(5.0),
                    shape: const CircleBorder(),
                  ),
                ),
              ),

              ],
            ),
                    Padding(
                      padding: EdgeInsets.symmetric(vertical: 15),
                      child: const Divider(
                        thickness: 1,
                        indent: 10,
                        color: AppColor.lightGreyColor,
                        endIndent: 10,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 10.0, vertical: 5.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          customTextCapitalizeFirstOfEach('Your Test Score', 20,
                              AppColor.textBlackColor, FontWeight.bold,AppFontFamily.poppinsRegular),
                           Container(
                             margin: EdgeInsets.only(top: 10),
                            height: 200,
                            child:  ListView.builder(
                                itemCount: 4,
                                shrinkWrap: true,
                                scrollDirection: Axis.horizontal,
                                itemBuilder: (BuildContext ctx, int i) {
                                  return Container(
                                    width: 120,
                                    margin: EdgeInsets.symmetric(horizontal: 5),
                                    decoration: BoxDecoration(
                                      color: AppColor.resultBGColors[i],
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                    child: Column(
                                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                      children: [
                                        Padding(
                                          padding: const EdgeInsets.all(5.0),
                                          child: Center(
                                            child: customText(
                                                _resultController
                                                    .resultDataList[i].name,
                                                14,
                                                AppColor.resultFilledColors[i],
                                                FontWeight.bold,AppFontFamily.poppinsRegular),
                                          ),
                                        ),
                                        SizedBox(
                                          height: 70,
                                          child: CustomPaint(
                                            foregroundPainter: RadialPainter(
                                                width: 15.0,
                                                lineColor:
                                                AppColor.resultFilledColors[i],
                                                backgroundColor: AppColor
                                                    .resultUnfilledColors[i],
                                                percent: (_resultController
                                                    .resultDataList[i]
                                                    .percentage /
                                                    _resultController.total)),
                                            child: const Center(
                                              child: Text(
                                                "",
                                              ),
                                            ),
                                          ),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.all(5.0),
                                          child: Center(
                                              child: customTextAllInCaps(
                                                  "${((_resultController.resultDataList[i].percentage / _resultController.total) * 100).toStringAsFixed(1)}%",
                                                  18,
                                                  AppColor.resultFilledColors[i],
                                                  FontWeight.bold,AppFontFamily.poppinsRegular)),
                                        )
                                      ],
                                    ),
                                  );
                                }),
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          Visibility(
                              visible: isVisible,
                              child: Column(
                                children: [
                                  Container(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 20.0),
                                    alignment: Alignment.center,
                                    child: alignText(
                                        'Share your personality results with friends and family.',
                                        16,
                                        AppColor.textBlackColor,
                                        FontWeight.normal,
                                        TextAlign.center,AppFontFamily.poppinsRegular),
                                  ),
                                  Container(
                                    width: MediaQuery.of(context).size.width,
                                    margin: const EdgeInsets.all(10.0),
                                    child: Wrap(
                                      direction: Axis.horizontal,
                                      alignment: WrapAlignment.center,
                                      crossAxisAlignment:
                                          WrapCrossAlignment.center,
                                      spacing: 0.0,
                                      runSpacing: 20.0,
                                      children: [
                                        InkWell(
                                          child: Container(
                                            height: 36.0,
                                            width: 36.0,
                                            decoration: BoxDecoration(
                                                color: AppColor.cardColors[3],
                                                borderRadius:
                                                    BorderRadius.circular(3.0)),
                                            child: const Icon(
                                                Icons.whatsapp_outlined,
                                                color: AppColor.whatsAppColor),
                                          ),
                                          onTap: () async {
                                            await showLoading();
                                            setState(() {
                                              isVisible = false;
                                            });
                                            shareResult(_resultController
                                                .newModel
                                                .combinations![_resultController
                                                .personalityIndex]
                                                .name);
                                          },
                                        ),
                                        const SizedBox(width: 5.0),
                                        SignInButton(
                                          Buttons.Twitter,
                                          mini: true,
                                          onPressed: () async {
                                            await showLoading();

                                            setState(() {
                                              isVisible = false;
                                            });
                                            shareResult(_resultController
                                                .newModel
                                                .combinations![_resultController
                                                .personalityIndex]
                                                .name);
                                          },
                                        ),
                                        SignInButton(
                                          Buttons.Facebook,
                                          mini: true,
                                          onPressed: () async {
                                            await showLoading();

                                            setState(() {
                                              isVisible = false;
                                            });
                                            shareResult(_resultController
                                                .newModel
                                                .combinations![_resultController
                                                .personalityIndex]
                                                .name);
                                          },
                                        ),
                                        SignInButton(
                                          Buttons.LinkedIn,
                                          mini: true,
                                          onPressed: () async {
                                            await showLoading();

                                            setState(() {
                                              isVisible = false;
                                            });
                                            shareResult(_resultController
                                                .newModel
                                                .combinations![_resultController
                                                    .personalityIndex]
                                                .name);
                                          },
                                        ),
                                      ],
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 20,
                                  ),
                                ],
                              )),
                          Container(
                            padding: const EdgeInsets.all(10.0),
                            decoration: BoxDecoration(
                              color: AppColor.containerBGColor.withOpacity(0.6),
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.all(10.0),
                                  child: customTextCapitalizeFirst(
                                      "You are \"${_resultController.newModel.combinations![_resultController.personalityIndex].personality}\" because",
                                      18,
                                      AppColor.textBlackColor,
                                      FontWeight.bold,AppFontFamily.poppinsRegular),
                                ),
                                ListView.builder(
                                    physics: const NeverScrollableScrollPhysics(),
                                    shrinkWrap: true,
                                    itemCount: 4,
                                    itemBuilder:
                                        (BuildContext context, int index) {
                                      return Row(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Padding(
                                            padding: const EdgeInsets.symmetric(
                                                horizontal: 5.0, vertical: 10.0),
                                            child: Container(
                                              height: 5,
                                              width: 5,
                                              decoration: const BoxDecoration(
                                                  shape: BoxShape.circle,
                                                  color: AppColor.textBlackColor),
                                            ),
                                          ),
                                          const SizedBox(width: 4.0),
                                          Expanded(
                                            child: customTextCapitalizeFirst(
                                              getDataUsingKey(
                                                  _resultController
                                                      .newModel.indicator,
                                                  resultIndicator![index]
                                                      .toString()
                                                      .toUpperCase()),
                                              15,
                                              AppColor.headingSpaceCadetColor,
                                              FontWeight.normal,AppFontFamily.poppinsRegular
                                            ),
                                          )
                                        ],
                                      );
                                    }),
                              ],
                            ),
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          Container(
                            margin: const EdgeInsets.all(0.0),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10.0),
                              border: Border.all(
                                  color: AppColor.borderColor, width: 1.0),
                            ),
                            child: Column(
                              children: [
                                const SizedBox(height: 10.0),
                                Container(
                                  margin: const EdgeInsets.symmetric(
                                      horizontal: 10.0, vertical: 10.0),
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Padding(
                                        padding: EdgeInsets.only(left: 10),
                                        child: customTextAllInCaps(
                                            'Top Careers',
                                            20,
                                            AppColor.textBlackColor,
                                            FontWeight.bold,AppFontFamily.poppinsRegular),
                                      ),
                                      const SizedBox(
                                        height: 10,
                                      ),
                                      Center(
                                        child: SizedBox(
                                          height: 110,
                                          width: double.infinity,
                                          child: ListView.builder(
                                              shrinkWrap: true,
                                              scrollDirection: Axis.horizontal,
                                              itemCount: _resultController
                                                  .newModel
                                                  .combinations![_resultController
                                                  .personalityIndex]
                                                  .careers!
                                                  .carimage!
                                                  .length,
                                              itemBuilder: (BuildContext ctx, int i) {
                                                return Container(
                                                  width: 90,
                                                  child: Column(
                                                    crossAxisAlignment: CrossAxisAlignment.stretch,
                                                    children: [
                                                      Container(
                                                        width: 70.0,
                                                        height: 70.0,
                                                        clipBehavior: Clip.antiAlias,
                                                        decoration: BoxDecoration(
                                                          color: Colors.transparent,
                                                          image: DecorationImage(
                                                            image: AssetImage(
                                                                _resultController
                                                                    .newModel
                                                                    .combinations![
                                                                _resultController
                                                                    .personalityIndex]
                                                                    .careers!
                                                                    .carimage![i]),
                                                            fit: BoxFit.cover,
                                                          ),
                                                          shape: BoxShape.circle,
                                                          border: Border.all(
                                                            color: Colors.black54
                                                                .withOpacity(0.2),
                                                            width: 1.0,
                                                          ),
                                                        ),
                                                      ),
                                                      Expanded(
                                                          child: customContinueText(
                                                              _resultController
                                                                  .newModel
                                                                  .combinations![
                                                              _resultController
                                                                  .personalityIndex]
                                                                  .careers!
                                                                  .carname![i],
                                                              12,
                                                              AppColor
                                                                  .headingSpaceCadetColor,
                                                              FontWeight.bold,AppFontFamily.poppinsRegular)),
                                                    ],
                                                  ),
                                                );
                                              }),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                        ],
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.symmetric(horizontal: 30),
                      child: Visibility(
                        visible: isVisible,
                        child: defaultButton(
                            '${_resultController.newModel.combinations![_resultController.personalityIndex].personality} Profile',
                            30.0, () {
                          Get.to(() => ProfilePage(
                              index: _resultController.personalityIndex));
                        }),
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                  ],
                ),
            ),
          ),
        ),
      ),
    );
  }

  // region When share button clicked
  void shareResult(String? name) {
    screenshotController.capture().then((Uint8List? image) async {
      try {
        Directory documentDirectory =
            await path_provider.getTemporaryDirectory();
        File file = await File('${documentDirectory.path}/$name.png').create();
        file.writeAsBytesSync(image!);

        await ShareExtend.share(file.path, "Personality App",
            extraText: shareText);
      } finally {
        setState(() {
          isVisible = true;
        });

        Timer(const Duration(seconds: 2), () async {
          await hideLoading();
        });
      }
    }).catchError((onError) {
      debugPrint("onError $onError");

      setState(() {
        isVisible = true;
      });

      Timer(const Duration(seconds: 2), () async {
        await hideLoading();
      });
    });
  }
// endregion

}
