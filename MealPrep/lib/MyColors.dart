import 'package:flutter/material.dart';

class MyColors {
  static Color accentColor = Color(0xffe46060);
  static Color cardColor = Colors.grey[350]!;
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


class Common{

  

  static void showMessage(BuildContext context, String title, String message){
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
      )
    );
  }

}