import 'package:flutter/material.dart';
import 'package:foodplanapp/CurrentSession.dart';
import 'package:foodplanapp/DayControl.dart';
import 'package:foodplanapp/MyColors.dart';
import 'package:calendar_timeline/calendar_timeline.dart';
import 'package:foodplanapp/Calendar/CalendarDay.dart';
import 'package:foodplanapp/DataModel/TrackedDay.dart';
import 'package:foodplanapp/Recipes/Recipe.dart';
import 'package:foodplanapp/Recipes/RecipesPage.dart';
import 'package:foodplanapp/main.dart';

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

  @override
  Widget build(BuildContext context) {
 
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


    return Scaffold(
      appBar: AppBar(
        backgroundColor: MyColors.accentColor,
        title: const Text('Meal Prep\'d'),
      ),
      body: Column(
        children: [
          
          Container(margin: EdgeInsets.all(10),
            child: Text("Daily calorie goal: " + CurrentSession.currentProfile.getCalorieGoal().toString(), style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),),
          ),
          _calendarTimeline,
          Container(height: 25),
          Expanded(
            child: DayControl(_selectedDate) 
          )
        ],
      ),
    );
  }
}
