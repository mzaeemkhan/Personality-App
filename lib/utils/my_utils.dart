//region common input decoration
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:personality_test/shared/app_font_family/font_family.dart';
import 'package:personality_test/shared/resources/app_color.dart';
import 'package:shared_preferences/shared_preferences.dart';

//region show and hide functions for progress dialog
Future showLoading() async {
  await EasyLoading.show(status: 'Please wait...!', dismissOnTap: false);
}

Future hideLoading() async {
  await EasyLoading.dismiss();
}
//endregion

InputDecoration myInputDecoration(String label, String hint, bool isIcon,
    Widget icon, bool dense, EdgeInsetsGeometry contentPadding) {
  return InputDecoration(
      border: OutlineInputBorder(borderRadius: BorderRadius.circular(10.0)),
      isDense: dense,
      contentPadding: contentPadding,
      labelText: label,
      alignLabelWithHint: true,
      hintText: hint,
      counter: const Offstage(),
      floatingLabelBehavior: FloatingLabelBehavior.always,
      prefixIcon: isIcon ? icon : null);
}

InputDecoration mInputDecoration(
    String label, String hint, bool dense, EdgeInsetsGeometry contentPadding) {
  return InputDecoration(
      border: const UnderlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(0))),
      filled: true,
      fillColor: Colors.grey[200],
      isDense: dense,
      contentPadding: contentPadding,
      // labelText: label,
      alignLabelWithHint: true,
      hintText: hint,
      hintStyle: TextStyle(
        color: AppColor.textBlackColor,
        fontFamily: AppFontFamily.poppinsRegular,
        fontSize: 20,
        fontWeight: FontWeight.normal
      ),
      counter: const Offstage(),
      floatingLabelBehavior: FloatingLabelBehavior.always);
}
//endregion

void setName(name) async {
  SharedPreferences preferences = await SharedPreferences.getInstance();
  preferences.setString("name", name);
}
