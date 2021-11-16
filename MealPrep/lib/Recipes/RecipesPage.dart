import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:foodplanapp/APIInterface.dart';
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
        labelPadding: EdgeInsets.fromLTRB(13, 3, 13, 3),
        label: Text(title),
        labelStyle: TextStyle(
          fontWeight: FontWeight.bold,
          color: Colors.white,
        ),
        backgroundColor: backgroundColor);
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

  Widget mealCard(String title, String calories, String mealTitle,
      String ingredient1, String ingredient2) {
    return 
      Container(
        margin: EdgeInsets.only(bottom: 18),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10), color: MyColors.lightGrey),
        child: Container(
            child: Row(children: [
          Container(
              height: 125,
              width: 125,
              child: ClipRRect(
                borderRadius: BorderRadius.horizontal(left: Radius.circular(10)),
                child: FittedBox(
                  fit: BoxFit.cover,
                  clipBehavior: Clip.hardEdge,
                  child: Image.asset("images/backgroundImage.png"),
                ),
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
    Navigator.of(context).push(MaterialPageRoute(builder: (context)=> RecipeNew(meal: meal)));    
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
        titleSpacing: 25,
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
      body: Container(
        margin: EdgeInsets.only(left: 25),
        child: ListView(
          physics: BouncingScrollPhysics(),
          children: <Widget>[
            Container(
              margin: EdgeInsets.only(top: 25, right: 25, bottom: 20),
              height: 39,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: MyColors.lightGrey,
              ),
              child: Stack(children: [
                Positioned(
                    left: 10,
                    top: 0,
                    bottom: 0,
                    child: Icon(
                      Icons.search,
                      color: MyColors.grey,
                    )),
                TextField(
                    style: MyStyles.bodyText,
                    decoration: InputDecoration(
                      contentPadding:
                          EdgeInsets.only(left: 40, right: 15, bottom: 8),
                      border: InputBorder.none,
                      hintText: "Search recipe",
                    )),
              ]),
            ),
            Container(
              margin: EdgeInsets.only(right: 25),
              alignment: Alignment.bottomLeft,
              child: Wrap(
                spacing: 8,
                children: [
                  buildChip("My Recipes", Colors.blueGrey),
                  buildChip("Vegan", MyColors.yellow),
                  buildChip("Keto", MyColors.yellow),
                  buildChip("Dairy-Free", MyColors.yellow),
                  buildChip("Glucose-Free", MyColors.yellow),
                  buildChip("Asian", MyColors.green),
                  buildChip("American", MyColors.green),
                  buildChip("Mexican", MyColors.green),
                ],
              ),
            ),
            Container(
                margin: EdgeInsets.only(top: 20),
                alignment: Alignment.bottomLeft,
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
                margin: EdgeInsets.only(top: 20),
                alignment: Alignment.bottomLeft,
                child: Text('Recent', style: MyStyles.h1Text)),
            Container(
              margin: EdgeInsets.only(right: 25),
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
