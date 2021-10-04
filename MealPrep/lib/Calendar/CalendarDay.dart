import 'package:foodplanapp/CurrentSession.dart';
import 'package:intl/intl.dart';
import 'package:flutter/material.dart';
import 'package:foodplanapp/MyColors.dart';

class CalendarDayPage extends StatefulWidget{
  final DateTime trackedDay;
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
    final String selectedDateStr = formatter.format(this.widget.trackedDay);

    return Scaffold(
      appBar: AppBar(backgroundColor: MyColors.accentColor,
        title: Text(selectedDateStr),
      ),
      body: Column(children: [
        Text("Date"),
        Center(child: 
          ElevatedButton(onPressed: (){
            var profile = CurrentSession.currentProfile;
            if (!profile.goodDays.any((element) => element.day == widget.trackedDay.day && element.month == widget.trackedDay.month)){
              profile.goodDays.add(widget.trackedDay);
            }
            profile.badDays.removeWhere((element) => element.day == widget.trackedDay.day && element.month == widget.trackedDay.month);
            profile.save();
          }, child: Text("Mark as good day!"))
        ),
        Center(child: 
          ElevatedButton(onPressed: (){
            var profile = CurrentSession.currentProfile;
            if (!profile.badDays.any((element) => element.day == widget.trackedDay.day && element.month == widget.trackedDay.month)){
            profile.badDays.add(widget.trackedDay);
            }
            profile.goodDays.removeWhere((element) => element.day == widget.trackedDay.day && element.month == widget.trackedDay.month);
            profile.save();
          }, child: Text("Mark as bad day :(")),
        ),
        Center(child: 
          ElevatedButton(onPressed: (){
            var profile = CurrentSession.currentProfile;
            profile.badDays.removeWhere((element) => element.day == widget.trackedDay.day && element.month == widget.trackedDay.month);
            profile.goodDays.removeWhere((element) => element.day == widget.trackedDay.day && element.month == widget.trackedDay.month);
            profile.save();
          }, child: Text("Clear day")),
        ),
      ]), 
    );
  }

}
