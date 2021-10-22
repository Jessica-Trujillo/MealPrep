import 'package:flutter/material.dart';
import 'package:foodplanapp/LoginRegistration/UserStats.dart';
import 'package:foodplanapp/MyColors.dart';

class RegistrationWelcomePage extends StatelessWidget{

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: MyColors.accentColor,
        title: const Text('Welcome to Meal Prep''d'),
      ),
      body: SingleChildScrollView(
        child: Column (
          children: <Widget>[
            Container(height: 20),
            Text("Your account has been created!", style: TextStyle(fontSize: 26, color: Colors.black)),
            Container(height: 20),
            
            Container(margin: EdgeInsets.all(10),
            child: Text("To start generating meal plans, we need to know a little about you",              
                  style: TextStyle(fontSize: 20, color: Colors.black, ), textAlign: TextAlign.center,),
            ),
            Container(height: 20),
            Container(margin: EdgeInsets.all(10),
              child: Text("Feel free to skip any questions if you'd like, however it will affect the accuracy of the meal plans",              
                  style: TextStyle(fontSize: 18, color: Colors.black, ), textAlign: TextAlign.center,),
            ),
            Container(margin: EdgeInsets.fromLTRB(0, 40, 0, 20), width: 150, height: 45, 
              child: ElevatedButton(onPressed: (){
                Navigator.of(context).push(MaterialPageRoute(builder: (context){ return UserStats(); }));
              },
                style: ElevatedButton.styleFrom(
                  primary: Colors.blue, 
                ),
                child: Text('Get Started', style: TextStyle(fontSize: 18, color: Colors.white))
              ),
            ),
          ],
        ),
      )
    );

  }


}