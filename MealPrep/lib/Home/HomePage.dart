import 'package:flutter/material.dart';
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

  Widget buildCard(String title, String calories, String mealTitle,
      String ingredient1, String ingredient2) {
    return Card(
      margin: EdgeInsets.fromLTRB(20, 5, 20, 5),
      color: MyColors.cardColor,
      child: Container(
          child: Row(children: [
        Container(
            height: 125,
            width: 125,
            child: FittedBox(
              fit: BoxFit.cover,
              clipBehavior: Clip.hardEdge,
              child: Image.asset("images/backgroundImage.png"),
            )),
        Container(
            margin: EdgeInsets.fromLTRB(15, 0, 0, 0),
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
                    child:
                        Text(calories + " Calories", style: MyStyles.bodyText)),
                FittedBox(child: Text(mealTitle, style: MyStyles.bodyText)),
                Divider(color: Colors.black, thickness: 3),
                Text(ingredient1, style: MyStyles.bodyText),
                Text(ingredient2, style: MyStyles.bodyText)
              ],
            ))
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

    return Scaffold(
      appBar: AppBar(
        backgroundColor: MyColors.accentColor,
        title: const Text('Home'),
      ),
      body: Column(
        children: [
          Container(
              margin: EdgeInsets.only(top: 15),
              child: Text('Weekly Overview', style: MyStyles.h1Text)),
          _calendarTimeline,
          Container(
              margin: EdgeInsets.only(top: 15),
              child: Text('Meals for Today', style: MyStyles.h1Text)),
          Expanded(
              child: Column(children: [
            buildCard("Breakfast", "422", "Frosted Flakes", "1 cup whole milk",
                "1 cup frosted flakes"),
            buildCard(
                "Lunch", "360", "Sandwich", "2 slices bread", "1 cup cheese"),
            buildCard("Dinner", "500", "Steaks", "1 cup steak", "5 lb potato"),
          ]))
        ],
      ),
    );
  }
}
