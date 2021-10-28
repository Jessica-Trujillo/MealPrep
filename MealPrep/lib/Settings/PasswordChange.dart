import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:foodplanapp/CurrentSession.dart';
import 'package:foodplanapp/MyColors.dart';
import 'package:foodplanapp/Settings/SettingsPage.dart';

class PasswordChangePage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _PasswordChangePageState();
  }
}

class _PasswordChangePageState extends State<PasswordChangePage> {

    late TextEditingController passwordController;
    late TextEditingController newPasswordController;
    late TextEditingController confirmNewPasswordController;

     @override
  void initState() {
    passwordController = TextEditingController();
    passwordController.addListener(onInputChanged);

    newPasswordController = TextEditingController();
    newPasswordController.addListener(onInputChanged);

    passwordController = TextEditingController();
    passwordController.addListener(onInputChanged);

    confirmNewPasswordController = TextEditingController();
    confirmNewPasswordController.addListener(onInputChanged);

    super.initState();
  }

    @override
  void dispose(){
    passwordController.removeListener(onInputChanged);
    newPasswordController.removeListener(onInputChanged);
    confirmNewPasswordController.removeListener(onInputChanged);

    super.dispose();
  }

  void onInputChanged() {
    setState(() {
      
    });
  }


    Widget buildCard(String title, String value, Function()? onEdit){
    Widget? trailing;
    if (onEdit != null){
      trailing = PopupMenuButton(
        child:  Container(margin: EdgeInsets.symmetric(horizontal: 7), child: Icon(Icons.more_vert)),
        itemBuilder: (context) {
          return List.generate(1, (index) {
            return PopupMenuItem(
              value: index,
              child: Text('Edit'),
            );
          });
        },
        onSelected: (index){
          onEdit();
        },
      );
    }

    return Card(
        child: ListTile(
          title: Text(title + ': ' + value, style: TextStyle(fontSize: 15, color: Colors.black)),
          trailing: trailing,
        ),
      color: Colors.grey[350],
      shadowColor: Colors.grey[600],
      elevation: 10.0,
    );
  }

    void onPopupButtonPressed(Function()? callback){
      if (callback != null){
        callback.call();
      }
      else{
        Navigator.pop(context, 'Ok');
      }
    }

    void showPopup(String title, String content, {Function()? callback}){
       showDialog<String>(
          context: context,
          builder: (BuildContext context) => AlertDialog(
            title: Text(title),
            content: Text(content),
            actions: <Widget>[
              TextButton(
                onPressed: () => {
                  onPopupButtonPressed(callback)
                },
                child: const Text('Ok'),
              ),
            ],
          ),
        );
    }

    void _changePassword() async {
      if (passwordController.text.isEmpty || newPasswordController.text.isEmpty || confirmNewPasswordController.text.isEmpty){
        showPopup('Oh No!', 'It looks like you have a blank field. Please fix it!');
        return;
      }
      if(passwordController.text == newPasswordController.text){
        showPopup('Oh No!', 'It looks like your current password and new password match. Please fix it!');
        return;
      }
      if(newPasswordController.text != confirmNewPasswordController.text){
        showPopup('Oh No!', 'It looks like your new password and confirm password don\'t match. Please fix it!');
        return;
      }
      if(newPasswordController.text.length < 6){
        showPopup('Oh No!', 'Your password must be at least 6 characters long!');
        return;
      }

      final user = await FirebaseAuth.instance.currentUser;
      final cred = EmailAuthProvider.credential(
          email: CurrentSession.currentProfile.email, password: passwordController.text.toString());
      

      user!.reauthenticateWithCredential(cred).then((value) {
        user.updatePassword(newPasswordController.text.toString()).then((_) {
          
          showPopup('Success!!', 'Your password was changed!', callback: (){
            Navigator.pop(context, 'Ok');
            Navigator.of(context).pop();
          });

        }).catchError((error) {
          if (error is FirebaseAuthException ){
            showPopup('Oh No!', 'We encountered an error and your password was not changed. Error: ' + error.message.toString());
          }
          else{
            showPopup('Oh No!', 'We encountered an error and your password was not changed. Try again later.');
          }
        });
      }).catchError((err) {
        if (err is FirebaseAuthException ){
          showPopup('Oh No!', 'We encountered an error and your password was not changed. Error: ' + err.message.toString());
        }
        else{
          showPopup('Oh No!', 'We encountered an error and your password was not changed. Try again later.');
        }
      });
    }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(backgroundColor: MyColors.accentColor,
        title: const Text("Change Password"),
      ),
      body: Container(margin: EdgeInsets.symmetric(horizontal: 10), child: 
      
      Column(
        children: <Widget>[
          Container(height: 20),
          Row(children: [
            Container(width: 160,alignment: Alignment.centerRight,  child: 
              Text("Current Password: "),
            ),
            Expanded(child: 
              Container (height: 40,
                child: TextField(controller: passwordController, decoration: MyStyles.defaultInputDecoration),
              )
            )
          ]),
          Container(height: 10),
          Row(children: [
            Container(width: 160,alignment: Alignment.centerRight,  child: 
              Text("New Password: "),
            ),
            Expanded(child: 
              Container (height: 40,
                child: TextField(controller: newPasswordController,decoration: MyStyles.defaultInputDecoration),
              )
            )
          ]),
          Container(height: 10),          
          Row(children: [
            Container(width: 160,alignment: Alignment.centerRight,  child: 
              Text("Confirm New Password: "),
            ),
            Expanded(child: 
              Container (height: 40,
                child: TextField(controller: confirmNewPasswordController,decoration: MyStyles.defaultInputDecoration), 
              )
            )
          ]),
          Container(height: 25),
          ElevatedButton(onPressed: (){
            _changePassword();
          }, child: Text("Change Password"))
        ]),
      )
    );
  }
}