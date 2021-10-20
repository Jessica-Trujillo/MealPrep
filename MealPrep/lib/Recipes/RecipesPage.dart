import 'package:flutter/material.dart';
import 'package:foodplanapp/MyColors.dart';

class RecipesPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _RecipesPageState();
  }
}

class _RecipesPageState extends State<RecipesPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: MyColors.accentColor,
          title: const Text('Recipes'),
        ),
        body: Text('Hi'));
  }
}
