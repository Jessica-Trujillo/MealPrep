import 'package:foodplanapp/CurrentSession.dart';
import 'package:intl/intl.dart';
import 'package:flutter/material.dart';
import 'package:foodplanapp/MyColors.dart';

class CalendarDayPage extends StatefulWidget {
  final DateTime trackedDay;
  CalendarDayPage({required this.trackedDay});

  @override
  State<StatefulWidget> createState() {
    return _CalendarDayPageState();
  }
}

class _CalendarDayPageState extends State<CalendarDayPage> {
  void toggleGoodDay() {
    setState(() {
      var profile = CurrentSession.currentProfile;
      // Current day is not a good day
      if (!profile.goodDays.any((element) =>
          element.day == widget.trackedDay.day &&
          element.month == widget.trackedDay.month)) {
        profile.goodDays.add(widget.trackedDay);
      } else {
        profile.goodDays.removeWhere((element) =>
            element.day == widget.trackedDay.day &&
            element.month == widget.trackedDay.month);
      }

      profile.badDays.removeWhere((element) =>
          element.day == widget.trackedDay.day &&
          element.month == widget.trackedDay.month);
      profile.save();
    });
  }

  void toggleBadDay() {
    setState(() {
      var profile = CurrentSession.currentProfile;
      if (!profile.badDays.any((element) =>
          element.day == widget.trackedDay.day &&
          element.month == widget.trackedDay.month)) {
        profile.badDays.add(widget.trackedDay);
      } else {
        profile.badDays.removeWhere((element) =>
            element.day == widget.trackedDay.day &&
            element.month == widget.trackedDay.month);
      }
      profile.goodDays.removeWhere((element) =>
          element.day == widget.trackedDay.day &&
          element.month == widget.trackedDay.month);
      profile.save();
    });
  }

  Widget buildCard(String title, String calories, String mealTitle,
      String ingredient1, String ingredient2) {
    return Container(
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10), color: MyColors.lightGrey),
      margin: EdgeInsets.fromLTRB(20, 5, 20, 5),
      child: Container(
          child: Row(children: [
        Container(
            height: 150,
            width: 150,
            child: ClipRRect(
              borderRadius: BorderRadius.horizontal(left: Radius.circular(10)),
              child: FittedBox(
                fit: BoxFit.cover,
                clipBehavior: Clip.hardEdge,
                child: Image.asset("images/backgroundImage.png"),
              ),
            )),
        Expanded(
            child: Container(
          margin: EdgeInsets.fromLTRB(15, 10, 0, 10),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              FittedBox(
                child: Text(
                  title,
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Color(
                      0xff333333,
                    ),
                  ),
                ),
              ),
              Container(
                  child: Text(
                calories + " Calories",
                style: MyStyles.bodyText,
                overflow: TextOverflow.ellipsis,
              )),
              Container(
                child: Text(
                  mealTitle,
                  overflow: TextOverflow.ellipsis,
                  style: MyStyles.bodyText,
                ),
              ),
              Container(
                  margin: EdgeInsets.only(right: 10),
                  child: Divider(color: Colors.grey, thickness: 1)),
              Text(
                ingredient1,
                style: MyStyles.bodyText,
                overflow: TextOverflow.ellipsis,
              ),
              Text(
                ingredient2,
                style: MyStyles.bodyText,
                overflow: TextOverflow.ellipsis,
              )
            ],
          ),
        )),
      ])),
    );
  }

  @override
  Widget build(BuildContext context) {
    final DateFormat formatter = DateFormat('MMMM d');
    final String selectedDateStr = formatter.format(this.widget.trackedDay);

    var profile = CurrentSession.currentProfile;

    Color goodDayColor;
    if (profile.goodDays.any((element) =>
        element.day == this.widget.trackedDay.day &&
        element.month == this.widget.trackedDay.month)) {
      goodDayColor = MyColors.green;
    } else {
      goodDayColor = Colors.grey[800]!;
    }

    Color badDayColor;
    if (profile.badDays.any((element) =>
        element.day == this.widget.trackedDay.day &&
        element.month == this.widget.trackedDay.month)) {
      badDayColor = MyColors.accentColor;
    } else {
      badDayColor = Colors.grey[800]!;
    }
    double width = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: AppBar(
        titleSpacing: 25,
        backgroundColor: MyColors.accentColor,
        title: Text(selectedDateStr),
      ),
      body: Column(children: [
        Container(
          margin: EdgeInsets.fromLTRB(25, 25, 25, 10),
          alignment: Alignment.centerLeft,
          child: Text(
            selectedDateStr + " Meal Plan",
            style: MyStyles.h1Text,
          ),
        ),
        Expanded(
            child: ListView(physics: BouncingScrollPhysics(), children: [
          buildCard("Breakfast", "422", "Bowl of Frosted Flakes Cereal",
              "1 cup whole milk", "1 cup frosted flakes"),
          buildCard(
              "Lunch", "360", "Sandwich", "2 slices bread", "1 cup cheese"),
          buildCard("Dinner", "500", "Steaks", "1 cup steak", "5 lb potato"),
        ])),
        Container(
            margin: EdgeInsets.symmetric(vertical: 25),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Center(
                    child: ElevatedButton(
                        onPressed: toggleBadDay,
                        child: Text("Mark as bad day :("),
                        style: ElevatedButton.styleFrom(
                          primary: badDayColor,
                        ))),
                Center(
                    child: ElevatedButton(
                        onPressed: toggleGoodDay,
                        child: Text("Mark as good day!"),
                        style: ElevatedButton.styleFrom(
                          primary: goodDayColor,
                        ))),
              ],
            ))
      ]),
    );
  }
}
