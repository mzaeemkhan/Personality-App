import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

Widget defaultTextField(TextEditingController callback, String title) {
  return TextFormField(
    inputFormatters: [
      FilteringTextInputFormatter.allow(RegExp(r"[a-zA-Z]+|\s"))
    ],
    controller: callback,
    decoration: InputDecoration(
      border: OutlineInputBorder(borderRadius: BorderRadius.circular(50.0)),
      filled: true,
      labelText: title,
      hintText: "Enter Your Name",
      fillColor: Colors.transparent,
    ),
    maxLength: 10,
    keyboardType: TextInputType.name,
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
