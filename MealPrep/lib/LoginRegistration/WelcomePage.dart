import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:foodplanapp/MyColors.dart';
// import 'package:flutter_svg/flutter_svg.dart';

class WelcomePage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _WelcomePageState();
  }
}

class _WelcomePageState extends State<WelcomePage> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Scaffold(
      body: Container(
          height: size.height,
          width: double.infinity,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text("dfdfdsf aidfd "),
              // SvgPicture.asset("images/ManCooking.svg"),
            ],
          )),
    );
  }
}
