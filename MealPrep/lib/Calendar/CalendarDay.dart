import 'package:intl/intl.dart';
import 'package:flutter/material.dart';
import 'package:foodplanapp/DataModel/TrackedDay.dart';
import 'package:foodplanapp/MyColors.dart';

class CalendarDayPage extends StatefulWidget{
  final TrackedDay trackedDay;
  CalendarDayPage({required this.trackedDay});

  @override
  State<StatefulWidget> createState() {
    return _CalendarDayPageState();
  }

}



class _CalendarDayPageState extends State<CalendarDayPage>{


  @override
  Widget build(BuildContext context) {
    final DateFormat formatter = DateFormat('MMMM d');
    final String selectedDateStr = formatter.format(this.widget.trackedDay.date);

    return Scaffold(
      appBar: AppBar(backgroundColor: MyColors.accentColor,
        title: Text(selectedDateStr),
      ),
      body: Column(children: [
        Text("Date")
      ]), 
    );
  }

}
