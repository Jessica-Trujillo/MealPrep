import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:foodplanapp/MyColors.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:foodplanapp/LoginRegistration/RegistrationPage.dart';
import 'package:foodplanapp/LoginRegistration/LoginPage.dart';

class WelcomePage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _WelcomePageState();
  }
}

class _WelcomePageState extends State<WelcomePage> {
  void onLoginClicked() {
    Navigator.of(context).push(MaterialPageRoute(builder: (context) {
      return LoginPage();
    }));
  }

  void onSignUpClicked() {
    Navigator.of(context).push(MaterialPageRoute(builder: (context) {
      return RegistrationPage();
    }));
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Scaffold(
      body: Container(
        height: size.height,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(height: size.height * 0.1),
            Container(
              child: Text("Meal Prep'd",
                  style: TextStyle(
                    color: MyColors.accentColor,
                    fontSize: 26,
                    fontWeight: FontWeight.bold,
                  )),
            ),
            SvgPicture.asset("images/ManCooking.svg",
                height: size.height * 0.4),
            Container(
              margin: EdgeInsets.symmetric(horizontal: 25),
              child: Text(
                "With Meal Prep'd with you can find recipes based on your dietary goals, plan out the week's meals, and more!",
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
            SizedBox(height: size.height * 0.15),
            Container(
              margin: EdgeInsets.symmetric(horizontal: 40),
              child: Row(
                children: [
                  Expanded(
                    child: Container(
                      margin: EdgeInsets.only(right: 10),
                      child: OutlinedButton(
                        onPressed: onLoginClicked,
                        style: OutlinedButton.styleFrom(
                            padding: EdgeInsets.symmetric(vertical: 15),
                            primary: MyColors.accentColor,
                            side: BorderSide(
                                width: 1.0, color: MyColors.accentColor)),
                        child: Text("Log in"),
                      ),
                    ),
                  ),
                  Expanded(
                    child: Container(
                      margin: EdgeInsets.only(left: 10),
                      child: ElevatedButton(
                        onPressed: onSignUpClicked,
                        style: ElevatedButton.styleFrom(
                            elevation: 0,
                            padding: EdgeInsets.symmetric(vertical: 15),
                            primary: MyColors.accentColor),
                        child: Text("Sign up"),
                      ),
                    ),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
