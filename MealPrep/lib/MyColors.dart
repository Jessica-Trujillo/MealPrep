
import 'package:flutter/material.dart';

class MyColors{
  static Color accentColor = Colors.red[400]!;
}

class MyStyles{
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