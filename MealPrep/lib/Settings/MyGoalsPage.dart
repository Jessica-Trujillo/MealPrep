import 'package:flutter/material.dart';
import 'package:foodplanapp/Controls/SinglePicker.dart';
import 'package:foodplanapp/CurrentSession.dart';
import 'package:foodplanapp/MyColors.dart';

class MyGoalsPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _MyGoalsPageState();
  }
}

class _MyGoalsPageState extends State<MyGoalsPage> {


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

  void editWithIntField(String title, int? currentValue, String? unit, Function(int?) onEnteredValue){
    TextEditingController intController = TextEditingController(text: currentValue.toString());
    showDialog(context: context, builder: (context)=>
      AlertDialog(
        title: Text(title),
        content: 
        Container(height: 150, child:
          Row( mainAxisAlignment: MainAxisAlignment.end,
            children: 
            [Container(width: 100,  child: TextField(controller: intController, decoration: MyStyles.defaultInputDecoration, textAlign: TextAlign.right,)),
            Container(margin: EdgeInsets.symmetric(horizontal: 5), child: Text(unit ?? ""))
            ]),
        ),
        actions: [
          ElevatedButton(onPressed: (){
            Navigator.of(context).pop();
          }, child: Text("Cancel")),
          ElevatedButton(onPressed: (){
            Navigator.of(context).pop();
            onEnteredValue(int.tryParse(intController.text));
          }, child: Text("Ok"))
        ],
      )
    );
  }

  void editWithRadioField(String title, String? currentValue, List<String> options, Function(String?) onEnteredValue){
    SinglePickerController controller = SinglePickerController(initialOption: currentValue);
    showDialog(context: context, builder: (context)=>
      AlertDialog(
        title: Text(title),
        content: SinglePicker(controller: controller,options: options, itemWidth: 200,),
        actions: [
          ElevatedButton(onPressed: (){
            Navigator.of(context).pop();
          }, child: Text("Cancel")),
          ElevatedButton(onPressed: (){
            Navigator.of(context).pop();
            onEnteredValue(controller.currentOption);
          }, child: Text("Ok"))
        ],
      )
    );
  }

  @override
  Widget build(BuildContext context) {
     return Scaffold(
      appBar: AppBar(backgroundColor: MyColors.accentColor,
        title: const Text("Goals"),
      ),
        body: Column(
          children: <Widget>[
            Container(height: 20),
            buildCard("Current Weight ", CurrentSession.currentProfile.currentWeight.toString() + " lbs", (){
              editWithIntField("Enter Current Weight", CurrentSession.currentProfile.currentWeight, "lbs", (str){
                setState(() {
                  CurrentSession.currentProfile.currentWeight = str;
                  CurrentSession.currentProfile.save();
                });
              });
            }),

            Container(height: 20),
            buildCard("Weight Goal ", CurrentSession.currentProfile.weightGoal.toString(), (){
              editWithRadioField("Enter Current Weight", CurrentSession.currentProfile.weightGoal, ["Gain", "Maintain", "Lose"], (str){
                setState(() {
                  CurrentSession.currentProfile.weightGoal = str;
                  CurrentSession.currentProfile.save();
                });
              });
            }),

            Container(height: 20),
            buildCard("Weight Rate Goal ", CurrentSession.currentProfile.weightGoalRate.toString(), (){
              editWithRadioField("Enter Weekly Rate Goal", CurrentSession.currentProfile.weightGoal, ["1/2 lb", "1 lb", "1.5 lbs"], (str){
                setState(() {
                  CurrentSession.currentProfile.weightGoalRate = str;
                  CurrentSession.currentProfile.save();
                });
              });
            }),

            Container(height: 20),
            buildCard("Calorie Intake ", "1525 calories", null),
          ],
        ),
     );
  }
}