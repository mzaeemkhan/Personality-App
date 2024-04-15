import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:material_dialogs/material_dialogs.dart';
import 'package:material_dialogs/widgets/buttons/icon_button.dart';
import 'package:material_dialogs/widgets/buttons/icon_outline_button.dart';
import 'package:personality_test/controller/result_controller.dart';
import 'package:personality_test/shared/app_font_family/font_family.dart';

import '../local/my_local_storage.dart';
import '../shared/resources/app_color.dart';
import '../utils/my_utils.dart';
import 'custom_icon.dart';
import 'custom_text.dart';
import 'my_input_field.dart';

Future customNameDialog(
    BuildContext context,
    TextEditingController textEditingController,
    GlobalKey<FormState> formKey,
    VoidCallback onContinuePress) {
  return showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext ctx) {
        return WillPopScope(
          onWillPop: () async => showExitPopup(context),
          child: AlertDialog(
            insetPadding: const EdgeInsets.symmetric(horizontal: 30),
            scrollable: true,
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(20.0))),
            title: Padding(
              padding: EdgeInsets.only(top: 40),
                child: alignText("Continue to Discover Your Personality Test", 20, AppColor.textBlackColor, FontWeight.bold, TextAlign.center,AppFontFamily.poppinsSemiBold)),
            content: SizedBox(
              width: MediaQuery.of(context).size.width - 150,
              child: Padding(
                padding: EdgeInsets.only(top: 50,left: 10,right: 10,bottom: 35),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(
                      width: MediaQuery.of(context).size.width,
                      child: customText("Take Short Test", 15,
                          AppColor.textBlackColor, FontWeight.bold,AppFontFamily.poppinsSemiBold),
                    ),
                    const SizedBox(height: 5.0),
                    Form(
                      key: formKey,
                      child: Container(
                        padding: const EdgeInsets.only(top: 0, bottom: 8),
                        child: MyInputField(
                          controller: textEditingController,
                          textInputAction: TextInputAction.done,
                          textCapitalization: TextCapitalization.words,
                          autofocus: false,
                          keyboardType: TextInputType.name,
                          maxLength: 10,
                          cursorColor: AppColor.primaryColor,
                          style: const TextStyle(),
                          decoration: mInputDecoration(
                              "Your Name",
                              "Enter Your name",
                              false,
                              const EdgeInsets.symmetric(
                                  vertical: 10, horizontal: 10)),
                        ),
                      ),
                    ),
                    SizedBox(height: 10,),
                    InkWell(
                        onTap: onContinuePress,
                        child: Container(
                          height: 40,
                          decoration: BoxDecoration(
                            color: AppColor.primaryDarkColor,
                            borderRadius: BorderRadius.circular(20)
                          ),
                          child: Center(
                            child: alignText("Continue", 20, AppColor.primaryWhiteColor, FontWeight.normal, TextAlign.center,AppFontFamily.poppinsSemiBold),
                          ),
                        )),
                  ],
                ),
              ),
            ),
          ),
        );
      });
}

Future<bool> showExitPopup(context) async {
  return exit(0);
}

Future updateNameDialog(
    BuildContext context,
    String title,
    String text,
    TextEditingController textEditingController,
    GlobalKey<FormState> formKey,
    VoidCallback onContinuePress) {
  textEditingController.text = text;
  textEditingController.selection = TextSelection(
    baseOffset: 0,
    extentOffset: textEditingController.text.length,
  );

  return showDialog(
      context: context,
      builder: (BuildContext ctx) {
        return AlertDialog(
          insetPadding: const EdgeInsets.all(10.0),
          scrollable: true,
          title: alignText(title, 18, AppColor.textBlackColor, FontWeight.bold,
              TextAlign.center,AppFontFamily.poppinsRegular),
          content: SizedBox(
            width: MediaQuery.of(context).size.width - 100,
            child: Column(
              children: [
                Form(
                  key: formKey,
                  child: Container(
                    padding: const EdgeInsets.only(top: 0, bottom: 8),
                    child: MyInputField(
                      controller: textEditingController,
                      textInputAction: TextInputAction.done,
                      textCapitalization: TextCapitalization.words,
                      autofocus: true,
                      keyboardType: TextInputType.name,
                      maxLength: 10,
                      cursorColor: AppColor.primaryColor,
                      style: const TextStyle(),
                      decoration: mInputDecoration(
                          "Your Name",
                          "Enter Your Name",
                          false,
                          const EdgeInsets.symmetric(
                              vertical: 20, horizontal: 10)),
                    ),
                  ),
                ),
                Row(
                  children: [
                    Expanded(
                      child: IconsOutlineButton(
                        onPressed: () {
                          textEditingController.clear();
                          Navigator.pop(context, true);
                        },
                        text: 'Cancel',
                        color: AppColor.primaryWhiteColor,
                        textStyle:
                            const TextStyle(color: AppColor.primaryColor),
                        iconColor: Colors.white,
                      ),
                    ),
                    const SizedBox(width: 10.0),
                    Expanded(
                      child: IconsButton(
                        onPressed: onContinuePress,
                        text: 'Continue',
                        color: AppColor.primaryColor,
                        textStyle:
                            const TextStyle(color: AppColor.primaryWhiteColor),
                        iconColor: Colors.white,
                      ),
                    )
                  ],
                )
              ],
            ),
          ),
        );
      });
}

customMaterialDialog(BuildContext context, ResultController resultController) {
  return Dialogs.bottomMaterialDialog(
    msg: 'Are you sure you want to quit the test?',
    title: 'QUIT TEST',
    titleStyle: TextStyle(fontSize: 17,fontWeight: FontWeight.bold,fontFamily: AppFontFamily.poppinsBold,color: AppColor.textBlackColor),
    context: context,
    actions: [
      Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [   InkWell(
            onTap: () async {
              await MyLocalStorage.setTestHistory(resultController.testHistoryList);
              resultController.clearResultMap();
              Get.back();
              Get.back();
            },
            child: Container(
              height: 30,
              width: 120,
              decoration: BoxDecoration(
                  color: AppColor.primaryWhiteColor,
                  border: Border.all(color: AppColor.darkGrayColor),
                  borderRadius: BorderRadius.circular(15)
              ),
              child: Center(
                child: alignText(
                    "Quit & Save",
                    11,
                    AppColor.darkGrayColor,
                    FontWeight.normal,
                    TextAlign.center,AppFontFamily.poppinsRegular),
              ),
            )),
          InkWell(
              onTap: ()  {
                MyLocalStorage.setTestHistory([]);
                resultController.clearTestHistory();
                resultController.clearResultMap();
                Get.back();
                Get.back();
              },
              child: Container(
                height: 30,
                width: 120,
                decoration: BoxDecoration(
                    color: AppColor.redColor,
                    borderRadius: BorderRadius.circular(15)
                ),
                child:  Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    customIcon(Icons.delete,15,AppColor.primaryWhiteColor),
                    SizedBox(width: 5,),
                    alignText(
                        "Quit Test",
                        11,
                        AppColor.primaryWhiteColor,
                        FontWeight.normal,
                        TextAlign.center,AppFontFamily.poppinsRegular),
                  ],
                ),
              )),],
      ),
    ],
  );
}
