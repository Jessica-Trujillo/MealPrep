import 'package:flutter/material.dart';
import 'package:foodplanapp/MyColors.dart';

class AddRecipe extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _AddRecipeState();
  }
}

class _AddRecipeState extends State<AddRecipe> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          backgroundColor: MyColors.accentColor, title: Text("Add Recipe")),
      body: Container(
        margin: EdgeInsets.all(25),
        child: Text(""),
      ),
    );
  }
}
