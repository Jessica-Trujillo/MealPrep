import 'package:flutter/material.dart';
import 'package:foodplanapp/APIInterface.dart';
import 'package:foodplanapp/MealCard.dart';
import 'package:foodplanapp/MyColors.dart';
import 'package:foodplanapp/Recipes/AddRecipe.dart';
import 'package:foodplanapp/Recipes/Recipe.dart';
import 'package:foodplanapp/main.dart';

class RecipesPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _RecipesPageState();
  }
}

class _RecipesPageState extends State<RecipesPage> {
  Widget buildChip(String title, Color backgroundColor) {
    return Chip(
        labelPadding: EdgeInsets.all(4),
        label: Text(title),
        labelStyle: TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
        backgroundColor: backgroundColor);
  }

  Widget mealCard(String title, String calories, String mealTitle,
      String ingredient1, String ingredient2) {
    return Card(
      margin: EdgeInsets.fromLTRB(20, 5, 20, 5),
      color: MyColors.cardColor,
      child: Container(
          child: Row(children: [
        Container(
            height: 125,
            width: 125,
            child: FittedBox(
              fit: BoxFit.cover,
              clipBehavior: Clip.hardEdge,
              child: Image.asset("images/backgroundImage.png"),
            )),
        Container(
            margin: EdgeInsets.fromLTRB(15, 0, 0, 0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                FittedBox(
                    child: Text(mealTitle,
                        style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: Color(0xff333333)))),
                FittedBox(
                    child:
                        Text(calories + " Calories", style: MyStyles.bodyText)),
                Divider(color: Colors.black, thickness: 3),
                Text(ingredient1, style: MyStyles.bodyText),
                Text(ingredient2, style: MyStyles.bodyText)
              ],
            ))
      ])),
    );
  }

  static List<Meal>? featuredMeals;

  void initAsync() async {
    if (featuredMeals == null){
      var foundMeals = await APIInterface.getFeaturedMeals();
      setState(() {
        featuredMeals = foundMeals;
      });
    }
  }

  @override
  void initState(){
    initAsync();
    super.initState();
  }

  String upperCaseFirstLetter(String str){
    String rtn = "";

    for(int i = 0; i < str.length; i++) {
      if (i == 0){
        rtn += str[i].toUpperCase();
        continue;
      }
      if(str[i - 1] == " "){
        rtn += str[i].toUpperCase();
        continue;
      }
      rtn += str[i];
    }
    return rtn;
  }

  void cardTapped(Meal meal){
    Navigator.of(context).push(MaterialPageRoute(builder: (context)=> Recipe(meal: meal)));    
  }

  @override
  Widget build(BuildContext context) {


    List<Widget> featuredMealCards= [];
    if (featuredMeals != null){
      for (var meal in featuredMeals!){
        featuredMealCards.add(
        GestureDetector(onTap: (){
        cardTapped(meal);
      },
      child:
          Column(children: [
            Container(margin: EdgeInsets.all(10), height: 150, width: 150, 
              child: FittedBox(
                fit: BoxFit.cover,
                clipBehavior: Clip.hardEdge,
                child:  
                  Expanded(child: 
                    meal.photoPath == null ? Image.asset("images/spices.jpg") : Image.network(meal.photoPath!),               
                  ),
              ), 
            ),
            Text(meal.name == null ? "Unknown" : upperCaseFirstLetter(meal.name!), style: TextStyle(fontWeight: FontWeight.bold),)
          ])
        )
        );
      }
    }

    return Scaffold(
      appBar: AppBar(
        backgroundColor: MyColors.accentColor,
        title: const Text('Recipes'),
      ),
      floatingActionButton: FloatingActionButton(
          onPressed: () {
            var page = AddRecipe();
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => page),
            ).then((value) => setState(() {}));
          },
          child: const Icon(Icons.add),
          backgroundColor: MyColors.accentColor),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              margin: EdgeInsets.fromLTRB(20, 15, 20, 0),
              child: Wrap(
                spacing: 8,
                children: [
                  buildChip("My Recipes", Colors.blueGrey),
                  buildChip("Vegan", Color(0xfff2b100)),
                  buildChip("Keto", Color(0xfff2b100)),
                  buildChip("Dairy-Free", Color(0xfff2b100)),
                  buildChip("Glucose-Free", Color(0xfff2b100)),
                  buildChip("Asian", Colors.green),
                  buildChip("American", Colors.green),
                  buildChip("Mexican", Colors.green),
                ],
              ),
            ),
            Container(
                alignment: Alignment.bottomLeft,
                margin: EdgeInsets.fromLTRB(25, 15, 0, 0),
                child: Text('Featured', style: MyStyles.h1Text)),
            Container(
              alignment: Alignment.center,
              child:
              SingleChildScrollView(scrollDirection: Axis.horizontal, child: 
                Row(
                  children: featuredMealCards,
                ),
              )
            ),
            Container(
                alignment: Alignment.bottomLeft,
                margin: EdgeInsets.fromLTRB(25, 15, 0, 0),
                child: Text('Recipes', style: MyStyles.h1Text)),
            Container(
              child: Column(
                children: [
                  mealCard("Breakfast", "422", "Frosted Flakes",
                      "1 cup whole milk", "1 cup frosted flakes"),
                  mealCard("Lunch", "360", "Sandwich", "2 slices bread",
                      "1 cup cheese"),
                  mealCard(
                      "Dinner", "500", "Steaks", "1 cup steak", "5 lb potato"),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
