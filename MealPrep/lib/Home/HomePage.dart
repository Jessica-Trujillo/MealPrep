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
                    Container(
                        child: Text(title,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                color: Color(0xff333333)))),
                    Container(
                        child: Text(
                      calories + " Calories",
                      style: MyStyles.bodyText,
                    )),
                    Container(
                      child: Text(
                        mealTitle,
                        style: MyStyles.bodyText,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(right: 10),
                      child: Divider(color: Colors.grey, thickness: 1),
                    ),
                    Text(
                      ingredient1,
                      style: MyStyles.bodyText,
                      overflow: TextOverflow.ellipsis,
                    ),
                    Text(
                      ingredient2,
                      style: MyStyles.bodyText,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                )))
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
          var page = CalendarDayPage(trackedDay: date!);
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => page),
          ).then((value) => setState(() {}));
          _selectedDate = date;
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

    var mealsForDay = CurrentSession.currentProfile.resolvedMealPlan?.meals
        ?.where((element) => element.day == 0);
    List<Widget> mealCards = [];
    if (mealsForDay != null) {
      for (var meal in mealsForDay) {
        mealCards.add(buildCard(
            hourAndMinuteToTime(meal.hour!, meal.minute!),
            meal.meal?.calorieCounter?.toString() ?? "Unknown",
            meal.meal?.name ?? "Unknown",
            "1 cup whole milk",
            "1 cup frosted flakes"));
      }
    }

    return Scaffold(
      appBar: AppBar(
        titleSpacing: 25,
        backgroundColor: MyColors.accentColor,
        title: const Text('Home'),
      ),
      body: Container(
        child: ListView(
          physics: BouncingScrollPhysics(),
          children: <Widget>[
            Container(
              margin: EdgeInsets.fromLTRB(25, 25, 0, 0),
              child: Text(
                'Hi ' + CurrentSession.currentProfile.username + ",",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: MyColors.grey,
                ),
              ),
            ),
            Container(
                alignment: Alignment.bottomLeft,
                margin: EdgeInsets.fromLTRB(25, 5, 0, 0),
                child: Text('Weekly Overview', style: MyStyles.h1Text)),
            _calendarTimeline,
            Container(
                alignment: Alignment.bottomLeft,
                margin: EdgeInsets.fromLTRB(25, 15, 0, 0),
                child: Text('Meals for Today', style: MyStyles.h1Text)),
            Column(children: mealCards),
          ],
        ),
      ),
    );
  }
}
