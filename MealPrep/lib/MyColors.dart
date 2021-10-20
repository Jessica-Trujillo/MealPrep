import 'package:flutter/material.dart';

class MyColors {
  static Color accentColor = Color(0xffe46060);
  static Color cardColor = Color(0xfff5f5f5);
}

class MyStyles {
  static InputDecoration defaultInputDecoration = InputDecoration(
    enabledBorder: OutlineInputBorder(
      borderSide: BorderSide(width: 2, color: Colors.black),
      borderRadius: BorderRadius.circular(8),
    ),
    focusedBorder: OutlineInputBorder(
      borderSide: BorderSide(width: 2, color: MyColors.accentColor),
      borderRadius: BorderRadius.circular(8),
    ),
  );

  static TextStyle bodyText = TextStyle(color: Color(0xff333333), fontSize: 16);
  static TextStyle h1Text = TextStyle(
      color: Color(0xff333333), fontSize: 20, fontWeight: FontWeight.bold);
}
