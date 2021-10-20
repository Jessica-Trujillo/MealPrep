import 'package:flutter/material.dart';

class MyColors {
  static Color accentColor = Color(0xffe46060);
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
}
