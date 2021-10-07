import 'package:flutter/material.dart';
import 'package:foodplanapp/Calendar/CalendarPage.dart';
import 'package:foodplanapp/Home/HomePage.dart';
import 'package:foodplanapp/MyColors.dart';

class RootNavigationPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _RootNavigationPageState();
  }
}

class _RootNavigationPageState extends State<RootNavigationPage> {
  int _selectedIndex = 0;

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    Widget body;

    if (_selectedIndex == 0) {
      body = HomePage();
    } else if (_selectedIndex == 1) {
      body = CalendarPage();
    } else if (_selectedIndex == 2) {
      body = Scaffold(
          body: Container(alignment: Alignment.center, child: Text("Recipes")));
    } else if (_selectedIndex == 3) {
      body = Scaffold(
          body:
              Container(alignment: Alignment.center, child: Text("Settings")));
    } else {
      body = Scaffold(
          body: Container(alignment: Alignment.center, child: Text("Error")));
    }

    Color selectedIconColor = Colors.black;
    Color iconColor = Colors.white;

    return Column(children: [
      Expanded(child: body),
      BottomNavigationBar(
        backgroundColor: MyColors.accentColor,
        items: <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home_outlined,
                color: (_selectedIndex == 0 ? selectedIconColor : iconColor)),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.calendar_today_outlined,
                color: (_selectedIndex == 1 ? selectedIconColor : iconColor)),
            label: 'Calendar',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.book_outlined,
                color: (_selectedIndex == 2 ? selectedIconColor : iconColor)),
            label: 'Recipes',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.settings_outlined,
                color: (_selectedIndex == 3 ? selectedIconColor : iconColor)),
            label: 'Settings',
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.red,
        onTap: _onItemTapped,
        showSelectedLabels: false,
        showUnselectedLabels: false,
        type: BottomNavigationBarType.fixed,
      )
    ]);
  }
}
