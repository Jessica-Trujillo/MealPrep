import 'package:flutter/material.dart';
import 'package:foodplanapp/Controls/MultiPicker.dart';
import 'package:foodplanapp/CurrentSession.dart';
import 'package:foodplanapp/MyColors.dart';
import 'package:foodplanapp/RootNavigationPage.dart';

class PrepDays extends StatefulWidget{
  @override
  State<StatefulWidget> createState(){
    return _PrepDays();
  }
}

class _PrepDays extends State<PrepDays>{
  late MultiPickerController prepDaysController;

  
void initState() {
    prepDaysController = MultiPickerController();

    super.initState();
  }


String? scheduleMeals;
String? days;

@override
  Widget build(BuildContext context) {    
 
    void nextClicked(){
      CurrentSession.currentProfile.finsihedRegistration = true;
      CurrentSession.currentProfile.save();

    Navigator.of(context).push(MaterialPageRoute(builder: (context){ return RootNavigationPage();}));
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

        MultiPicker(options: ["Mon", "Tues", "Wed", "Thurs", "Fri", "Sat", "Sun"], controller: prepDaysController, ),
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