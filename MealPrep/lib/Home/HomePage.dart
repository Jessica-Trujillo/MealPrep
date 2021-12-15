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

  String hourAndMinuteToTime(int hour, int minute) {
    String minutePart = minute.toString();
    if (minutePart.length == 1) minutePart = "0" + minutePart;

    if (hour > 12) {
      return (hour - 12).toString() + ":" + minutePart + " PM";
    }
    return hour.toString() + ":" + minutePart + " AM";
  }

// TODO: MealPhotoPath
// Pass meal image path as parameter into method
  Widget buildCard(String title, String calories, String mealTitle,
      String ingredient1, String ingredient2) {
    return Container(
      margin: EdgeInsets.fromLTRB(20, 5, 20, 5),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10), color: MyColors.lightGrey),
      child: Container(
          child: Row(children: [
        Container(
            height: 125,
            width: 125,
            child: ClipRRect(
              borderRadius: BorderRadius.horizontal(left: Radius.circular(10)),
              child: FittedBox(
                fit: BoxFit.cover,
                clipBehavior: Clip.hardEdge,
                child: Image.asset("images/backgroundImage.png"),
                // TODO: MealPhotoPath
                // Replace Image.asset with image from url;  Image.asset reads from your asset folder, you will need to reserach how to do this from url
                // the url will be the parameter passed into method
              ),
            )),
        Expanded(
            child: Container(
                margin: EdgeInsets.fromLTRB(15, 10, 0, 10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    FittedBox(
                        child: Text(title,
                            style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                color: Color(0xff333333)))),
                    FittedBox(
                        child: Text(calories + " Calories",
                            style: MyStyles.bodyText)),
                    Text(mealTitle, style: MyStyles.bodyText),
                    Container(
                        margin: EdgeInsets.only(right: 10),
                        child: Divider(color: Colors.black, thickness: 1)),
                    Text(ingredient1, style: MyStyles.bodyText),
                    Text(ingredient2, style: MyStyles.bodyText),
                  ],
                )))
      ])),
    );
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
