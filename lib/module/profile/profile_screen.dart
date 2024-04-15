// ignore_for_file: file_names

import 'dart:async';
import 'dart:io';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter_signin_button/button_list.dart';
import 'package:flutter_signin_button/button_view.dart';
import 'package:get/get.dart';
import 'package:path_provider/path_provider.dart' as path_provider;
import 'package:pie_chart/pie_chart.dart';
import 'package:screenshot/screenshot.dart';
import 'package:share_extend/share_extend.dart';
import '../../controller/result_controller.dart';
import '../../shared/app_font_family/font_family.dart';
import '../../shared/resources/app_color.dart';
import '../../shared/resources/images_assets.dart';
import '../../utils/my_utils.dart';
import '../../widgets/custom_image.dart';
import '../../widgets/custom_text.dart';

class ProfilePage extends StatefulWidget {
  final int index;
  const ProfilePage({Key? key, required this.index}) : super(key: key);

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  bool isVisible = true;
  late ScreenshotController screenshotController;
  late ResultController _resultController;
  Color personalityColor = AppColor.deepSaffronColor;
  String shareText = "";
  ScrollController scrollController = ScrollController(
    initialScrollOffset: 5,
    keepScrollOffset: false,
  );

  @override
  void initState() {
    super.initState();
    try {
      _resultController = Get.find();
    } catch (exception) {
      _resultController = Get.put(ResultController());
    }
    getPersonalityColor(widget.index);
    _resultController.getPopulationMap(widget.index);
    shareText = "Hey, I gave the personality test and its result are "
        "surprisingly accurate.\n\nIt says I am an ${_resultController.newModel.combinations![_resultController.personalityIndex].name}"
        " - ${_resultController.newModel.combinations![_resultController.personalityIndex].personality}\n\n${_resultController.newModel.combinations![_resultController.personalityIndex].overview}\n\n\""
        "In few minutes you will learn about yourself then in last 10 "
        "years.\"\n\nGive it a shot, take this test, it may changes the "
        "way you look at yourself forever.\n\nDownload the App from PlayStore";

    screenshotController = ScreenshotController();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.primaryWhiteColor,
      body: SafeArea(
        child: SingleChildScrollView(
            child: Screenshot(
          controller: screenshotController,
          child: Container(
            color: AppColor.primaryWhiteColor,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  alignment: Alignment.bottomCenter,
                  decoration: const BoxDecoration(
                    image: DecorationImage(
                      fit: BoxFit.cover,
                      image: AssetImage(ImageAssets.profileBg),
                    ),
                  ),
                  child: Stack(
                    children: [
                      Visibility(
                        visible: isVisible,
                        child: Padding(
                          padding: const EdgeInsets.symmetric(vertical: 10.0),
                          child: RawMaterialButton(
                            onPressed: () {
                              Get.back();
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
                      Column(
                        children: [
                          const SizedBox(height: 40.0),
                          customSvgImage(
                            _resultController.newModel
                                .combinations![widget.index].svgCharacter!,
                            MediaQuery.of(context).size.width * 0.6,
                            MediaQuery.of(context).size.width * 0.5,
                          ),
                          SizedBox(
                            width: MediaQuery.of(context).size.width,
                            child: Column(
                              children: [
                                SizedBox(height: 25,),
                                customTextAllInCaps(
                                    _resultController.personalityIndex ==
                                            widget.index
                                        ? "Your Test Result is Below"
                                        : "Your Result is Below",
                                    18,
                                    AppColor.headingSpaceCadetColor,
                                    FontWeight.bold,AppFontFamily.poppinsRegular),
                                RichText(
                                  textAlign: TextAlign.center,
                                  text: TextSpan(
                                    children: [
                                      TextSpan(
                                        text:
                                        "${_resultController.newModel.combinations![widget.index].name} = ",
                                        style: const TextStyle(
                                            fontSize: 16.0,
                                            color: AppColor.textBlackColor,
                                            fontWeight: FontWeight.bold),
                                      ),
                                      TextSpan(
                                        text:
                                        "${_resultController.newModel.combinations![widget.index].abr}",
                                        style: const TextStyle(
                                            fontSize: 18.0,
                                            color: AppColor
                                                .headingSpaceCadetColor,
                                            fontWeight: FontWeight.normal),
                                      ),
                                    ],
                                  ),
                                ),
                                RichText(
                                  textAlign: TextAlign.center,
                                  text: TextSpan(
                                    children: [
                                      const TextSpan(
                                        text: "Motto : ",
                                        style: TextStyle(
                                            fontSize: 16.0,
                                            color: AppColor.textBlackColor,
                                            fontWeight: FontWeight.bold),
                                      ),
                                      TextSpan(
                                        text:
                                        '${_resultController.newModel.combinations![widget.index].motto}',
                                        style: const TextStyle(
                                            fontSize: 16.0,
                                            color: AppColor
                                                .headingSpaceCadetColor,
                                            fontWeight: FontWeight.normal),
                                      ),
                                    ],
                                  ),
                                ),
                                SizedBox(height: 20,),
                              ],
                            ),
                          )
                        ],
                      )
                    ],
                  ),
                ),
                Container(
                  margin: const EdgeInsets.all(10.0),
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
                            customTextAllInCaps(
                                  'Top Careers',
                                  20,
                                  AppColor.textBlackColor,
                                  FontWeight.bold,AppFontFamily.poppinsRegular),
                            const SizedBox(
                              height: 10,
                            ),
                            SizedBox(
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
                                        crossAxisAlignment: CrossAxisAlignment.start,
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
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  margin: const EdgeInsets.all(10.0),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10.0),
                    border: Border.all(color: AppColor.borderColor, width: 1.0),
                  ),
                  child: Column(
                    children: [
                      const SizedBox(height: 10.0),
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 10.0, vertical: 5.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            customText('Know  your Personality', 20,
                                AppColor.textBlackColor, FontWeight.bold,AppFontFamily.poppinsRegular),
                            const SizedBox(
                              height: 10,
                            ),
                            Container(
                              width: double.infinity,
                              child: Wrap(
                                spacing: 10,
                                runSpacing: 10,
                                direction: Axis.horizontal,
                                children: _resultController.newModel
                                    .combinations![widget.index].traits!.map((e){
                                      return Row(
                                        mainAxisSize: MainAxisSize.min,
                                        children: [
                                          Flexible(
                                            child: Container(
                                              padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                                              decoration: BoxDecoration(
                                                color: AppColor.cardColors[_resultController.newModel
                                                    .combinations![widget.index].traits!.indexOf(e)],
                                                borderRadius: BorderRadius.circular(5),
                                              ),
                                              child: customTextAllInCaps(
                                                  e,
                                                  14,
                                                  AppColor.textColors[_resultController.newModel
                                                      .combinations![widget.index].traits!.indexOf(e)],
                                                  FontWeight.bold,AppFontFamily.poppinsRegular),
                                            ),
                                          ),
                                        ],
                                      );
                                }).toList(),
                              ),
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                Visibility(
                  visible: isVisible,
                  child: (widget.index == _resultController.personalityIndex &&
                          _resultController.isPersonalitySelected)
                      ? Column(
                          children: [
                            const SizedBox(
                              height: 10.0,
                            ),
                            Container(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 20.0),
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
                                crossAxisAlignment: WrapCrossAlignment.center,
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
                                      child: const Icon(Icons.whatsapp_outlined,
                                          color: AppColor.whatsAppColor),
                                    ),
                                    onTap: () async {
                                      await showLoading();

                                      setState(() {
                                        isVisible = false;
                                      });
                                      shareResult(_resultController
                                          .newModel
                                          .combinations![widget.index]
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
                                          .combinations![widget.index]
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
                                          .combinations![widget.index]
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
                                      shareResult(_resultController.newModel
                                          .combinations![widget.index].name);
                                    },
                                  ),
                                ],
                              ),
                            ),
                          ],
                        )
                      : Container(),
                ),
                Visibility(
                  visible: isVisible,
                  child: Container(
                    padding: const EdgeInsets.all(10.0),
                    child: IntrinsicHeight(
                      child: Row(
                        mainAxisSize: MainAxisSize.max,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Expanded(
                            child: Container(
                              constraints: const BoxConstraints.expand(),
                              height: double.infinity,
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 10.0, vertical: 5.0),
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10.0),
                                  color: AppColor.containerStrengthsBGColor),
                              child: Column(
                                mainAxisSize: MainAxisSize.max,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    children: [
                                      Expanded(
                                        child: customText(
                                            'Strengths',
                                            18,
                                            AppColor.textBlackColor,
                                            FontWeight.bold,AppFontFamily.poppinsRegular),
                                      ),
                                      customSvgImage(
                                        ImageAssets.iconStrength,
                                        40.0,
                                        40.0,
                                      )
                                    ],
                                  ),
                                  Container(
                                    padding: const EdgeInsets.symmetric(
                                        vertical: 5.0, horizontal: 10.0),
                                    decoration: BoxDecoration(
                                        borderRadius:
                                            BorderRadius.circular(5.0),
                                        color: AppColor.charStrengthsBGColor),
                                    child: customTextAllInCaps(
                                        _resultController.newModel
                                            .combinations![widget.index].name,
                                        14,
                                        AppColor.charStrengthsTextColor,
                                        FontWeight.normal,AppFontFamily.poppinsRegular),
                                  ),
                                  const SizedBox(height: 10.0),
                                  Column(
                                    children: _resultController.newModel
                                        .combinations![widget.index].strengths!
                                        .map((e) => Row(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Padding(
                                                  padding: const EdgeInsets
                                                          .symmetric(
                                                      vertical: 10.0),
                                                  child: Container(
                                                    height: 5,
                                                    width: 5,
                                                    decoration:
                                                        const BoxDecoration(
                                                            shape:
                                                                BoxShape.circle,
                                                            color: AppColor
                                                                .textBlackColor),
                                                  ),
                                                ),
                                                const SizedBox(width: 5.0),
                                                Expanded(
                                                  child:
                                                      customTextCapitalizeFirst(
                                                    e.toUpperCase(),
                                                    12,
                                                    AppColor
                                                        .headingSpaceCadetColor,
                                                    FontWeight.normal,AppFontFamily.poppinsRegular
                                                  ),
                                                )
                                              ],
                                            ))
                                        .toList(),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          const SizedBox(width: 10.0),
                          Expanded(
                            child: Container(
                              constraints: const BoxConstraints.expand(),
                              height: double.infinity,
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 10.0, vertical: 5.0),
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10.0),
                                  color: AppColor.containerWeeknessBGColor),
                              child: Column(
                                mainAxisSize: MainAxisSize.max,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    children: [
                                      Expanded(
                                        child: customText(
                                            'Weakness',
                                            18,
                                            AppColor.textBlackColor,
                                            FontWeight.bold,AppFontFamily.poppinsRegular),
                                      ),
                                      customSvgImage(
                                        ImageAssets.iconWeekness,
                                        40.0,
                                        40.0,
                                      )
                                    ],
                                  ),
                                  Container(
                                    padding: const EdgeInsets.symmetric(
                                        vertical: 5.0, horizontal: 10.0),
                                    decoration: BoxDecoration(
                                        borderRadius:
                                            BorderRadius.circular(5.0),
                                        color: AppColor.charWeeknessBGColor),
                                    child: customTextAllInCaps(
                                        _resultController.newModel
                                            .combinations![widget.index].name,
                                        14,
                                        AppColor.charWeeknessTextColor,
                                        FontWeight.normal,AppFontFamily.poppinsRegular),
                                  ),
                                  const SizedBox(height: 10.0),
                                  Column(
                                    children: _resultController.newModel
                                        .combinations![widget.index].weaknesses!
                                        .map((e) => Row(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Padding(
                                                  padding: const EdgeInsets
                                                          .symmetric(
                                                      vertical: 10.0),
                                                  child: Container(
                                                    height: 5,
                                                    width: 5,
                                                    decoration:
                                                        const BoxDecoration(
                                                            shape:
                                                                BoxShape.circle,
                                                            color: AppColor
                                                                .textBlackColor),
                                                  ),
                                                ),
                                                const SizedBox(width: 5.0),
                                                Expanded(
                                                  child:
                                                      customTextCapitalizeFirst(
                                                    e.toUpperCase(),
                                                    12,
                                                    AppColor
                                                        .headingSpaceCadetColor,
                                                    FontWeight.normal,AppFontFamily.poppinsRegular
                                                  ),
                                                )
                                              ],
                                            ))
                                        .toList(),
                                  )
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                Visibility(
                  visible: isVisible,
                  child: Container(
                    width: MediaQuery.of(context).size.width,
                    margin: const EdgeInsets.all(10.0),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10.0),
                      border:
                          Border.all(color: AppColor.borderColor, width: 1.0),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(height: 10.0),
                        Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 10.0, vertical: 5.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              customTextAllInCapsWithUnderline('Relationship', 20,
                                  AppColor.textBlackColor, FontWeight.bold,AppFontFamily.poppinsRegular),
                              const SizedBox(
                                height: 10,
                              ),
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [

                                  customRelation(
                                      _resultController
                                          .newModel
                                          .combinations![widget.index]
                                          .relationship!
                                          .asParent,
                                      ImageAssets.iconAsParentPng,
                                      " As Parents".toUpperCase()),
                                  customRelation(
                                      _resultController
                                          .newModel
                                          .combinations![widget.index]
                                          .relationship!
                                          .asPartner,
                                      ImageAssets.iconAsPartnerPng,
                                      "As Partner".toUpperCase()),
                                  customRelation(
                                      _resultController
                                          .newModel
                                          .combinations![widget.index]
                                          .relationship!
                                          .asFriend,
                                      ImageAssets.iconAsFriendPng,
                                      "As Friends".toUpperCase()),
                                ],
                              )
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Visibility(
                  visible: isVisible,
                  child: Container(
                    width: MediaQuery.of(context).size.width,
                    margin: const EdgeInsets.all(10.0),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10.0),
                        color: AppColor.containerBGColor),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(height: 10.0),
                        Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 10.0, vertical: 5.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              customTextAllInCaps('Ten Rules Achieve Success',
                                  18, AppColor.textBlackColor, FontWeight.bold,AppFontFamily.poppinsRegular),
                              const SizedBox(
                                height: 10,
                              ),
                              ListView.builder(
                                  shrinkWrap: true,
                                  physics: const NeverScrollableScrollPhysics(),
                                  controller: scrollController,
                                  itemCount: _resultController
                                      .newModel
                                      .combinations![widget.index]
                                      .rules!
                                      .length,
                                  itemBuilder: (BuildContext ctx, int id) {
                                    return Row(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          customTextCapitalizeFirst(
                                              id < 9
                                                  ? ' ${id + 1}. '
                                                  : '${id + 1}. ',
                                              14,
                                              AppColor.headingSpaceCadetColor,
                                              FontWeight.bold,AppFontFamily.poppinsRegular),
                                          Expanded(
                                              child: customTextCapitalizeFirst(
                                                  _resultController
                                                      .newModel
                                                      .combinations![
                                                          widget.index]
                                                      .rules![id],
                                                  14,
                                                  AppColor.textBlackColor,
                                                  FontWeight.normal,AppFontFamily.poppinsRegular))
                                        ]);
                                  }),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(height: 50,),
                Container(
                  margin: const EdgeInsets.symmetric(
                      horizontal: 10.0, vertical: 10.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      customContinueText(
                          'Famous ${_resultController.newModel.combinations![widget.index].name}\'s',
                          20,
                          AppColor.textBlackColor,
                          FontWeight.bold,AppFontFamily.poppinsRegular),
                      const SizedBox(height: 10),
                      SizedBox(
                        height: 110,
                        child: ListView.builder(
                            shrinkWrap: true,
                            scrollDirection: Axis.horizontal,
                            itemCount:  _resultController
                                .newModel
                                .combinations![widget.index]
                                .person!
                                .personName!
                                .length,
                            itemBuilder: (BuildContext ctx, int i) {
                              return Container(
                                width: 90,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Container(
                                      width: 70.0,
                                      height: 70.0,
                                      clipBehavior: Clip.antiAlias,
                                      decoration: BoxDecoration(
                                        color: Colors.transparent,
                                        image: DecorationImage(
                                         image: AssetImage(_resultController
                                            .newModel
                                            .combinations![widget.index]
                                            .person!
                                            .personImage![i]),
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
                                                .combinations![widget.index]
                                                .person!
                                                .personName![i],
                                            12,
                                            AppColor
                                                .headingSpaceCadetColor,
                                            FontWeight.bold,AppFontFamily.poppinsRegular)),
                                  ],
                                ),
                              );
                            }),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 50,),
                Container(
                  width: MediaQuery.of(context).size.width,
                  margin: const EdgeInsets.all(10.0),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10.0),
                    border: Border.all(color: AppColor.borderColor, width: 1.0),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(height: 10.0),
                      Padding(
                        padding: const EdgeInsets.only(
                            top: 20,left: 20,bottom: 20),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            customText(
                                'Population of ${_resultController.newModel.combinations![widget.index].name}\'s in World',
                                20,
                                AppColor.textBlackColor,
                                FontWeight.bold,AppFontFamily.poppinsRegular),
                          ],
                        ),
                      ),
                      PieChart(
                        dataMap: _resultController.populationMap,
                        animationDuration: const Duration(milliseconds: 500),
                        chartLegendSpacing: 10,
                        chartRadius: 200,
                        initialAngleInDegree: 0,
                        chartType: ChartType.disc,
                        ringStrokeWidth: 180,
                        legendOptions: const LegendOptions(
                          showLegendsInRow: false,
                          legendPosition: LegendPosition.left,
                          legendShape: BoxShape.circle,
                          showLegends: true,
                          legendTextStyle: TextStyle(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        chartValuesOptions: const ChartValuesOptions(
                          showChartValueBackground: true,
                          showChartValues: true,
                          decimalPlaces: 2,
                          showChartValuesInPercentage: false,
                          showChartValuesOutside: false,
                        ),
                        colorList: AppColor.pieChartNewColors,
                      ),
                      SizedBox(height: 20,),
                    ],
                  ),
                ),
              ],
            ),
          ),
        )),
      ),
    );
  }

  customRelation(List<String>? asRelation, String icon, String title) {
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 5),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            customImage(icon, 50, 50),
            customText(title, 13, AppColor.headingSpaceCadetColor, FontWeight.bold,AppFontFamily.poppinsRegular),
            const SizedBox(height: 5),
            ListView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: asRelation?.length,
                itemBuilder: (BuildContext ctx, int id) {
                  return customTextCapitalizeFirst("• ${asRelation![id]}", 13, AppColor.textBlackColor, FontWeight.normal,AppFontFamily.poppinsRegular);
                }),
          ],
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

  void getPersonalityColor(int index) {
    if (index >= 0 && index <= 3) {
      personalityColor = AppColor.analystColor;
    } else if (index >= 4 && index <= 7) {
      personalityColor = AppColor.diplomatsColor;
    } else if (index >= 8 && index <= 11) {
      personalityColor = AppColor.sentinelsColor;
    } else {
      personalityColor = AppColor.explorersColor;
    }
  }
}
