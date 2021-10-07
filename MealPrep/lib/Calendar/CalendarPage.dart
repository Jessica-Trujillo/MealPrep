import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:foodplanapp/Calendar/CalendarDay.dart';
import 'package:foodplanapp/CurrentSession.dart';
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

class _CalendarPageState extends State<CalendarPage>{

  
  @override 
  void initState() { 
    var testDoc = Map<String,dynamic>();
    testDoc.addEntries([ MapEntry("SomeKey", "SomeValue")]);

    var newDoc = FirebaseFirestore.instance
    .collection('testCollection').doc();
    newDoc.set({"A":"B"});


    
    // for(int i =0; i < goodDays.length; i++){
    //   _calandarEvents.add(
    //     goodDays[i], 
    //     new Event(
    //       date: goodDays[i],
    //       icon: buildGoodDayWidget(
    //         goodDays[i]
    //       ),
    //     ),
    //   );
    // }

    // for (int i = 0; i < badDays.length; i ++) {
    //   _calandarEvents.add(
    //     badDays[i],
    //     new Event(
    //       date: badDays[i],
    //       icon: buildBadDayWidget(
    //         badDays[i].day.toString(),
    //       ),
    //     ),
    //   );
    // }

    super.initState();
  }

  Widget dayBuilder(bool bool1, int totalIndex, bool bool2, bool isCurrentDay, bool isPreviousMonth, TextStyle textStyle, bool isNextMonth, bool isCurrentMonth, DateTime date){
    Color textColor = Colors.black;


    if (isPreviousMonth || isNextMonth){
      textColor = Colors.grey;
    }

    var currentDay = DateTime.now();

    Color backgroundColor = Colors.transparent;
    if (date.compareTo(currentDay) > 0){
      backgroundColor = Colors.grey[300]!;
    }
    else{
      if (CurrentSession.currentProfile.goodDays.any((element) => element.day == date.day && element.month == date.month)){
        backgroundColor = Colors.blue[200]!;
      }
      else if (CurrentSession.currentProfile.badDays.any((element) => element.day == date.day && element.month == date.month)){
        backgroundColor = Colors.red[200]!;
      }
    }


    return GestureDetector(
      onTap: (){
        var page = CalendarDayPage(trackedDay: date);
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => page),
        ).then((value) => setState(() { }));
       },
      child: 
      Container(
        decoration: BoxDecoration(
          color: backgroundColor,
          border:  Border.all(width: 1.0, color: Colors.grey),
          borderRadius: BorderRadius.all(Radius.circular(4))
        ),
        child: Center(child: 
          Text(date.day.toString(), style: TextStyle(color: textColor))
        ),
      )
    );
    
  } 

  @override
  Widget build(BuildContext context) {
    CalendarCarousel _calendarCarouselNoHeader = CalendarCarousel<Event>(
     // height: calendarHeight * 0.54,
      weekendTextStyle: TextStyle(
        color: Colors.red,
      ),
      todayButtonColor: Colors.transparent,
      //markedDatesMap: _calandarEvents,
      customDayBuilder: dayBuilder,
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
        body: Column(
          children: <Widget>[
            Expanded(child: 
              _calendarCarouselNoHeader,
            ),
          ],
        ),
      
    );
  }
  }