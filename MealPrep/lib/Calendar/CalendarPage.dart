import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:foodplanapp/Calendar/CalendarDay.dart';
import 'package:foodplanapp/DataModel/TrackedDay.dart';
import 'package:foodplanapp/MyColors.dart';
import 'dart:math';

import 'package:flutter_calendar_carousel/flutter_calendar_carousel.dart'
    show CalendarCarousel;
import 'package:flutter_calendar_carousel/classes/event.dart';
import 'package:flutter_calendar_carousel/classes/event_list.dart';

class CalendarPage extends StatefulWidget{

  @override
  State<StatefulWidget> createState() {
    return _CalendarPageState();
  }

}

List<DateTime> goodDays = [
  DateTime(2021, 9, 1),
  DateTime(2021, 9, 2),
  DateTime(2021, 9, 3),
  DateTime(2021, 9, 10),
  DateTime(2021, 9, 11),
  DateTime(2021, 9, 12),
  DateTime(2021, 9, 13),
  DateTime(2021, 9, 20),
  DateTime(2021, 9, 21),
];

List<DateTime> badDays = [
  DateTime(2021, 9, 4),
  DateTime(2021, 9, 5),
  DateTime(2021, 9, 6),
  DateTime(2021, 9, 7),
  DateTime(2021, 9, 8),
  DateTime(2021, 9, 9),
  DateTime(2021, 9, 14),
  DateTime(2021, 9, 15),
  DateTime(2021, 9, 16),
];


class _CalendarPageState extends State<CalendarPage>{

  Widget buildGoodDayWidget(DateTime date) { 
    
    return GestureDetector(onTap: (){ 
      var trackedDay = TrackedDay(date);
      var page = CalendarDayPage(trackedDay: trackedDay);
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => page),
      );
    },
      child: 
      CircleAvatar(
        backgroundColor: Colors.white,
        child: 
        Stack(children: [ 
          Container(alignment: Alignment.topRight,
            child: Icon(Icons.star, color: Colors.yellow[700], size: 12,)
            ),
          
          
          Center(
          child: Text(
            date.day.toString(),
            style: TextStyle(
              color: Colors.black,
            ),
          ),
        )
        ]),
      )
    );
  }

  Widget buildBadDayWidget(String day) => CircleAvatar(
    backgroundColor: Colors.red,
    child: Center(
      child: Text(
        day,
        style: TextStyle(
          color: Colors.black,
        ),
      ),
    ),
  );

  var len = min(badDays.length, goodDays.length);
  double calendarHeight = 0;

  var _calandarEvents = new EventList<Event>(
    events: {},
  );

  
  @override 
  void initState() { 
    var testDoc = Map<String,dynamic>();
    testDoc.addEntries([ MapEntry("SomeKey", "SomeValue")]);

    var newDoc = FirebaseFirestore.instance
    .collection('testCollection').doc();
    newDoc.set({"A":"B"});

    for(int i =0; i < goodDays.length; i++){
      _calandarEvents.add(
        goodDays[i], 
        new Event(
          date: goodDays[i],
          icon: buildGoodDayWidget(
            goodDays[i]
          ),
        ),
      );
    }

    for (int i = 0; i < badDays.length; i ++) {
      _calandarEvents.add(
        badDays[i],
        new Event(
          date: badDays[i],
          icon: buildBadDayWidget(
            badDays[i].day.toString(),
          ),
        ),
      );
    }

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    calendarHeight = MediaQuery.of(context).size.height;
  
    CalendarCarousel _calendarCarouselNoHeader = CalendarCarousel<Event>(
      height: calendarHeight * 0.54,
      weekendTextStyle: TextStyle(
        color: Colors.red,
      ),
      todayButtonColor: Colors.blue[200]!,
      markedDatesMap: _calandarEvents,
      markedDateShowIcon: true,
      markedDateIconMaxShown: 1,
      markedDateMoreShowTotal: null,
      markedDateIconBuilder: (event) {
        return event.icon;
      }
    );

    return Scaffold(
      appBar: AppBar(backgroundColor: MyColors.accentColor,
        title: const Text('Calendar'),
      ),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            _calendarCarouselNoHeader,
            markerRepresent(Colors.red, "Bad Day"),
            markerRepresent(Colors.teal[300]!, "Good Day"),
          ],
        ),
      ),
    );
  }

  Widget markerRepresent(Color color, String data) {
    return new ListTile(
      leading: new CircleAvatar(
        backgroundColor: color,
        radius: calendarHeight * .022,
        ),
        title: new Text(
          data,
          ),
        );
    }
  }