import 'package:flutter/material.dart';
import 'package:foodplanapp/CurrentSession.dart';
import 'package:foodplanapp/MyColors.dart';
import 'package:calendar_timeline/calendar_timeline.dart';
import 'package:foodplanapp/Calendar/CalendarDay.dart';
import 'package:foodplanapp/DataModel/TrackedDay.dart';

class HomePage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _HomePageState();
  }
}

class _HomePageState extends State<HomePage> {
  DateTime _selectedDate = DateTime.now();

  @override
  void initState() {
    super.initState();
    _resetSelectedDate();
  }

  void _resetSelectedDate() {
    _selectedDate = DateTime.now();
  }

  String hourAndMinuteToTime(int hour, int minute){
    String minutePart = minute.toString();
    if (minutePart.length == 1)
      minutePart = "0" + minutePart;

    if (hour > 12){
      return (hour - 12).toString() + ":" + minutePart + " PM";
    }
    return hour.toString() + ":" + minutePart + " AM";
  }

  Widget buildCard(String title, String calories, String mealTitle,
      String ingredient1, String ingredient2, String imagePath) {
    return Card(
      margin: EdgeInsets.fromLTRB(20, 5, 20, 5),
      color: MyColors.cardColor,
      child: Container(
          child: Row(
            
            children: [
        Container(
            height: 125,
            width: 125,
            child: FittedBox(
              fit: BoxFit.cover,
              clipBehavior: Clip.hardEdge,
              child: Image.network(imagePath), 
            )),
        Expanded(child: 
          Container(
              margin: EdgeInsets.fromLTRB(15, 10, 5, 10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
                    FittedBox(
                        child: Text(title,
                            style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                color: Color(0xff333333)))),
                    FittedBox(
                        child:
                            Text(calories + " Calories", style: MyStyles.bodyText)),
                  ],),
                  
                  Container(height: 5),
                  Text(mealTitle, style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                color: Color(0xff333333))),
                  Divider(color: Colors.black, thickness: 1),
                  Text(ingredient1, style: MyStyles.bodyText),
                  Text(ingredient2, style: MyStyles.bodyText),
                ],
              )
            )
         )
      ])),
    );
  }

  @override
  Widget build(BuildContext context) {
    DateTime date;

    CalendarTimeline _calendarTimeline = CalendarTimeline(
      showYears: false,
      initialDate: _selectedDate,
      firstDate: DateTime.now(),
      lastDate: DateTime.now().add(Duration(days: 365)),
      onDateSelected: (date) {
        setState(() {
          if (date != null){
            _selectedDate = date;
          }
        });
      },
      leftMargin: 20,
      monthColor: Color(0xff333333),
      dayColor: Colors.grey,
      dayNameColor: Colors.white,
      activeDayColor: Colors.white,
      activeBackgroundDayColor: MyColors.accentColor,
      dotsColor: Colors.white,
      locale: 'en',
    );


    var startDay = CurrentSession.currentProfile.mealPlanStartDay;
    List<Widget> mealCards = [];
    if (startDay != null){
      var timeSinceStart = _selectedDate.difference(startDay);
      int days = timeSinceStart.inDays;
      if (days >= 0 && days < 7){
        var mealsForDay = CurrentSession.currentProfile.resolvedMealPlan?.meals?.where((element) => element.day == days);
        var ingNeeded = CurrentSession.currentProfile.resolvedMealPlan?.ingredientsNeeded;
        if (mealsForDay != null){
          for(var meal in mealsForDay){
            String line1 ="";
            String line2 = "";
            var ings = meal.meal?.ingredients;
            if (ings != null && ingNeeded != null){
              if (ings.length == 1){
                 var ingredient1= ingNeeded.firstWhere((element) => element.id == ings[0].ingredientId);
                 line1 = ingredient1.name!;
              }
              else if (ings.length == 2){
                 var ingredient1= ingNeeded.firstWhere((element) => element.id == ings[0].ingredientId);
                 line1 = ingredient1.name!;

                 var ingredient2= ingNeeded.firstWhere((element) => element.id == ings[1].ingredientId);
                 line2 = ingredient2.name!;
              }
              else if (ings.length > 2){
                 var ingredient1= ingNeeded.firstWhere((element) => element.id == ings[0].ingredientId);
                 line1 = ingredient1.name!;

                 line2 = "...";
              }
            }


            mealCards.add(
              buildCard(hourAndMinuteToTime(meal.hour!, meal.minute!), 
                        meal.meal?.calorieCounter?.toString() ?? "Unknown", 
                        meal.meal?.name ?? "Unknown", 
                        line1,
                        line2,
                        meal.meal?.photoPath ?? "")
            );
          } 
        }
      }
      else{
        mealCards.add(Text("Sorry, this day does not fall under the current meal plan.", style: TextStyle(fontSize: 22), textAlign: TextAlign.center,));
      }
    }

    return Scaffold(
      appBar: AppBar(
        backgroundColor: MyColors.accentColor,
        title: const Text('Meal Prep\'d'),
      ),
      body: Column(
        children: [
          Container(height: 15),
          _calendarTimeline,
          Container(height: 25),
          Expanded(
              child: Column(children: mealCards
              ))
        ],
      ),
    );
  }
}
