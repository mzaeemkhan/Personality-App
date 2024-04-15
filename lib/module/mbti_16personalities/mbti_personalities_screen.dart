import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:personality_test/models/data_model.dart';

import '../../controller/result_controller.dart';
import '../../shared/app_font_family/font_family.dart';
import '../../shared/resources/app_color.dart';
import '../../widgets/custom_image.dart';
import '../../widgets/custom_text.dart';
import '../profile/profile_screen.dart';

class MBTIPersonalities extends StatefulWidget {
  const MBTIPersonalities({Key? key}) : super(key: key);

  @override
  State<MBTIPersonalities> createState() => _MBTIPersonalitiesState();
}

class _MBTIPersonalitiesState extends State<MBTIPersonalities> {
  late ResultController _resultController;
  @override
  void initState() {
    super.initState();
    try {
      _resultController = Get.find();
    } catch (exception) {
      _resultController = Get.put(ResultController());
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.primaryWhiteColor,
      body: SafeArea(
        child: _resultController.isDataLoading == true
            ? const Center(
                child: CircularProgressIndicator(),
              )
            : Container(
          height: double.infinity,
              width: double.infinity,
              child: SingleChildScrollView(
                physics: AlwaysScrollableScrollPhysics(),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Container(
                        padding: EdgeInsets.only(top: 40),
                        width:Get.width,
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            RawMaterialButton(
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
                            Flexible(
                              child: alignText(
                                  "16 PERSONALITIES",
                                  30.0,
                                  AppColor.textBlackColor,
                                  FontWeight.bold,
                                  TextAlign.center,AppFontFamily.poppinsRegular),
                            ),
                          ],
                        ),
                      ),
                      Container(
                        width:Get.width,
                        margin: EdgeInsets.symmetric(vertical: 20),
                        height: 160,
                        child: Stack(
                          children: [
                            Align(
                              alignment: Alignment.topCenter,
                              child: alignText(
                                    _resultController
                                        .newModel.personalitiesList![0].name,
                                    40.0,
                                    AppColor.analystColor,
                                    FontWeight.bold,
                                    TextAlign.center,AppFontFamily.poppinsRegular),
                            ),
                           Center(
                             child: Container(
                               margin: EdgeInsets.only(top: 35),
                               child: ListView.builder(
                                      scrollDirection: Axis.horizontal,
                                      shrinkWrap: true,
                                      itemCount: _resultController
                                          .newModel
                                          .personalitiesList![0]
                                          .personalityDataList!
                                          .length,
                                      itemBuilder: (bContext, position) {
                                        PersonalityData personalityData =
                                            _resultController
                                                .newModel
                                                .personalitiesList![0]
                                                .personalityDataList![position];
                                        return Row(
                                          children: [
                                            buildItem(
                                                personalityData.character!,
                                                personalityData.type!,
                                                personalityData.personality!,
                                                AppColor.analystColor,
                                                position),
                                            position <
                                                    _resultController
                                                            .newModel
                                                            .personalitiesList![0]
                                                            .personalityDataList!
                                                            .length -
                                                        1
                                                ? const SizedBox(width: 10.0)
                                                : const SizedBox(width: 0.0),
                                          ],
                                        );
                                      },
                                    ),
                             ),
                           ),
                          ],
                        ),
                      ),
                      Container(
                        height: 160,
                        margin: EdgeInsets.symmetric(vertical: 20),
                        child: Stack(
                          children: [
                            Align(
                             alignment: Alignment.topCenter,
                              child: alignText(
                                  _resultController
                                      .newModel.personalitiesList![1].name,
                                  40.0,
                                  AppColor.diplomatsColor,
                                  FontWeight.bold,
                                  TextAlign.center,AppFontFamily.poppinsRegular),
                            ),
                            Center(
                              child: Container(
                                  margin: EdgeInsets.only(top: 35),
                                child:  ListView.builder(
                                    scrollDirection: Axis.horizontal,
                                    shrinkWrap: true,
                                    itemCount: _resultController
                                        .newModel
                                        .personalitiesList![1]
                                        .personalityDataList!
                                        .length,
                                    itemBuilder: (bContext, position) {
                                      PersonalityData personalityData =
                                          _resultController
                                              .newModel
                                              .personalitiesList![1]
                                              .personalityDataList![position];
                                      return Row(
                                        children: [
                                          buildItem(
                                              personalityData.character!,
                                              personalityData.type!,
                                              personalityData.personality!,
                                              AppColor.diplomatsColor,
                                              position + 4),
                                          position <
                                                  _resultController
                                                          .newModel
                                                          .personalitiesList![1]
                                                          .personalityDataList!
                                                          .length -
                                                      1
                                              ? const SizedBox(width: 10.0)
                                              : const SizedBox(width: 0.0),
                                        ],
                                      );
                                    },
                                  )),
                            ),
                          ],
                        ),
                      ),
                      Container(
                        height: 160,
                        margin: EdgeInsets.symmetric(vertical: 20),
                        child: Stack(
                          children: [
                            Align(
                            alignment: Alignment.topCenter,
                              child: alignText(
                                  _resultController
                                      .newModel.personalitiesList![2].name,
                                  40.0,
                                  AppColor.sentinelsColor,
                                  FontWeight.bold,
                                  TextAlign.center,AppFontFamily.poppinsRegular),
                            ),
                            Center(
                              child: Container(
                                margin: EdgeInsets.only(top: 35),
                                child:  ListView.builder(
                                    scrollDirection: Axis.horizontal,
                                    shrinkWrap: true,
                                    itemCount: _resultController
                                        .newModel
                                        .personalitiesList![2]
                                        .personalityDataList!
                                        .length,
                                    itemBuilder: (bContext, position) {
                                      PersonalityData personalityData =
                                          _resultController
                                              .newModel
                                              .personalitiesList![2]
                                              .personalityDataList![position];
                                      return Row(
                                        children: [
                                          buildItem(
                                              personalityData.character!,
                                              personalityData.type!,
                                              personalityData.personality!,
                                              AppColor.sentinelsColor,
                                              position + 8),
                                          position <
                                                  _resultController
                                                          .newModel
                                                          .personalitiesList![2]
                                                          .personalityDataList!
                                                          .length -
                                                      1
                                              ? const SizedBox(width: 10.0)
                                              : const SizedBox(width: 0.0),
                                        ],
                                      );
                                    },
                                  )),
                            ),
                          ],
                        ),
                      ),
                      Container(
                        height: 160,
                        margin: EdgeInsets.symmetric(vertical: 20),
                        child: Stack(
                          children: [
                            Align(
                              alignment: Alignment.topCenter,
                              child: alignText(
                                  _resultController
                                      .newModel.personalitiesList![3].name,
                                  40.0,
                                  AppColor.explorersColor,
                                  FontWeight.bold,
                                  TextAlign.center,AppFontFamily.poppinsRegular),
                            ),
                            Center(
                              child: Container(
                                margin: EdgeInsets.only(top: 35),
                                child:  ListView.builder(
                                        scrollDirection: Axis.horizontal,
                                        shrinkWrap: true,
                                        itemCount: _resultController
                                            .newModel
                                            .personalitiesList![3]
                                            .personalityDataList!
                                            .length,
                                        itemBuilder: (bContext, position) {
                                          PersonalityData personalityData =
                                          _resultController
                                              .newModel
                                              .personalitiesList![3]
                                              .personalityDataList![position];
                                          return Row(
                                            children: [
                                              buildItem(
                                                  personalityData.character!,
                                                  personalityData.type!,
                                                  personalityData.personality!,
                                                  AppColor.explorersColor,
                                                  position + 12),
                                              position <
                                                  _resultController
                                                      .newModel
                                                      .personalitiesList![3]
                                                      .personalityDataList!
                                                      .length -
                                                      1
                                                  ? const SizedBox(width: 10.0)
                                                  : const SizedBox(width: 0.0),
                                            ],
                                          );
                                        },
                                      )),
                            ),

                          ],
                        ),
                      ),
                    ],
                  ),
                ),
            ),
      ),
    );
  }

  buildItem(
      String image, String text, String personality, Color color, int index) {
    return InkWell(
      onTap: () {
        Get.to(() => ProfilePage(index: index));
      },
      child: Column(
        children: [
          customSvgImage(
            image,
            80.0,
            80.0,
          ),
          Column(
            children: [
              alignText(text, 14.0, color, FontWeight.bold, TextAlign.center,AppFontFamily.poppinsRegular),
              alignText(personality, 10.0, AppColor.personalityColor,
                  FontWeight.normal, TextAlign.center,AppFontFamily.poppinsRegular),
            ],
          )
        ],
      ),
    );
  }
}
