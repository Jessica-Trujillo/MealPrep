import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:foodplanapp/CurrentSession.dart';
import 'package:foodplanapp/LoginRegistration/WeightGoalPage.dart';
import 'package:intl/intl.dart';

import '../MyColors.dart';

class UserStats extends StatefulWidget{
  @override
  State<StatefulWidget> createState(){
    return _UserStats();
  }
}

class _UserStats extends State<UserStats>{

  String? gender = null;
  late TextEditingController heightFeet;
  late TextEditingController heightInches;
  late TextEditingController weight;

  @override
  void initState() {        
    heightFeet = TextEditingController();
    heightFeet.addListener(onInputChanged);

    heightInches = TextEditingController();
    heightInches.addListener(onInputChanged);
    
    weight = TextEditingController(text: CurrentSession.currentProfile.currentWeight?.toString());
    weight.addListener(onInputChanged);
    

    super.initState();
  }

  @override
  void dispose() {
    heightFeet.removeListener(onInputChanged);
    heightInches.removeListener(onInputChanged);
    weight.removeListener(onInputChanged);
    super.dispose();
  }

  void onInputChanged() {
    setState(() {
      
    });
  }

  void pickBirthday() async {
    DateTime? picked = await showDatePicker(
        context: context,
        initialDate: DateTime(1995),
        firstDate: DateTime(1900),
        lastDate: DateTime.now()
    );

    setState(() {
      CurrentSession.currentProfile.birthday = picked;
      CurrentSession.currentProfile.save();
    });
  }

  void nextClicked(){
    CurrentSession.currentProfile.currentWeight = int.tryParse(weight.text);

    int totalInches = (int.tryParse(heightFeet.text) ?? 0) * 12;
    totalInches += int.tryParse(heightInches.text) ?? 0;

    CurrentSession.currentProfile.heightInInches = totalInches;

    CurrentSession.currentProfile.gender = gender;
    CurrentSession.currentProfile.save();

    Navigator.of(context).push(MaterialPageRoute(builder: (context){ return WeightGoal(); }));
  }

  @override
  Widget build(BuildContext context) {

    var format = DateFormat('MMM d yyyy');

    String datePickerText = CurrentSession.currentProfile.birthday == null ? "Select your birthday" : format.format(CurrentSession.currentProfile.birthday!);
  
    List<Widget> mainChildren = [
      Container( margin: EdgeInsets.fromLTRB(12, 25, 0, 15), alignment: Alignment.bottomLeft, child: 
        Text("When is your birthday?", style: TextStyle(fontSize: 16, color: Colors.black)),
      ),
      Container(alignment: Alignment.centerLeft, 
        child: Container(height: 55, width: 200, margin: EdgeInsets.fromLTRB(10, 0, 10, 0),
          child: 
          ElevatedButton(onPressed: pickBirthday, 
            style:ElevatedButton.styleFrom(
                  primary:Colors.white,
                  side: BorderSide(color: Colors.black, width: 2)
            ),
            child: Container(alignment: Alignment.centerLeft, child: Text(datePickerText, style: TextStyle(color: Colors.grey[800]!),),)
          )
        ),
      ),

      Container(margin: EdgeInsets.fromLTRB(12, 25, 0, 5), alignment: Alignment.bottomLeft, child: 
        Text("How tall are you?", style: TextStyle(fontSize: 16, color: Colors.black)),
      ),
      Row(
        children: [
          Expanded(child:                   
            Container(margin: EdgeInsets.fromLTRB(10,0,10,0),
              child: TextField(controller: heightFeet, decoration: MyStyles.defaultInputDecoration, keyboardType: TextInputType.numberWithOptions(decimal: false, signed: false)),
            ),
          ),
          Text("Feet", style: TextStyle(fontSize: 16)),
          Expanded(child: 
            Container(margin: EdgeInsets.fromLTRB(10,0,10,0),
              child: TextField(controller: heightInches, decoration: MyStyles.defaultInputDecoration, keyboardType: TextInputType.numberWithOptions(decimal: false, signed: false) ),
            ),
          ),
          Text("Inches", style: TextStyle(fontSize: 16)),
          Container(width: 10)
        ],
      ),
      
      Container(margin: EdgeInsets.fromLTRB(12, 25, 0, 5), alignment: Alignment.bottomLeft, child: 
        Text("What is your gender?", style: TextStyle(fontSize: 16, color: Colors.black)),
      ),
        Row(mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Expanded(child: 
            ListTile(
              title: const Text('Male'),
              leading: Radio<String>(value: "Male", toggleable: true, activeColor: Colors.blue, groupValue: gender, onChanged: (newValue){ 
                setState(() {
                  gender = newValue;
                }); 
              },),
            ),
          ),
          Expanded(child: 
            ListTile(
              title: const Text('Female'),
              leading: Radio<String>(value: "Female", toggleable: true, groupValue: gender, onChanged: (newValue){ 
                setState(() {
                  gender = newValue;
                }); 
              },),
            )
          )
        ]
      ),      

      Container( margin: EdgeInsets.fromLTRB(12, 25, 0, 5), alignment: Alignment.bottomLeft, child: 
        Text("How much do you currently weigh", style: TextStyle(fontSize: 16, color: Colors.black)),
      ),

      Row(
        children: [
          Expanded(child:                   
            Container(margin: EdgeInsets.fromLTRB(10,0,10,0),
              child: TextField(controller: weight, decoration: MyStyles.defaultInputDecoration, keyboardType: TextInputType.numberWithOptions(decimal: false, signed: false)),
            ),
          ),
          Text("lbs", style: TextStyle(fontSize: 16),),
          Container(width: 10)
        ]
      ),
      Container(margin: EdgeInsets.fromLTRB(0, 40, 0, 20), width: 150, height: 45, 
        child: ElevatedButton(onPressed: nextClicked,
          style: ElevatedButton.styleFrom(
            primary: Colors.blue, 
          ),
          child: Text('Next', style: TextStyle(fontSize: 18, color: Colors.white))
        ),
      ),

    ];

    return Scaffold(
      appBar: AppBar(
        backgroundColor: MyColors.accentColor,
        title: const Text('Starting Information'),
      ),
      body: SingleChildScrollView(
        child: Column (
          children: mainChildren,
        ),
      )
    );
  }

}