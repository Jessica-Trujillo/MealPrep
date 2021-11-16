import 'package:flutter/material.dart';
import 'package:foodplanapp/CurrentSession.dart';
import 'package:foodplanapp/DayControl.dart';
import 'package:foodplanapp/MealCard.dart';
import 'package:foodplanapp/MyColors.dart';
import 'package:calendar_timeline/calendar_timeline.dart';
import 'package:foodplanapp/Calendar/CalendarDay.dart';
import 'package:foodplanapp/DataModel/TrackedDay.dart';
import 'package:foodplanapp/Recipes/Recipe.dart';
import 'package:foodplanapp/Recipes/RecipesPage.dart';
import 'package:foodplanapp/main.dart';

class DayControl extends StatefulWidget{
  DateTime day;
  DayControl(this.day);

  @override
  State<StatefulWidget> createState() {
    return _DayControlState();
  }



}

class _DayControlState extends State<DayControl>{

  
  String hourAndMinuteToTime(int hour, int minute){
    String minutePart = minute.toString();
    if (minutePart.length == 1)
      minutePart = "0" + minutePart;

    if (hour > 12){
      return (hour - 12).toString() + ":" + minutePart + " PM";
    }
    return hour.toString() + ":" + minutePart + " AM";
  }

  @override
  Widget build(BuildContext context) {
    
    var startDay = CurrentSession.currentProfile.mealPlanStartDay;
    List<Widget> mealCards = [];
    if (startDay != null){
      var timeSinceStart = this.widget.day.difference(startDay);
      int days = timeSinceStart.inDays;
      if (days >= 0 && days < 7){
        var mealsForDay = CurrentSession.currentProfile.resolvedMealPlan?.meals?.where((element) => element.day == days);
        var ingNeeded = CurrentSession.currentProfile.resolvedMealPlan?.ingredientsNeeded;
        if (mealsForDay != null){
          for(var mealTime in mealsForDay){
            var title = hourAndMinuteToTime(mealTime.hour!, mealTime.minute!);
            
            var meal = mealTime.meal;
            if (meal == null)
              continue;
            mealCards.add(
              MealCard(meal: meal, title: title)
            );

            mealCards.add(Container(height: 10));
            
          } 
        }
      }
      else{
        mealCards.add(Text("Sorry, this day does not fall under the current meal plan.", style: TextStyle(fontSize: 22), textAlign: TextAlign.center,));
      }
    }

    return SingleChildScrollView(child:Column(children: mealCards));
  }


}