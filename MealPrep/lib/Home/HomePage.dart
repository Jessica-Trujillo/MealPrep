import 'package:flutter/material.dart';
import 'package:foodplanapp/MyColors.dart';

class HomePage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _HomePageState();
  }
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: MyColors.accentColor,
        title: const Text('Home'),
      ),
      body: Column(
        children: <Widget>[
          Expanded(
            child: Text('hi'),
          )
        ],
      ),
    );
  }
}
