import 'package:foodplanapp/CurrentSession.dart';
import 'package:foodplanapp/DayControl.dart';
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

  @override
  Widget build(BuildContext context) {
    final DateFormat formatter = DateFormat('MMMM d');
    final String selectedDateStr = formatter.format(this.widget.trackedDay);

    var profile = CurrentSession.currentProfile;

    Color goodDayColor;
    if (profile.goodDays.any((element) =>
        element.day == this.widget.trackedDay.day &&
        element.month == this.widget.trackedDay.month)) {
      goodDayColor = Colors.green;
    } else {
      goodDayColor = Colors.grey[800]!;
    }

    Color badDayColor;
    if (profile.badDays.any((element) =>
        element.day == this.widget.trackedDay.day &&
        element.month == this.widget.trackedDay.month)) {
      badDayColor = Colors.red;
    } else {
      badDayColor = Colors.grey[800]!;
    }
    double width = MediaQuery.of(context).size.width;

    Widget dayTracker = Container();
    var now = DateTime.now();
    if (this.widget.trackedDay.isBefore(DateTime(now.year, now.month, now.day, 23, 59))){
      dayTracker =Container(
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
        ));
    }

    return Scaffold(
      appBar: AppBar(
        backgroundColor: MyColors.accentColor,
        title: Text(selectedDateStr),
      ),
      body: Column(children: [
        Container(
          margin: EdgeInsets.fromLTRB(0, 20, 0, 10),
          alignment: Alignment.center,
          child: Text(
            selectedDateStr + " Meal Plan",
            style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
          ),
        ),
        Expanded(
            child: DayControl(this.widget.trackedDay)
        ),
        dayTracker
      ]),
    );
  }
}
