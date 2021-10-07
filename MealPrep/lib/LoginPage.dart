import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:foodplanapp/CurrentSession.dart';
import 'package:foodplanapp/DataModel/userProfile.dart';
import 'package:foodplanapp/MyColors.dart';
import 'package:foodplanapp/RootNavigationPage.dart';

class LoginPage extends StatefulWidget {

  @override
  State<StatefulWidget> createState() {
    return LoginPageState();
  }

}

class LoginPageState extends State<LoginPage>{

  InputDecoration textFieldDecoration = InputDecoration(
    
    fillColor: Colors.white,
    filled: true,
      enabledBorder: OutlineInputBorder(
        borderSide: BorderSide(width: 2, color: Colors.black),
        borderRadius: BorderRadius.circular(8),
      ),
      focusedBorder: OutlineInputBorder(
        borderSide: BorderSide(width: 2, color: MyColors.accentColor),
        borderRadius: BorderRadius.circular(8),
      ),
  );


  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  bool isLoggingIn = false;
  String? error;

  void loginClicked() async {
    setState(() {
      isLoggingIn = true;
    });
    try {
      var email = emailController.text.toLowerCase();
      UserCredential userCredential = await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: email,
        password: passwordController.text
      );

      var collection = FirebaseFirestore.instance.collection('userProfiles');
      var doc = await collection.doc(emailController.text.toLowerCase().replaceAll(".", "|")).get(); 
      UserProfile userProfile;
      var docData = doc.data();
      if (doc.exists && docData != null) {
        var username = docData["username"].toString();
        userProfile = UserProfile(username, email);
        userProfile.load(docData);
      }
      else {
        userProfile = UserProfile("New User", email);
        userProfile.save();
      }
      
      CurrentSession.currentProfile = userProfile;


      // test code

      // userProfile.goodDays = [ DateTime.now(), DateTime.now().subtract(Duration(days: 1)) ];
      // userProfile.badDays = [ DateTime.now().subtract(Duration(days: 5)) ];
      // await userProfile.save();

      // end test code




      Navigator.of(context).push(MaterialPageRoute(builder: (context){ return RootNavigationPage();}));

    } 
    on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        error = 'No user found for that email.';
      } 
      else if (e.code == 'wrong-password') {
        error = 'Invalid username or password.';
      }
      else{
        error = "Error logging in";
      }
    }
    setState(() {
      isLoggingIn = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (isLoggingIn){
      return Scaffold(
      backgroundColor: Colors.orange[50],
      body: 
      Stack(
        fit: StackFit.expand,
        children: [
          Container(color: Colors.red, child: 
            FittedBox(
              fit: BoxFit.cover,
              child: Image.asset("images/backgroundImage.png"),
            ),
          ),

          Column(children: [
            Container(height: 50),
            Container(alignment: Alignment.center, 
              child: Text("Meal Prep'd", style: TextStyle(fontSize: 40, color: Colors.white, fontWeight: FontWeight.w400))
            ),
            Container(height: 50),
            Container(alignment: Alignment.center, 
              child: Text("Logging in..", style: TextStyle(fontSize: 30, color: Colors.white, fontWeight: FontWeight.w400))
            ),
          ])
        ])
      );
    }

    Widget errorWidget;
    if (error != null){
      errorWidget = 
      Container(color: Colors.white,
        child: 
        Text(error!, style: TextStyle(color: Colors.black, fontSize: 20, fontWeight: FontWeight.bold))
      );
    }
    else{
      errorWidget = Container();
    }


    return Scaffold(
      backgroundColor: Colors.orange[50],
      body: 
      Stack(
        fit: StackFit.expand,
        children: [
        Container(color: Colors.red, child: 
          FittedBox(
            fit: BoxFit.cover,
            child: Image.asset("images/backgroundImage.png"),
          ),
        ),

        Column(children: [
          Container(height: 50),
          Container(alignment: Alignment.center, 
            child: Text("Meal Prep'd", style: TextStyle(fontSize: 40, color: Colors.white, fontWeight: FontWeight.w400))
          ),
          Container(height: 10),
          Container(margin: EdgeInsets.fromLTRB(12, 0, 0, 5), alignment: Alignment.bottomLeft, child: 
          
            Text("Email", style: TextStyle(fontSize: 16, color: Colors.white)),

          ),
          Container(margin: EdgeInsets.fromLTRB(10,0,10,0),
            child: 
            TextField(controller: emailController,
              decoration: textFieldDecoration
            ),
          ),
          
          Container(height: 10),
          Container(margin: EdgeInsets.fromLTRB(12, 0, 0, 5), alignment: Alignment.bottomLeft, child: 
            Text("Password", style: TextStyle(fontSize: 16, color: Colors.white)),
          ),
          Container(margin: EdgeInsets.fromLTRB(10,0,10,0),
            child: 
            TextField(controller: passwordController, obscureText: true,
              decoration: textFieldDecoration
            ),
          ),
          Container(height: 20),
          Container(width: 150, height: 45,
            child: 
            ElevatedButton(
              onPressed: loginClicked,
              style: ElevatedButton.styleFrom(
                primary: Colors.lightGreen[200],
              
              ), 
              child: Text("Log in", style: TextStyle(fontSize: 16, color: Colors.black))
            )
          ),
          Container(height: 10),
          errorWidget,
        ],),
      ],)
      
      
    );
  }

}