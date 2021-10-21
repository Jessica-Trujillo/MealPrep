import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:foodplanapp/CurrentSession.dart';
import 'package:foodplanapp/LoginRegistration/DietaryRestrictions.dart';

import '../MyColors.dart';

class WeightGoal extends StatefulWidget{
  @override
  State<StatefulWidget> createState(){
    return _WeightGoal();
  }
}

class _WeightGoal extends State<WeightGoal>{

  String? weightGoal;

  String? weightGoalRate;

  @override
  void initState() {        
   

    super.initState();
  }

  @override
  void dispose() {
   
    super.dispose();
  }

  void onInputChanged() {
    setState(() {
      
    });
  }

  void nextClicked(){

    CurrentSession.currentProfile.weightGoal = weightGoal;
    CurrentSession.currentProfile.weightGoalRate = weightGoalRate;
    CurrentSession.currentProfile.save();

    Navigator.of(context).push(MaterialPageRoute(builder: (context){ return DietaryRestrictions(); }));
  }


  @override
  Widget build(BuildContext context) {    

    List<Widget> columnWidgets = [
      Container(height: 20),
      Text("Are you wanting to: ", style: TextStyle(fontSize: 26, color: Colors.black)),
      Container(height: 20),
      
      Column(mainAxisAlignment: MainAxisAlignment.start, crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Container(height: 50, child: 
          ListTile(
            title: const Text('Lose Weight'),
            leading: Radio<String>(value: "Lose", toggleable: true, activeColor: Colors.blue, groupValue: weightGoal, onChanged: (newValue){ 
              setState(() {
                weightGoal = newValue;
              }); 
            },),
          ),
        ),
        Container(height: 50,child: 
          ListTile(
            title: const Text('Maintain Weight'),
            leading: Radio<String>(value: "Maintain", toggleable: true, groupValue: weightGoal, onChanged: (newValue){ 
              setState(() {
                weightGoal = newValue;
              }); 
            },),
          )
        ),
        Container(height: 50,child: 
          ListTile(
            title: const Text('Gain Weight'),
            leading: Radio<String>(value: "Gain", toggleable: true, groupValue: weightGoal, onChanged: (newValue){ 
              setState(() {
                weightGoal = newValue;
              }); 
            },),
          )
        ),
      ]
    ),

  ];

    if (weightGoal == "Lose"){
      columnWidgets.add(Container(height: 20));
      columnWidgets.add(Text("How much would you like to lose a week?", style: TextStyle(fontSize: 20),));
    }

    if (weightGoal == "Gain"){
      columnWidgets.add(Container(height: 20));
      columnWidgets.add(Text("How much would you like to gain a week?", style: TextStyle(fontSize: 20),));
    }
    
    if (weightGoal == "Lose" || weightGoal == "Gain") {
      columnWidgets.add(Column(children: [
        Container(height: 50, child: 
          ListTile(
            title: const Text('1/2 lb a week'),
            leading: Radio<String>(value: "slow", toggleable: true, activeColor: Colors.blue, groupValue: weightGoalRate, onChanged: (newValue){ 
              setState(() {
                weightGoalRate = newValue;
              }); 
            },),
          ),
        ),
        Container(height: 50, child: 
          ListTile(
            title: const Text('1 lb a week'),
            leading: Radio<String>(value: "moderate", toggleable: true, activeColor: Colors.blue, groupValue: weightGoalRate, onChanged: (newValue){ 
              setState(() {
                weightGoalRate = newValue;
              }); 
            },),
          ),
        ),
        Container(height: 50, child: 
          ListTile(
            title: const Text('1.5 lbs a week'),
            leading: Radio<String>(value: "fast", toggleable: true, activeColor: Colors.blue, groupValue: weightGoalRate, onChanged: (newValue){ 
              setState(() {
                weightGoalRate = newValue;
              }); 
            },),
          ),
        ),

      ],));
    }
  
    columnWidgets.add(Container(margin: EdgeInsets.fromLTRB(0, 40, 0, 20), width: 150, height: 45, 
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
        title: const Text('Weight Goals'),
      ),
      body: SingleChildScrollView(
        child: Column (
          children: columnWidgets,
        ),
      )
    );
  }

}