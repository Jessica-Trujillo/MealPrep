import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:foodplanapp/Calendar/CalendarPage.dart';
import 'package:foodplanapp/CurrentSession.dart';
import 'package:foodplanapp/Home/HomePage.dart';
import 'package:foodplanapp/Recipes/RecipesPage.dart';
import 'package:foodplanapp/MyColors.dart';
import 'package:foodplanapp/main.dart';
import 'package:foodplanapp/Settings/SettingsPage.dart';

import 'package:http/http.dart' as http;

class RootNavigationPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _RootNavigationPageState();
  }
}

class _RootNavigationPageState extends State<RootNavigationPage> {
  int _selectedIndex = 0;

  bool hasMealPlan = false;


  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  void initState() {
    ensureMealPlan();
    super.initState();
  }

  Future<bool> _onWillPop() async {
    return false;
  }
  void ensureMealPlan() async {
    var currentUser = CurrentSession.currentProfile;
    if (currentUser.currentMealPlanJson == null){
      var request = Request(calorieGoal: 1700, 
                          numOfDays: 7, 
                          weeklyBudget: 500, 
                          blacklist: ["C"], 
                          carbPercentage: 30, 
                          fatPercentage: 40, 
                          proteinPercentage: 30, 
                          dietaryRestrictions: ["B"], 
                          favorites: ["A"],
                          recent: ["D"]);


      //var response = await http.get(Uri.parse('https://jsonplaceholder.typicode.com/albums/1'));
      //https://localhost:44314/WeatherForecast
      var asJson1 = jsonEncode(request.toMap());
      var response = await http.post(Uri.parse('https://10.0.2.2:44314/MealPlan'),body: asJson1, headers: {"Content-Type": "application/json"} );
      currentUser.currentMealPlanJson = response.body;
      currentUser.mealPlanStartDay = DateTime.now();
      currentUser.save();
    }

    dynamic asJson = jsonDecode(currentUser.currentMealPlanJson!);
    currentUser.resolvedMealPlan = FullMealPlan.fromMap(asJson);
  }

  @override
  Widget build(BuildContext context) {
    Widget body;

    if (_selectedIndex == 0) {
      body = HomePage();
    } else if (_selectedIndex == 1) {
      body = CalendarPage();
    } else if (_selectedIndex == 2) {
      body = RecipesPage();
    } else if (_selectedIndex == 3) {
      body = SettingsPage();
    } else {
      body = Scaffold(
          body: Container(alignment: Alignment.center, child: Text("Error")));
    }

    Color selectedIconColor = MyColors.accentColor;
    Color iconColor = Colors.grey;

    return 
    // WillPopScope(
    //   onWillPop: _onWillPop,
    //   child:
      Column(children: [
      Expanded(child: body),
      Container(
          decoration: BoxDecoration(
            boxShadow: <BoxShadow>[
              BoxShadow(
                  color: Colors.grey.withOpacity(0.3),
                  blurRadius: 10.0,
                  offset: Offset(0.0, 0.75))
            ],
          ),
          child: BottomNavigationBar(
            items: <BottomNavigationBarItem>[
              BottomNavigationBarItem(
                icon: Icon(Icons.home_outlined,
                    color:
                        (_selectedIndex == 0 ? selectedIconColor : iconColor)),
                label: 'Home',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.calendar_today_outlined,
                    color:
                        (_selectedIndex == 1 ? selectedIconColor : iconColor)),
                label: 'Calendar',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.book_outlined,
                    color:
                        (_selectedIndex == 2 ? selectedIconColor : iconColor)),
                label: 'Recipes',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.settings_outlined,
                    color:
                        (_selectedIndex == 3 ? selectedIconColor : iconColor)),
                label: 'Settings',
              ),
            ],
            currentIndex: _selectedIndex,
            selectedItemColor: Colors.red,
            onTap: _onItemTapped,
            showSelectedLabels: false,
            showUnselectedLabels: false,
            type: BottomNavigationBarType.fixed,
          ))
        ]
    );//);
  }
}
