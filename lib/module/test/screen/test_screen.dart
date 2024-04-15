import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:material_dialogs/widgets/buttons/icon_button.dart';
import 'package:percent_indicator/percent_indicator.dart';
import 'package:personality_test/controller/result_controller.dart';
import 'package:personality_test/shared/app_font_family/font_family.dart';
import 'package:personality_test/widgets/custom_text.dart';
import 'package:scroll_to_index/scroll_to_index.dart';

import '../../../local/my_local_storage.dart';
import '../../../shared/resources/app_color.dart';
import '../../../widgets/button_widgets.dart';
import '../../../widgets/custom_dialog.dart';
import '../../../widgets/stateless_widgets.dart';

class TestScreen extends StatefulWidget {
  const TestScreen({Key? key}) : super(key: key);
  @override
  _TestScreenState createState() => _TestScreenState();
}

class _TestScreenState extends State<TestScreen> {
  late AutoScrollController controller;
  late ResultController _resultController;

  @override
  void initState() {
    try {
      _resultController = Get.find();
    } catch (exception) {
      _resultController = Get.put(ResultController());
    }
    controller = AutoScrollController(
        viewportBoundaryGetter: () =>
            Rect.fromLTRB(0, 0, 0, MediaQuery.of(context).padding.bottom),
        axis: Axis.horizontal);
    _resultController.setHistory();
    super.initState();
  }

  Future<void> scrollToSpecificIndex(int index) async {
    await controller.scrollToIndex(index,
        preferPosition: AutoScrollPosition.middle);
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<ResultController>(
      builder: (_) => WillPopScope(
        onWillPop: () => onWillPopScope(),
        child:Container(
          decoration: const BoxDecoration(
              gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [AppColor.primaryColor,AppColor.testScreenBGColor1,])),
          child: Scaffold(
            appBar: AppBar(
              backgroundColor: AppColor.transparent,
              elevation: 0,
              leading: IconButton(
                  onPressed: () {
                    _resultController.isTestStarted
                        ? customMaterialDialog(context, _resultController)
                        : Get.back();
                  },
                  icon: const Icon(Icons.arrow_back)),
              actions: [
                _resultController.isTestStarted
                    ? Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 8.0),
                        child: IconsButton(
                          onPressed: () {
                            restartTest();
                          },
                          text: 'Restart Test',
                          iconData: CupertinoIcons.restart,
                          textStyle:
                              const TextStyle(color: AppColor.primaryWhiteColor),
                          iconColor: Colors.white,
                        ),
                      )
                    : Container()
              ],
            ),
            backgroundColor: AppColor.transparent,
            body: SafeArea(
              child: SingleChildScrollView(
                child: Container(
                  margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 10.0),
                  padding: const EdgeInsets.symmetric(vertical: 10),
                  decoration: BoxDecoration(
                    color: AppColor.primaryWhiteColor,
                    borderRadius: BorderRadius.circular(20.0),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      SizedBox(height: 40,),
                      Center(
                        child: Container(
                          height: 3,
                          width: 60,
                          decoration: BoxDecoration(
                            gradient:
                             const LinearGradient(
                                colors: [
                                  AppColor.navyBlueColor,
                                  AppColor.secondaryBlueColor,
                                ],
                                begin: Alignment.topRight,
                                end: Alignment.bottomLeft)
                          ),
                        ),
                      ),
                      Container(
                        height: 80.0,
                        padding: EdgeInsets.only(top: 10,left: 20,right: 20),
                        child: ListView.builder(
                          controller: controller,
                          shrinkWrap: true,
                          addAutomaticKeepAlives: false,
                          addRepaintBoundaries: false,
                          itemCount: _resultController.newModel.test!.length,
                          scrollDirection: Axis.horizontal,
                          itemBuilder: (bContext, index) {
                            return AutoScrollTag(
                              key: ValueKey(index),
                              controller: controller,
                              index: index,
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Container(
                                    width: 40,
                                    margin: const EdgeInsets.all(5.0),
                                    decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      gradient:
                                          _resultController.questionTemp == index
                                              ? const LinearGradient(
                                                  colors: [
                                                      AppColor.navyBlueColor,
                                                      AppColor.secondaryBlueColor,
                                                    ],
                                                  begin: Alignment.topRight,
                                                  end: Alignment.bottomLeft)
                                              : const LinearGradient(
                                                  colors: [
                                                      AppColor.kGrayColor,
                                                      AppColor.kGrayColor,
                                                    ],
                                                  begin: Alignment.topRight,
                                                  end: Alignment.bottomLeft),
                                    ),
                                    child: CircleAvatar(
                                      backgroundColor: Colors.transparent,
                                      child: customTextCapitalizeFirst(
                                          index + 1,
                                          16,
                                          AppColor.primaryWhiteColor,
                                          FontWeight.bold,AppFontFamily.poppinsRegular),
                                    ),
                                  ),
                                  SizedBox(height: 10,),
                                  Container(
                                    height: 3,
                                    width: 50,
                                  decoration: BoxDecoration(
                                 gradient:
                                  _resultController.questionTemp == index
                            ? const LinearGradient(
                            colors: [
                            AppColor.navyBlueColor,
                            AppColor.secondaryBlueColor,
                            ],
                            begin: Alignment.topRight,
                            end: Alignment.bottomLeft)
                                : const LinearGradient(
                            colors: [
                            AppColor.kGrayColor,
                            AppColor.kGrayColor,
                            ],
                            begin: Alignment.topRight,
                            end: Alignment.bottomLeft),
                                  ),
                                  )
                                ],
                              ),
                            );
                          },
                        ),
                      ),
                      Container(
                        decoration: const BoxDecoration(
                            color: AppColor.primaryWhiteColor),
                        margin: EdgeInsets.symmetric(vertical: 15),
                        child: CircularPercentIndicator(
                          radius: 115,
                          lineWidth: 10,
                          animation: true,
                          animateFromLastPercent: true,
                          backgroundWidth: 5,
                          arcBackgroundColor:
                              AppColor.textBlackColor.withOpacity(0.1),
                          arcType: ArcType.FULL,
                          addAutomaticKeepAlive: true,
                          linearGradient: const LinearGradient(colors: [
                            AppColor.redColor,
                            AppColor.navyBlueColor,
                            AppColor.lightGreenColor
                          ]),
                          percent: (_resultController.percentage).toDouble() / 20,
                          center: SizedBox(
                            height: 200,
                            width: 200,
                            child: Card(
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(100)),
                              elevation: 5,
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  customText(
                                      (((_resultController.percentage)
                                                      .toDouble() /
                                                  20) *
                                              100)
                                          .toStringAsFixed(1),
                                      50,
                                      AppColor.navyBlueColor,
                                      FontWeight.bold,AppFontFamily.poppinsRegular),
                                  customTextAllInCaps(
                                      "%",
                                      20,
                                      AppColor.secondaryBlueColor,
                                      FontWeight.bold,AppFontFamily.poppinsRegular)
                                ],
                              ),
                            ),
                          ),
                          backgroundColor: AppColor.primaryWhiteColor,
                          circularStrokeCap: CircularStrokeCap.round,
                        ),
                      ),
                      Container(
                        width: Get.size.width,
                        padding: EdgeInsets.symmetric(horizontal: 10),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 5),
                              child: summaryText(
                                  _resultController
                                      .newModel
                                      .test![_resultController.questionTemp]
                                      .question,
                                  16,
                                  AppColor.headingSpaceCadetColor,
                                  FontWeight.bold,AppFontFamily.ubuntuMedium),
                            ),
                            const SizedBox(height: 20),
                            InkWell(
                              onTap: () {
                                _resultController.updateOptionSelected("A");
                                _resultController.changeClick(true, 1);
                              },
                              child: Container(
                                padding: const EdgeInsets.all(10.0),
                                width: Get.size.width,
                                decoration: BoxDecoration(
                                  border: Border.all(
                                      color: _resultController.isClick &&
                                              _resultController.clicked == 1
                                          ? AppColor.secondaryBlueColor
                                          : AppColor.kGrayColor,
                                      width: _resultController.isClick &&
                                              _resultController.clicked == 1
                                          ? 2
                                          : 1),
                                  borderRadius: BorderRadius.circular(10.0),
                                ),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Expanded(
                                      flex: 1,
                                      child: Container(
                                        decoration: BoxDecoration(
                                          shape: BoxShape.circle,
                                          gradient: _resultController.isClick &&
                                                  _resultController.clicked == 1
                                              ? const LinearGradient(
                                                  colors: [
                                                      AppColor.navyBlueColor,
                                                      AppColor.secondaryBlueColor,
                                                    ],
                                                  begin: Alignment.topLeft,
                                                  end: Alignment.bottomRight)
                                              : const LinearGradient(
                                                  colors: [
                                                      AppColor.kGrayColor,
                                                      AppColor.kGrayColor,
                                                    ],
                                                  begin: Alignment.topLeft,
                                                  end: Alignment.bottomRight),
                                        ),
                                        child: CircleAvatar(
                                          backgroundColor: Colors.transparent,
                                          child: customTextCapitalizeFirst(
                                              'A',
                                              25,
                                              AppColor.primaryWhiteColor,
                                              FontWeight.bold,
                                             AppFontFamily.poppinsRegular),
                                        ),
                                      ),
                                    ),
                                    const SizedBox(
                                      width: 5.0,
                                    ),
                                    Expanded(
                                        flex: 6,
                                        child: customTextCapitalizeFirst(
                                            '${_resultController.newModel.test![_resultController.questionTemp].alpha}',
                                            14,
                                            AppColor.textBlackColor,
                                            FontWeight.normal , AppFontFamily.poppinsRegular),
                                    )
                                  ],
                                ),
                              ),
                            ),
                            const SizedBox(height: 20),
                            InkWell(
                              onTap: () {
                                _resultController.updateOptionSelected("B");
                                _resultController.changeClick(true, 2);
                              },
                              child: Container(
                                padding: const EdgeInsets.all(10.0),
                                width: Get.size.width,
                                decoration: BoxDecoration(
                                  border: Border.all(
                                      color: _resultController.isClick &&
                                              _resultController.clicked == 2
                                          ? AppColor.secondaryBlueColor
                                          : AppColor.kGrayColor,
                                      width: _resultController.isClick &&
                                              _resultController.clicked == 2
                                          ? 2
                                          : 1),
                                  borderRadius: BorderRadius.circular(10.0),
                                ),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Expanded(
                                      flex: 1,
                                      child: Container(
                                        decoration: BoxDecoration(
                                          shape: BoxShape.circle,
                                          gradient: _resultController.isClick &&
                                                  _resultController.clicked == 2
                                              ? const LinearGradient(
                                                  colors: [
                                                      AppColor.navyBlueColor,
                                                      AppColor.secondaryBlueColor,
                                                    ],
                                                  begin: Alignment.topLeft,
                                                  end: Alignment.bottomRight)
                                              : const LinearGradient(
                                                  colors: [
                                                      AppColor.kGrayColor,
                                                      AppColor.kGrayColor,
                                                    ],
                                                  begin: Alignment.topLeft,
                                                  end: Alignment.bottomRight),
                                        ),
                                        child: CircleAvatar(
                                          backgroundColor: Colors.transparent,
                                          child: customTextCapitalizeFirst(
                                              'B',
                                              25,
                                              AppColor.primaryWhiteColor,
                                              FontWeight.bold , AppFontFamily.poppinsRegular),
                                        ),
                                      ),
                                    ),
                                    const SizedBox(
                                      width: 5.0,
                                    ),
                                    Expanded(
                                        flex: 6,
                                        child: customTextCapitalizeFirst(
                                            '${_resultController.newModel.test![_resultController.questionTemp].beta}',
                                            14,
                                            AppColor.textBlackColor,
                                            FontWeight.normal,AppFontFamily.poppinsRegular))
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(
                        height: 30,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          SizedBox(width: 15,),
                          InkWell(
                            overlayColor:MaterialStateProperty.all( AppColor.transparent),
                            onTap: (){
                              showPreviousQuestion();
                            },
                            child: Container(
                              height:40 ,
                              width:120 ,
                              decoration: BoxDecoration(
                                color:  AppColor.kGrayColor,
                                borderRadius: BorderRadius.circular(20)
                              ),
                              child: defIconButton(
                                "Previous",
                                Icons.arrow_back_sharp,
                                true,
                              ),
                            ),
                          ),
                          Expanded(child: Container()),
                          _resultController.questionTemp < 19
                              ? InkWell(
                               overlayColor:MaterialStateProperty.all( AppColor.transparent),
                                onTap: () {
                                  showNextQuestion();
                                },
                                child: Container(
                               height:40 ,
                                width:120 ,
                                  decoration: BoxDecoration(
                                    color:     AppColor.resultCodeColor,
                                    borderRadius: BorderRadius.circular(20)
                                  ),
                                  child: defIconButton(
                            "Next",
                            Icons.arrow_forward_sharp,
                            false,
                          ),
                                ),
                              )
                              :  InkWell(
                               overlayColor:MaterialStateProperty.all( AppColor.transparent),
                                onTap: () {
                                  submitTest();
                                },
                                child: Container(
                            height:40 ,
                            width:120 ,
                                  decoration: BoxDecoration(
                                    color: _resultController.isPreviousVisible
                                        ? AppColor.resultCodeColor
                                        : AppColor.grayColor,
                                    borderRadius: BorderRadius.circular(20)
                                  ),
                                  child: defIconButton(
                            "Submit",
                            const IconData(0xe571,
                                    fontFamily: 'MaterialIcons',
                                    matchTextDirection: true),
                            false,
                          ),
                                ),
                              ),
                          SizedBox(width: 15,),
                        ],
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
        ),
      ),
    );
  }

  void restartTest() {
    _resultController.clearResultMap();
    _resultController.clearTestHistory();
    MyLocalStorage.setTestHistory([]);
  }

  void showPreviousQuestion() {
    _resultController.updateQuestion(0);
    _resultController.updatePercentage(0);

    _resultController.updateOptionSelected(_resultController
        .testHistoryList[_resultController.questionTemp].selectedOption);
    _resultController.changeClick(
        true,
        _resultController.testHistoryList[_resultController.questionTemp]
                    .selectedOption ==
                "A"
            ? 1
            : _resultController.testHistoryList[_resultController.questionTemp]
                        .selectedOption ==
                    "B"
                ? 2
                : 0);

    if (_resultController.questionTemp >= 0) {
      _resultController.updateHistory(
          _resultController.questionTemp, "", false);
    }
  }

  void showNextQuestion() {
    if (_resultController.optionSelected != "") {
      _resultController.updatePercentage(1);
      if (_resultController.percentage > 0) {
        _resultController.setValues(true, true);
      }

      scrollToSpecificIndex(_resultController.questionTemp);

      if (_resultController.optionSelected == "A") {
        _resultController.updateQuesResultForA();
      } else if (_resultController.optionSelected == "B") {
        _resultController.updateQuesResultForB();
      }
      _resultController.updateHistory(_resultController.questionTemp,
          _resultController.optionSelected, true);
      _resultController.updateQuestionNumber();
      if (_resultController.testHistoryList.length >
          _resultController.questionTemp) {
        _resultController.changeClick(
            _resultController.testHistoryList[_resultController.questionTemp]
                    .selectedOption !=
                "",
            _resultController.testHistoryList[_resultController.questionTemp]
                        .selectedOption ==
                    "A"
                ? 1
                : _resultController
                            .testHistoryList[_resultController.questionTemp]
                            .selectedOption ==
                        "B"
                    ? 2
                    : 0);
        _resultController.updateOptionSelected(_resultController
            .testHistoryList[_resultController.questionTemp].selectedOption);
      } else {
        _resultController.changeClick(false, 0);
        _resultController.updateOptionSelected("");
      }
    } else {
      mySnackBar('Please select an option!');
    }
  }

  void submitTest() {
    if (_resultController.optionSelected != "") {
      _resultController.updateHistory(_resultController.questionTemp,
          _resultController.optionSelected, true);
      _resultController.resultCalculation(context);
    } else {
      mySnackBar('Please select an option!');
    }
  }

  Future<bool> onWillPopScope() async {
    if (_resultController.isTestStarted) {
      customMaterialDialog(context, _resultController);
    }

    return true;
  }
}
