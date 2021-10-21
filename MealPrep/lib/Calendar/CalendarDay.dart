import 'package:foodplanapp/CurrentSession.dart';
import 'package:intl/intl.dart';
import 'package:flutter/material.dart';
import 'package:foodplanapp/MyColors.dart';

class CalendarDayPage extends StatefulWidget{
  final DateTime trackedDay;
  CalendarDayPage({required this.trackedDay});

  @override
  State<StatefulWidget> createState() {
    return _CalendarDayPageState();
  }

}



class _CalendarDayPageState extends State<CalendarDayPage>{

  void toggleGoodDay(){
    setState(() {
      var profile = CurrentSession.currentProfile;
      // Current day is not a good day
      if (!profile.goodDays.any((element) => element.day == widget.trackedDay.day && element.month == widget.trackedDay.month)){
        profile.goodDays.add(widget.trackedDay);
      }
      else{
        profile.goodDays.removeWhere((element) => element.day == widget.trackedDay.day && element.month == widget.trackedDay.month);
      }

      profile.badDays.removeWhere((element) => element.day == widget.trackedDay.day && element.month == widget.trackedDay.month);
      profile.save();
    });
    
  }

  void toggleBadDay(){
    setState(() {
      var profile = CurrentSession.currentProfile;
      if (!profile.badDays.any((element) => element.day == widget.trackedDay.day && element.month == widget.trackedDay.month)){
        profile.badDays.add(widget.trackedDay);
      }
      else {
        profile.badDays.removeWhere((element) => element.day == widget.trackedDay.day && element.month == widget.trackedDay.month);
      }
      profile.goodDays.removeWhere((element) => element.day == widget.trackedDay.day && element.month == widget.trackedDay.month);
      profile.save();
    });
    
  }

  Widget buildCard(String title, String calories, String mealTitle, String ingredient1, String ingredient2){
    return Container(margin: EdgeInsets.all(15), color: MyColors.accentColor, child: 
      Container(margin: EdgeInsets.fromLTRB(20, 20, 20, 20), child: 
        Row(children: [
            Container(height: 180, width: 200, child: 
              FittedBox(fit: BoxFit.cover, clipBehavior: Clip.hardEdge,
                child: Image.asset("images/backgroundImage.png"),
              )
            ),
            Container(margin: EdgeInsets.all(5), child: 
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                FittedBox(child:Text(title, style: TextStyle(fontSize: 20, color: Colors.white))),
                FittedBox(child:Text(calories + " Calories", style: TextStyle(fontSize: 16, color: Colors.white))),
                FittedBox(child:Text(mealTitle, style: TextStyle(fontSize: 16, color: Colors.white))),
                Divider(color: Colors.black, thickness: 3),
                Text(ingredient1, style: TextStyle(color: Colors.white)),
                Text(ingredient2, style: TextStyle(color: Colors.white))
              ],)
            )
        ])
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final DateFormat formatter = DateFormat('MMMM d');
    final String selectedDateStr = formatter.format(this.widget.trackedDay);

    var profile = CurrentSession.currentProfile;

    Color goodDayColor;
    if (profile.goodDays.any((element) => element.day == this.widget.trackedDay.day && element.month == this.widget.trackedDay.month)){
      goodDayColor = Colors.green;
    }
    else {
      goodDayColor = Colors.grey[800]!;
    }


    Color badDayColor;
    if (profile.badDays.any((element) => element.day == this.widget.trackedDay.day && element.month == this.widget.trackedDay.month)){
      badDayColor = Colors.red;
    }
    else {
      badDayColor = Colors.grey[800]!;
    }
    double width = MediaQuery. of(context). size. width;

    return Scaffold(
      appBar: AppBar(backgroundColor: MyColors.accentColor,
        title: Text(selectedDateStr),
      ),
      body: Column(children: [
        Container(margin: EdgeInsets.fromLTRB(0, 20, 0, 10), alignment: Alignment.center,
          child: Text(selectedDateStr + " Meal Plan", style: TextStyle(fontSize: 30),),
        ),        
        Expanded(child: 
          SingleChildScrollView(child: 
            Column(children: [
              buildCard("Breakfast", "422", "Frosted Flakes","1 cup whole milk", "1 cup frosted flakes"),
              buildCard("Lunch", "360", "Sandwich","2 slices bread", "1 cup cheese"),
              buildCard("Dinner", "500", "Steaks","1 cup steak", "5 lb potato"),
            ])
          )
        ),
        Container(margin: EdgeInsets.symmetric(vertical: 25), child:
          Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [
            Center(child: 
              ElevatedButton(onPressed: toggleBadDay, child: Text("Mark as bad day :("),
                style: ElevatedButton.styleFrom(
                  primary: badDayColor,
                )
              )
            ),
            Center(child: 
              ElevatedButton(onPressed: toggleGoodDay, child: Text("Mark as good day!"),
                style: ElevatedButton.styleFrom(
                  primary: goodDayColor,
                )
              )
            ),
          ],)
        )
      ]), 
    );
  }

}
