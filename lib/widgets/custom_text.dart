import 'package:flutter/cupertino.dart';
import 'package:personality_test/shared/methods/string_extensions.dart';

Widget logoTextWidget(String text, TextStyle textStyle) {
  return Text(
    text,
    style: textStyle,
  );
}

Widget customTextCapitalizeFirst(text, double size, Color color, FontWeight weight ,String fontFamily) {
  return Text(
    text.toString().allInLower.inCaps,
    style: TextStyle(
        fontSize: size, color: color, fontWeight: weight, fontFamily: fontFamily),
  );
}

Widget customTextAllInCaps(text, double size, Color color, FontWeight weight,String fontFamily) {
  return Text(
    text.toString().allInCaps,
    style: TextStyle(
        fontSize: size, color: color, fontWeight: weight, fontFamily: fontFamily),
  );
}

Widget customTextAllInCapsWithUnderline(text, double size, Color color, FontWeight weight,String fontFamily) {
  return Text(
    text.toString().allInCaps,
    style: TextStyle(
        decoration: TextDecoration.underline,
        fontSize: size, color: color, fontWeight: weight, fontFamily: fontFamily),
  );
}

Widget customAlignTextAllInCaps(
    text, double size, Color color, FontWeight weight,String fontFamily) {
  return Text(
    text.toString().allInCaps,
    textAlign: TextAlign.center,
    style: TextStyle(
        fontSize: size, color: color, fontWeight: weight, fontFamily: fontFamily),
  );
}

Widget customTextCapitalizeFirstOfEach(
    text, double size, Color color, FontWeight weight,String fontFamily) {
  return Text(
    text.toString().capitalizeFirstOfEach,
    style: TextStyle(
        fontSize: size, color: color, fontWeight: weight, fontFamily: fontFamily),
  );
}

Widget customText(text, double size, Color color, FontWeight weight,String fontFamily) {
  return Text(
    text ?? "",
    style: TextStyle(
        fontSize: size, color: color, fontWeight: weight, fontFamily: fontFamily),
  );
}

Widget alignText(
    text, double size, Color color, FontWeight weight, TextAlign _textAlign,String fontFamily) {
  return Text(
    text ?? "",
    textAlign: _textAlign,
    style: TextStyle(
        fontSize: size, color: color, fontWeight: weight, fontFamily: fontFamily),
  );
}

Widget customItalicText(text, double size, Color color, FontWeight weight,String fontFamily) {
  return Text(
    text ?? "",
    style: TextStyle(
        fontSize: size,
        color: color,
        fontWeight: weight,
        fontStyle: FontStyle.italic,
        fontFamily: fontFamily),
  );
}

Widget customContinueText(text, double size, Color color, FontWeight weight,String fontFamily) {
  return Text(
    text ?? "",
    style: TextStyle(
        fontSize: size, color: color, fontWeight: weight, fontFamily: fontFamily),
    textAlign: TextAlign.center,
    maxLines: 2,
    overflow: TextOverflow.ellipsis,
  );
}

Widget summaryText(text, double size, Color color, FontWeight weight,String fontFamily) {
  return Text(
    text.toString().allInLower.inCaps,
    style: TextStyle(
        fontSize: size, color: color, fontWeight: weight, fontFamily: fontFamily),
    textAlign: TextAlign.start,
  );
}
