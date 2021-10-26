import 'package:flutter/material.dart';
import 'package:foodplanapp/MyColors.dart';

class PasswordChangePage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _PasswordChangePageState();
  }
}

class _PasswordChangePageState extends State<PasswordChangePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(backgroundColor: MyColors.accentColor,
        title: const Text("Change Password"),
      ),
      body: Container(
        child: Text("Current Password")
      )
    );
  }
}