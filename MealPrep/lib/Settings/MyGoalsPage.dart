import 'package:flutter/material.dart';
import 'package:foodplanapp/MyColors.dart';

class MyGoalsPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _MyGoalsPageState();
  }
}

class _MyGoalsPageState extends State<MyGoalsPage> {
  @override
  Widget build(BuildContext context) {
     return Scaffold(
      appBar: AppBar(backgroundColor: MyColors.accentColor,
        title: const Text("Goals"),
      ),
        body: Column(
          children: <Widget>[
            Container(height: 20),
            Card(
               child: ListTile(
                  title: const Text('Weight: ', style: TextStyle(fontSize: 15, color: Colors.black)),
                  trailing: Icon(Icons.more_vert)
                ),
              color: Colors.white54,
              shadowColor: Colors.grey[300],
              elevation: 10.0,
            ),

            Container(height: 20),
            Card(
               child: ListTile(
                  title: const Text('Weekly Goal: ', style: TextStyle(fontSize: 15, color: Colors.black)),
                  trailing: Icon(Icons.more_vert)
                ),
              color: Colors.white54,
              shadowColor: Colors.grey[300],
              elevation: 10.0,
            ),

            Container(height: 20),
            Card(
               child: ListTile(
                  title: const Text('Calorie Intake: ', style: TextStyle(fontSize: 15, color: Colors.black)),
                  trailing: Icon(Icons.more_vert)
                ),
              color: Colors.white54,
              shadowColor: Colors.grey[300],
              elevation: 10.0,
            ),
          ],
        ),
     );
  }
}