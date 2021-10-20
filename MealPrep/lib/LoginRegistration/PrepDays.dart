import 'package:flutter/material.dart';
import 'package:foodplanapp/CurrentSession.dart';
import 'package:foodplanapp/Home/HomePage.dart';
import 'package:foodplanapp/MyColors.dart';

class PrepDays extends StatefulWidget{
  @override
  State<StatefulWidget> createState(){
    return _PrepDays();
  }
}

class _PrepDays extends State<PrepDays>{

String? scheduleMeals;
String? days;

@override
  Widget build(BuildContext context) {    
 
    void nextClicked(){
      CurrentSession.currentProfile.finsihedRegistration = true;
      //CurrentSession.currentProfile.prepDays;
      CurrentSession.currentProfile.save();

    Navigator.of(context).push(MaterialPageRoute(builder: (context){ return HomePage();}));
  }

    List<Widget> responseWidget =[
      Container(height: 20,),
        Text("Would you like to prepare meals ahead of time? ", style: TextStyle(fontSize: 26, color: Colors.black,), textAlign: TextAlign.center,),
        Container(height: 20),
        
          Row(mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Expanded(child: 
              ListTile(
                title: const Text('No'),
                leading: Radio<String>(value: "No", toggleable: true, activeColor: Colors.blue, groupValue: scheduleMeals, onChanged: (newValue){ 
                  setState(() {
                    scheduleMeals = newValue;
                  }); 
                },),
              ),
            ),
            Expanded(child: 
              ListTile(
                title: const Text('Yes'),
                leading: Radio<String>(value: "Yes", toggleable: true, groupValue: scheduleMeals, onChanged: (newValue){ 
                  setState(() {
                    scheduleMeals = newValue;
                  }); 
                },),
              )
            )
          ]
          ),
    ];

    if (scheduleMeals == "Yes") {
      responseWidget.add(Column(children: [
        Container(height: 20,),
        Text("Which days would you like to prep?", style: TextStyle(fontSize: 20, color: Colors.black,), textAlign: TextAlign.center,),
        Container(height: 20),

        Container(height: 50, child: 
          ListTile(
            title: const Text('Mon'),
            leading: Radio<String>(value: "M", toggleable: true, activeColor: Colors.blue, groupValue: days, onChanged: (newValue){ 
              setState(() {
                days = newValue;
              }); 
            },),
          ),
        ),
        Container(height: 50, child: 
          ListTile(
            title: const Text('Tues'),
            leading: Radio<String>(value: "T", toggleable: true, activeColor: Colors.blue, groupValue: days, onChanged: (newValue){ 
              setState(() {
                days = newValue;
              }); 
            },),
          ),
        ),
        Container(height: 50, child: 
          ListTile(
            title: const Text('Wed'),
            leading: Radio<String>(value: "W", toggleable: true, activeColor: Colors.blue, groupValue: days, onChanged: (newValue){ 
              setState(() {
                days = newValue;
              }); 
            },),
          ),
        ),
        Container(height: 50, child: 
          ListTile(
            title: const Text('Thurs'),
            leading: Radio<String>(value: "R", toggleable: true, activeColor: Colors.blue, groupValue: days, onChanged: (newValue){ 
              setState(() {
                days = newValue;
              }); 
            },),
          ),
        ),
        Container(height: 50, child: 
          ListTile(
            title: const Text('Fri'),
            leading: Radio<String>(value: "F", toggleable: true, activeColor: Colors.blue, groupValue: days, onChanged: (newValue){ 
              setState(() {
                days = newValue;
              }); 
            },),
          ),
        ),
        Container(height: 50, child: 
          ListTile(
            title: const Text('Sat'),
            leading: Radio<String>(value: "Sa", toggleable: true, activeColor: Colors.blue, groupValue: days, onChanged: (newValue){ 
              setState(() {
                days = newValue;
              }); 
            },),
          ),
        ),
        Container(height: 50, child: 
          ListTile(
            title: const Text('Sun'),
            leading: Radio<String>(value: "Su", toggleable: true, activeColor: Colors.blue, groupValue: days, onChanged: (newValue){ 
              setState(() {
                days = newValue;
              }); 
            },),
          ),
        ),
        
      ],));
    }

    responseWidget.add(Container(margin: EdgeInsets.fromLTRB(0, 40, 0, 20), width: 150, height: 45, 
        child: ElevatedButton(onPressed: nextClicked,
          style: ElevatedButton.styleFrom(
            primary: Colors.blue, 
          ),
          child: Text('Next', style: TextStyle(fontSize: 18, color: Colors.white))
        ),
      ));

    
     return Scaffold(
      appBar: AppBar(
        backgroundColor: MyColors.accentColor,
        title: const Text('Schedule'),
      ),
      body: SingleChildScrollView(
        child: Column (
          children: responseWidget,

        ),
      )
    );

  }
}