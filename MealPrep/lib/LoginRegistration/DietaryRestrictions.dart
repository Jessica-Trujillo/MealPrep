import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:foodplanapp/CurrentSession.dart';
import 'package:foodplanapp/LoginRegistration/PrepDays.dart';

import '../MyColors.dart';

class DietaryRestrictions extends StatefulWidget{
  @override
  State<StatefulWidget> createState(){
    return _DietaryRestrictions();
  }
}

class _DietaryRestrictions extends State<DietaryRestrictions>{

String? restriction;
String? restrictionList;

void nextClicked(){
    CurrentSession.currentProfile.dietaryRestrictions;
    CurrentSession.currentProfile.save();

    Navigator.of(context).push(MaterialPageRoute(builder: (context){ return PrepDays();}));
  }


@override
  Widget build(BuildContext context) {    
    
    List<Widget> responseWidget =[
      Container(height: 20,),
        Text("Let's make sure we generate a meal plan that is right for you. ", style: TextStyle(fontSize: 26, color: Colors.black,), textAlign: TextAlign.center,),
        Container(height: 20),
        Text("Do you have any dietary restrictions? ", style: TextStyle(fontSize: 20, color: Colors.black)),
        Container(height: 20),
        
          Row(mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Expanded(child: 
              ListTile(
                title: const Text('No'),
                leading: Radio<String>(value: "None", toggleable: true, activeColor: Colors.blue, groupValue: restriction, onChanged: (newValue){ 
                  setState(() {
                    restriction = newValue;
                  }); 
                },),
              ),
            ),
            Expanded(child: 
              ListTile(
                title: const Text('Yes'),
                leading: Radio<String>(value: "Yes", toggleable: true, groupValue: restriction, onChanged: (newValue){ 
                  setState(() {
                    restriction = newValue;
                  }); 
                },),
              )
            )
          ]
          ),
    ];

    if(restriction == "Yes"){
      responseWidget.add(Container(height: 20));
      responseWidget.add(Text("What restrictions do you have (Choose all that apply): "));

      responseWidget.add(Column(children: [
        Container(height: 50, child: 
          ListTile(
            title: const Text('Gluten-Free'),
            leading: Radio<String>(value: "Gluten", toggleable: true, activeColor: Colors.blue, groupValue: restrictionList, onChanged: (newValue){ 
              setState(() {
                restrictionList = newValue;
              }); 
            },),
          ),
        ),
        Container(height: 50, child: 
          ListTile(
            title: const Text('Vegan'),
            leading: Radio<String>(value: "Vegan", toggleable: true, activeColor: Colors.blue, groupValue: restrictionList, onChanged: (newValue){ 
              setState(() {
                restrictionList = newValue;
              }); 
            },),
          ),
        ),
        Container(height: 50, child: 
          ListTile(
            title: const Text('Vegetarian'),
            leading: Radio<String>(value: "Vegitarian", toggleable: true, activeColor: Colors.blue, groupValue: restrictionList, onChanged: (newValue){ 
              setState(() {
                restrictionList = newValue;
              }); 
            },),
          ),
        ),
         Container(height: 50, child: 
          ListTile(
            title: const Text('Keto'),
            leading: Radio<String>(value: "Keto", toggleable: true, activeColor: Colors.blue, groupValue: restrictionList, onChanged: (newValue){ 
              setState(() {
                restrictionList = newValue;
              }); 
            },),
          ),
        ),
        Container(height: 50, child: 
          ListTile(
            title: const Text('Lactose Intolerant'),
            leading: Radio<String>(value: "Lactose", toggleable: true, activeColor: Colors.blue, groupValue: restrictionList, onChanged: (newValue){ 
              setState(() {
                restrictionList = newValue;
              }); 
            },),
          ),
        ),
        Container(height: 50, child: 
          ListTile(
            title: const Text('Nut Allergy'),
            leading: Radio<String>(value: "Nuts", toggleable: true, activeColor: Colors.blue, groupValue: restrictionList, onChanged: (newValue){ 
              setState(() {
                restrictionList = newValue;
              }); 
            },),
          ),
        ),
        Container(height: 50, child: 
          ListTile(
            title: const Text('Pescatarian'),
            leading: Radio<String>(value: "Pesc", toggleable: true, activeColor: Colors.blue, groupValue: restrictionList, onChanged: (newValue){ 
              setState(() {
                restrictionList = newValue;
              }); 
            },),
          ),
        ),
         Container(height: 50, child: 
          ListTile(
            title: const Text('Paleo'),
            leading: Radio<String>(value: "Paleo", toggleable: true, activeColor: Colors.blue, groupValue: restrictionList, onChanged: (newValue){ 
              setState(() {
                restrictionList = newValue;
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
        title: const Text('Dietary Restrictions'),
      ),
      body: SingleChildScrollView(
        child: Column (
          children: responseWidget,
        ),
      )
    );

  }
}