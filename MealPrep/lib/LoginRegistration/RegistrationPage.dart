import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:foodplanapp/CurrentSession.dart';
import 'package:foodplanapp/DataModel/userProfile.dart';
import 'package:foodplanapp/LoginRegistration/RegistrationWelcomePage.dart';
import 'package:foodplanapp/LoginRegistration/UserStats.dart';
import 'package:foodplanapp/MyColors.dart';

class RegistrationPage extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {    
    return _RegistrationPageState();
  }


}

class _RegistrationPageState extends State<RegistrationPage>{
  late TextEditingController emailController;
  late TextEditingController usernameController;
  late TextEditingController passwordController;
  late TextEditingController confirmPasswordController;

  void onRegisteredClicked() async {
    String? inputError = getInputValidationError();
    if (inputError != null) {
      Common.showMessage(context, "Oops!", inputError);
      return;
    }

    try {
      await FirebaseAuth.instance.createUserWithEmailAndPassword(email: emailController.text, password: passwordController.text);
    } on FirebaseAuthException catch(e){
      Common.showMessage(context, "Oops!", e.message ?? "Unknown Error");
      return;
    }

    CurrentSession.currentProfile = UserProfile(usernameController.text, emailController.text.toLowerCase(), false);    
    CurrentSession.currentProfile.save();

    Navigator.of(context).pop();
    Navigator.of(context).push(MaterialPageRoute(builder: (context) => RegistrationWelcomePage()));
  }

  @override
  void initState() {
    emailController = TextEditingController();
    emailController.addListener(onInputChanged);

    usernameController = TextEditingController();
    usernameController.addListener(onInputChanged);

    passwordController = TextEditingController();
    passwordController.addListener(onInputChanged);

    confirmPasswordController = TextEditingController();
    confirmPasswordController.addListener(onInputChanged);

    super.initState();
  }

  @override
  void dispose(){
    emailController.removeListener(onInputChanged);
    usernameController.removeListener(onInputChanged);
    passwordController.removeListener(onInputChanged);
    confirmPasswordController.removeListener(onInputChanged);

    super.dispose();
  }

  void onInputChanged() {
    setState(() {
      
    });
  }

  String? getInputValidationError() {
    if(emailController.text.isEmpty){
      return "Email cannot be empty";
    }
    if (usernameController.text.isEmpty){
      return "Username cannot be empty";
    }
    if (passwordController.text.isEmpty){
      return "Password cannot be empty";
    }
    if (confirmPasswordController.text.isEmpty){
      return "Confirm Password cannot be empty";
    }
    if (passwordController.text != confirmPasswordController.text){
      return "Passwords do not match!!";
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {

    Color buttonColor = MyColors.accentColor;
    if (getInputValidationError() != null) {
      buttonColor = Colors.grey;
    }


    return Scaffold(
      appBar: AppBar(
        backgroundColor: MyColors.accentColor,
        title: const Text('Registration'),
      ),
      body: SingleChildScrollView(
        child: Column (
          children: <Widget>[

            Container( margin: EdgeInsets.fromLTRB(12, 25, 0, 5), alignment: Alignment.bottomLeft, child: 
              Text("Username", style: TextStyle(fontSize: 16, color: Colors.black)),
            ),
            Container(margin: EdgeInsets.fromLTRB(10, 0, 10, 0),
              child: 
              TextField(controller: usernameController,
                decoration: MyStyles.defaultInputDecoration
                ),
            ),

            Container(margin: EdgeInsets.fromLTRB(12, 25, 0, 5), alignment: Alignment.bottomLeft, child: 
              Text("Email", style: TextStyle(fontSize: 16, color: Colors.black)),
            ),
            Container(margin: EdgeInsets.fromLTRB(10,0,10,0),
              child: 
              TextField(controller: emailController,
                  decoration: MyStyles.defaultInputDecoration
              ),
            ),

            Container( margin: EdgeInsets.fromLTRB(12, 25, 0, 5), alignment: Alignment.bottomLeft, child: 
              Text("Password", style: TextStyle(fontSize: 16, color: Colors.black)),
            ),
            Container(margin: EdgeInsets.fromLTRB(10, 0, 10, 0),
              child: 
              TextField(controller: passwordController,
                decoration: MyStyles.defaultInputDecoration, obscureText: true
                ),
            ),

            Container( margin: EdgeInsets.fromLTRB(12, 25, 0, 5), alignment: Alignment.bottomLeft, child: 
              Text("Confirm Password", style: TextStyle(fontSize: 16, color: Colors.black)),
            ),
            Container(margin: EdgeInsets.fromLTRB(10, 0, 10, 0),
              child: 
              TextField(controller: confirmPasswordController,
                decoration: MyStyles.defaultInputDecoration, obscureText: true
                ),
            ),

            Container(margin: EdgeInsets.fromLTRB(0, 40, 0, 20), width: 150, height: 45, 
              child: ElevatedButton(onPressed: onRegisteredClicked,
                style: ElevatedButton.styleFrom(
                  primary: buttonColor, 
                ),
                child: Text('Create Account', style: TextStyle(fontSize: 16, color: Colors.black))
              ),
            ),

          ],
        ),
      )
    );
 
  }

}