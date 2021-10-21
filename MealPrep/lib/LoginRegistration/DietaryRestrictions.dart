import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:foodplanapp/Controls/MultiPicker.dart';
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
  late MultiPickerController restrictionsController;

  @override
  void initState(){
    restrictionsController = MultiPickerController();

    super.initState();
  }

  String? restriction;
  String? restrictionList;

  void nextClicked(){
    CurrentSession.currentProfile.dietaryRestrictions = restrictionsController.currentOptions;
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

      responseWidget.add(
        MultiPicker(controller: restrictionsController, options: [
          "Gluten-Free", 
          "Vegan",
          "Vegetarian",
          "Keto", 
          "Lactose Intolerant", 
          "Nut Allergy", 
          "Pescatarian", 
          "Paleo"],
          itemWidth: 200,
        )
      );
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