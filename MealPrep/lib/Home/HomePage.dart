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
    _selectedDate = DateTime.now().add(Duration(days: 5));
  }

  @override
  Widget build(BuildContext context) {
    DateTime date;

    CalendarTimeline _calendarTimeline = CalendarTimeline(
      showYears: true,
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
        });
      },
      leftMargin: 20,
      monthColor: Colors.black,
      dayColor: Colors.grey,
      dayNameColor: Color(0xFF333A47),
      activeDayColor: Colors.white,
      activeBackgroundDayColor: MyColors.accentColor,
      dotsColor: Color(0xFF333A47),
      selectableDayPredicate: (date) => date.day != 23,
      locale: 'en',
    );

    return Scaffold(
      appBar: AppBar(
        backgroundColor: MyColors.accentColor,
        title: const Text('Home'),
      ),
      body: Column(
        children: <Widget>[
          Text('Weekly Overview'),
          _calendarTimeline,
          Text('Meals for Today')
        ],
      ),
    );
  }
}
