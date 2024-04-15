// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class MyInputField extends StatelessWidget {
  TextEditingController controller;
  TextInputAction textInputAction;
  bool autofocus;
  TextInputType keyboardType;
  TextStyle style;
  int maxLength;
  Color cursorColor;
  InputDecoration decoration;
  TextCapitalization textCapitalization;

  MyInputField(
      {Key? key,
      required this.controller,
      required this.textInputAction,
      required this.autofocus,
      required this.keyboardType,
      required this.style,
      required this.maxLength,
      required this.cursorColor,
      required this.decoration,
      required this.textCapitalization})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      inputFormatters: [
        FilteringTextInputFormatter.allow(RegExp(r"[a-zA-Z]+|\s"))
      ],
      controller: controller,
      textInputAction: textInputAction,
      autofocus: autofocus,
      keyboardType: keyboardType,
      textCapitalization: textCapitalization,
      style: style,
      maxLength: maxLength,
      cursorColor: cursorColor,
      decoration: decoration,
      validator: (value) {
        if (value == null) {
          return "Test-Taker Name Required";
        } else if (value.isEmpty) {
          return "Test-Taker Name Required";
        } else if (value.indexOf(' ') == 0) {
          return 'Test-Taker Name Required';
        } else {
          return null;
        }
      },
    );
  }
}
