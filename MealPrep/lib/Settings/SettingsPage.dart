import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:foodplanapp/CurrentSession.dart';
import 'package:foodplanapp/LoginRegistration/LoginPage.dart';
import 'package:foodplanapp/MyColors.dart';
import 'package:foodplanapp/Settings/EditProfile.dart';
import 'package:foodplanapp/Settings/MyGoalsPage.dart';
import 'package:foodplanapp/Settings/NotificationsPage.dart';
import 'package:foodplanapp/Settings/PasswordChange.dart';

class SettingsPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _SettingsPageState();
  }
}

class _SettingsPageState extends State<SettingsPage> {

  void logout(){
    FirebaseAuth.instance.signOut();
    Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context){ return LoginPage();}), (_) => false);
  }

  @override
  Widget build(BuildContext context) {
     return Scaffold(
      appBar: AppBar(backgroundColor: MyColors.accentColor,
        title: const Text('Settings'),
      ),
        body: Column(
          children: <Widget>[
            Container(height: 20),
            Container(margin: EdgeInsets.fromLTRB(15, 0, 0, 10), alignment: Alignment.centerLeft,
              child: Text("My Account", style: TextStyle(fontSize: 20, color: Colors.black, fontWeight: FontWeight.w400))
            ),
            Container(height: 20),
            Card(
                child: ListTile(
                  onTap: () {
                    Navigator.push(context, MaterialPageRoute(builder: (context) => EditProfile()));
                  },
                 title: const Text('Edit Profile', style: TextStyle(fontSize: 15, color: Colors.black)),
                ),
              color: Colors.white54,
              shadowColor: Colors.grey[300],
              elevation: 10.0,
            ),

            Container(height: 20),
            Card(
               child: ListTile(
                  onTap: () {
                    Navigator.push(context, MaterialPageRoute(builder: (context) => MyGoalsPage()));
                  },
                  title: const Text('My Goals', style: TextStyle(fontSize: 15, color: Colors.black)),
                ),
              color: Colors.white54,
              shadowColor: Colors.grey[300],
              elevation: 10.0,
            ),            
            
            //TODO:: Not MVP
            // Container(height: 20),
            // Card(
            //   child: ListTile(
            //     onTap: () {
            //         Navigator.push(context, MaterialPageRoute(builder: (context) => NotificationsPage()));
            //       },
            //       title: const Text('Notifications', style: TextStyle(fontSize: 15, color: Colors.black)),
            //   ),
            //   color: Colors.white54,
            //   shadowColor: Colors.grey[300],
            //   elevation: 10.0,
            // ),
            
            Container(height: 20),
            Card(
              child: ListTile(
                onTap: () {
                    Navigator.push(context, MaterialPageRoute(builder: (context) => PasswordChangePage()));
                  },
                  title: const Text('Change Password', style: TextStyle(fontSize: 15, color: Colors.black)),
                ),
              color: Colors.white54,
              shadowColor: Colors.grey[300],
              elevation: 10.0,
            ),

            Container(height: 20),
            Card(
              child: ListTile(
                onTap: () {
                    showDialog<String>(
                    context: context,
                    builder: (BuildContext context) => AlertDialog(
                      title: const Text('Logging Out'),
                      content: const Text('You are logging out. Are you sure?'),
                      actions: <Widget>[
                        TextButton(
                          onPressed: () => Navigator.pop(context, 'Cancel'),
                          child: const Text('Cancel'),
                        ),
                        TextButton(
                          onPressed: logout,
                          child: const Text('OK'),
                        ),
                      ],
                    ),
                  );
                 },
                  title: const Text('Log Out', style: TextStyle(fontSize: 15, color: Colors.black)),
                ),
              color: Colors.white54,
              shadowColor: Colors.grey[300],
              elevation: 10.0,
              )    

          ],
        ),
    );
  }
}