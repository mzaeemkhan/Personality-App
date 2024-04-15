// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:personality_test/shared/resources/images_assets.dart';

import '../shared/app_font_family/font_family.dart';
import '../shared/resources/app_color.dart';
import 'custom_icon.dart';
import 'custom_image.dart';
import 'custom_text.dart';

Widget defaultButton(String text, double horPadding, VoidCallback onPress) {
  return Padding(
    padding: EdgeInsets.symmetric(horizontal: horPadding),
    child: Row(
      children: [
        Expanded(
          child: ElevatedButton(
            onPressed: onPress,
            style: ElevatedButton.styleFrom(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(25.0),
              ),
              primary: AppColor.primaryDarkColor,
            ),
            child: Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 10.0, vertical: 10.0),
              child: Text(text),
            ),
          ),
        ),
      ],
    ),
  );
}

Widget defaultColoredButton(
    String text, double horPadding, VoidCallback onPress) {
  return
    InkWell(
      onTap: onPress,
      child: Container(
        height: 40,
        width: 185,
        decoration: BoxDecoration(
          color: AppColor.primaryColor,
          borderRadius: BorderRadius.circular(25)
        ),
        child:Center(
          child: alignText(text, 16,
              AppColor.primaryWhiteColor,
              FontWeight.normal,
              TextAlign.justify,AppFontFamily.poppinsMedium),
        ),
      ),
    );
}

Widget defaultIconButton(String text, IconData iconData, VoidCallback onPress) {
  return
    InkWell(
      onTap: onPress,
      child: Container(
        height: 40,
        width: 185,
        decoration: BoxDecoration(
            color: AppColor.primaryColor,
            borderRadius: BorderRadius.circular(25)
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            customIcon(iconData,25,AppColor.primaryWhiteColor),
            SizedBox(width: 10,),
            alignText(text, 16,
                AppColor.primaryWhiteColor,
                FontWeight.normal,
                TextAlign.justify,AppFontFamily.poppinsMedium),
          ],
        ),
      ),
    );
}

Widget svgIconButton(String text, VoidCallback onPress) {
  return
    InkWell(
      onTap: onPress,
      child: Container(
        height: 40,
        width: 185,
        decoration: BoxDecoration(
            color: AppColor.pieChartNewColors[0],
            borderRadius: BorderRadius.circular(25)
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
            children: [
              assetImage(ImageAssets.iconMBTI),
              SizedBox(width: 10,),
              alignText(text, 16,
                  AppColor.primaryWhiteColor,
                  FontWeight.normal,
                  TextAlign.justify,AppFontFamily.poppinsMedium),
            ],
        ),
      ),
    );
}

Widget gradientButton(String text, VoidCallback onPress) {
  return RaisedButton(
    onPressed: onPress,
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(80.0)),
    padding: const EdgeInsets.all(0.0),
    child: Ink(
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            AppColor.navyBlueColor,
            AppColor.secondaryBlueColor,
          ],
        ),
        borderRadius: BorderRadius.all(Radius.circular(50.0)),
      ),
      child: Container(
        constraints: const BoxConstraints(
            minWidth: 88.0, minHeight: 36.0), // min sizes for Material buttons
        alignment: Alignment.center,
        padding: const EdgeInsets.all(10.0),
        child: Text(
          text,
          textAlign: TextAlign.center,
          style: const TextStyle(
              color: AppColor.primaryWhiteColor, fontSize: 16.0),
        ),
      ),
    ),
  );
}

Widget defIconButton(String text, IconData iconData,  bool isLeft,) {
  return isLeft
      ?
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(iconData,color: AppColor.textBlackColor ,),
            SizedBox(width: 5,),
            Flexible(
              child: alignText(text, 16,
                  AppColor.textBlackColor ,
                  FontWeight.normal,
                  TextAlign.center,AppFontFamily.poppinsMedium),
            ),
          ],
        ) : Row(
    mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Flexible(
          child: alignText(text, 16,
              AppColor.textBlackColor ,
              FontWeight.normal,
              TextAlign.center,AppFontFamily.poppinsMedium),
        ),
      SizedBox(width: 5,),
        Icon(iconData,color: AppColor.textBlackColor ,),
      ],
        );
}

Widget defButton(
    String text, Color color, double horPadding, VoidCallback onPress) {
  return Padding(
    padding: EdgeInsets.symmetric(horizontal: horPadding),
    child: Row(
      children: [
        Expanded(
          child: ElevatedButton(
            onPressed: onPress,
            style: ElevatedButton.styleFrom(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(25.0),
              ),
              primary: color,
            ),
            child: Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 10.0, vertical: 10.0),
              child: Text(text),
            ),
          ),
        ),
      ],
    ),
  );
}
