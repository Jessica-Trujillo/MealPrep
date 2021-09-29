import 'dart:html';

import 'package:flutter/material.dart';
import 'package:flutter_calendar_carousel/flutter_calendar_carousel.dart'
  show CalendarCarousel;
import 'package:flutter_calendar_carousel/classes/event.dart';
import 'package:flutter_calendar_carousel/classes/event_list.dart';
import 'package:foodplanapp/MyColors.dart';

class CalendarPage extends StatefulWidget{

  @override
  State<StatefulWidget> createState() {
    return _CalendarPageState();
  }

}

class _CalendarPageState extends State<CalendarPage>{



  static Widget _iconDisplayed(String day) => Container(
    decoration: BoxDecoration(
      color: Colors.green,
      borderRadius: BorderRadius.all(
        Radius.circular(1000),
      ),
    ),
    child: Center(
      child: Text(
        day,
        style: TextStyle(
          color: Colors.black,
        ),
      ),
    ),
  );

  EventList<Event> _markedDate = new EventList<Event>(
    events: {},
  );

  @override
  Widget build(BuildContext context) {
    for(int i =0; i < 30; i++){
      _markedDate.add(
        goodDays[i], 
        new Event(
          date: goodDays[i],
          title: 'Event 1',
          icon: Icons.sentiment_satisfied_outlined(
            goodDays[i].day.toString(),
          ),
        ),
      );

      for (int i = 0; i < 30; i ++) {
        _markedDate.add(
          badDays[i],
          new Event(
            date: badDays[i],
            title: 'Event 2',
            icon: Icons.sentiment_very_dissatisfied(
              badDays[i].day.toString(),
            ),
          ),
        );
      }
    }

    return Scaffold(
      appBar: AppBar(backgroundColor: MyColors.accentColor,
        title: const Text('Calendar'),
      ),
      body: Center(child: Text('Body'),)
    );
  }
 }