import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:flutter_html/style.dart';
import 'package:foodplanapp/CurrentSession.dart';
import 'package:foodplanapp/MyColors.dart';
import 'package:foodplanapp/main.dart';

class Recipe extends StatefulWidget {
  final Meal meal;
  Recipe({required this.meal});

  @override
  State<StatefulWidget> createState() {
    return _RecipeState();
  }
}

class _RecipeState extends State<Recipe> {

  Widget buildIngredient({String qty = "", required String ingredient}) {
    return Container(
        child: Column(
      children: [
        Row(children: [
          Expanded(
              child: Container(
            child: Text(
              ingredient,
              style: MyStyles.bodyText,
            ),
          )),
          Container(
              child: Text(qty,
                  style: TextStyle(
                    fontSize: 16,
                    color: Color(0xff333333),
                  )))
        ]),
        Divider(color: Colors.black12, thickness: 1)
      ],
    ));
  }

  int selectedindex = 0;

  Widget _indicator(bool isActive) {
    return Container(
      height: 10,
      child: AnimatedContainer(
        duration: Duration(milliseconds: 150),
        margin: EdgeInsets.symmetric(horizontal: 4.0),
        height: isActive
            ? 10:8.0,
        width: isActive
            ? 12:8.0,
        decoration: BoxDecoration(
          boxShadow: [
            isActive
                ? BoxShadow(
              color: Color(0XFF2FB7B2).withOpacity(0.72),
              blurRadius: 4.0,
              spreadRadius: 1.0,
              offset: Offset(
                0.0,
                0.0,
              ),
            )
                : BoxShadow(
              color: Colors.black,
            )
          ],
          shape: BoxShape.circle,
          color: isActive ? Color(0XFF6BC4C9) : Colors.black,
        ),
      ),
    );
  }
  
  List<Widget> _buildPageIndicator() {
    List<Widget> list = [];
    for (int i = 0; i < 3; i++) {
      list.add(i == selectedindex ? _indicator(true) : _indicator(false));
    }
    return list;
  }

  String getTimeFromMinutes(int? cookTime) {
    if (cookTime == null)
      return "Unknown";
    
    int hours = cookTime ~/ 60;
    int minutes = cookTime - (hours*60);

    String str = "";
    if (hours == 1){
      str += "1 Hour ";
    }
    else if (hours > 1){
      str += hours.toString() + " Hours ";
    }

    if (minutes == 1){
      str += "1 Minute";
    }
    else if (minutes > 1){
      str += minutes.toString() + " Minutes";
    }

    return str;
  }

  Widget buildHeader(String item1, String item2){
    return Row(
      children: [
        Container(
            width: 90,
            child: Text(
              item1 + ":",
              style: TextStyle(
                  fontSize: 16, fontWeight: FontWeight.bold),
            )),
        Text(item2,
            style: TextStyle(
                fontSize: 16, fontWeight: FontWeight.bold))
      ],
    ); 
  }

  @override
  Widget build(BuildContext context) {
    Widget image;
    var photoPath = this.widget.meal.photoPath;
    if (photoPath != null){
      image = Image.network(photoPath);
    }
    else{
      image = Image.asset("images/spices.jpg");
    }


    List<Widget> ingredientList = [];
    var ingInstances = this.widget.meal.ingredients;

    if (ingInstances != null){
      for (var ingInstance in ingInstances){
        var ing = ingInstance.ingredient!;
        ingredientList.add(buildIngredient(ingredient: ing.name ?? "Unknown", qty: ingInstance.quantity ?? "Unknown"));
      }
    }

    return Scaffold(
        appBar: AppBar(
          backgroundColor: MyColors.accentColor,
          title: Text("Recipe"),
        ),
        body: 
        Column(children: [
          Expanded(child: 
            PageView(
              onPageChanged: (int page) {
                  setState(() {
                      selectedindex = page;
                  });
              },
              children: [
              SingleChildScrollView(
                  child: Column(children: [
                AspectRatio(
                  aspectRatio: 3 / 2,
                  child: Container(
                      child: FittedBox(
                    fit: BoxFit.fitWidth,
                    clipBehavior: Clip.hardEdge,
                    child: image,
                  )),
                ),
                Container(
                  margin: EdgeInsets.fromLTRB(25, 15, 25, 15),
                  // alignment: Alignment.bottomLeft,
                  child: Column(children: [
                    Container(
                      margin: EdgeInsets.symmetric(vertical: 10),
                      alignment: Alignment.centerLeft,
                      child: Text(
                        this.widget.meal.name ?? "Unknown",
                        style: MyStyles.h1Text,
                      ),
                    ),
                    buildHeader("Servings", "1"),
                    buildHeader("Prep Time", getTimeFromMinutes(this.widget.meal.totalPrepTime)),
                    buildHeader("Cook Time", getTimeFromMinutes(this.widget.meal.totalCookTime)),
                    buildHeader("Calories", this.widget.meal.calorieCounter?.toString() ?? "Unknown"),
                    // Container(
                    //     margin: EdgeInsets.only(top: 20),
                    //     child: Text(
                    //       "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.",
                    //       style: MyStyles.bodyText,
                    //     ))
                  ]),
                )
              ])),
              SingleChildScrollView(
                child: Container(
                  alignment: Alignment.bottomLeft,
                  margin: EdgeInsets.fromLTRB(25, 15, 25, 15),
                  child: Column(
                    children: [
                      Container(
                        margin: EdgeInsets.symmetric(vertical: 10),
                        alignment: Alignment.centerLeft,
                        child: Text(
                          "Ingredients",
                          style: MyStyles.h1Text,
                        ),
                      ),
                      Column(crossAxisAlignment: CrossAxisAlignment.stretch, children: ingredientList),
                    ],
                  ),
                ),
              ),
              SingleChildScrollView(
                  child: Container(
                      alignment: Alignment.bottomLeft,
                      margin: EdgeInsets.fromLTRB(25, 15, 25, 15),
                      child: Column(
                        children: [
                          Container(
                              alignment: Alignment.centerLeft,
                              child: Text("Directions", style: MyStyles.h1Text)),
                          Container(
                              alignment: Alignment.centerLeft,
                              child: Html(
                                data: this.widget.meal.recipe ?? "Figure it out!"
                              )
                          ),

                        ],
                      )))
            ])
          ),
          Container(margin: EdgeInsets.all(20),
            child: Row(mainAxisAlignment: MainAxisAlignment.center, children: _buildPageIndicator(),),
          )
          
        ],)
        
        );
  }
}
