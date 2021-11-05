import 'package:flutter/material.dart';
import 'package:foodplanapp/MyColors.dart';

class NotificationsPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _NotificationsPageState();
  }
}

class _NotificationsPageState extends State<NotificationsPage> {
  @override
  Widget build(BuildContext context) {
     return Scaffold(
      appBar: AppBar(backgroundColor: MyColors.accentColor,
        title: const Text("Notification"),
      ),
      body: Column(
          children: <Widget>[
            Container(height: 20),
            Card(
              child: ListTile(
                  title: const Text('Prep Day Reminders: ', style: TextStyle(fontSize: 15, color: Colors.black)),
                  trailing: Icon(Icons.more_vert)
                  //Maybe add the calendar pop up to reset reminders
                ),
              color: Colors.white54,
              shadowColor: Colors.grey[300],
              elevation: 10.0,
            ),
          ]
      )
     );
  }
}