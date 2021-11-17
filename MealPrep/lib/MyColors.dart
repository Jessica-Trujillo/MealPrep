import 'package:flutter/material.dart';

class MyColors {
  static const Color accentColor = Color(0xffFF6B6B);
  static const Color green = Colors.green;
  static const Color yellow = Color(0xfff2b100);
  static const Color lightGrey = Color(0xfff3f3f3);
  static const Color grey = Colors.grey;
  static const Color black = Color(0xff333333);
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

  static TextStyle bodyText = TextStyle(color: MyColors.black, fontSize: 16);
  static TextStyle h1Text = TextStyle(
      color: MyColors.black, fontSize: 22, fontWeight: FontWeight.bold);
}

class Common {
  static void showMessage(BuildContext context, String title, String message) {
    showDialog(
        context: context,
        builder: (BuildContext context) => AlertDialog(
              title: Text(title),
              content: new Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(message),
                ],
              ),
              actions: <Widget>[
                new ElevatedButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: const Text('Close'),
                ),
              ],
            ));
  }
}
