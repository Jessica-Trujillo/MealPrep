import 'package:flutter/material.dart';
import 'package:foodplanapp/MyColors.dart';
import 'package:foodplanapp/Recipes/AddRecipe.dart';
import 'package:foodplanapp/Recipes/Recipe.dart';

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

  Widget featuredMealCard(String mealTitle) {
    return Container(
      margin: EdgeInsets.only(right: 15),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10), color: MyColors.lightGrey),
      child: new InkWell(
        onTap: () {
          var page = Recipe(recipeTitle: "Classic Hamburger");
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => page),
          ).then((value) => setState(() {}));
        },
        child: Container(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                height: 160,
                width: 160,
                child: ClipRRect(
                  borderRadius: BorderRadius.vertical(top: Radius.circular(10)),
                  child: FittedBox(
                    fit: BoxFit.cover,
                    clipBehavior: Clip.hardEdge,
                    child: Image.asset("images/backgroundImage.png"),
                  ),
                ),
              ),
              Container(
                width: 145,
                margin: EdgeInsets.only(left: 10, right: 5, top: 10),
                child: Text(
                  mealTitle,
                  textAlign: TextAlign.left,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget mealCard(String title, String calories, String mealTitle,
      String ingredient1, String ingredient2) {
    return Container(
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
  Widget build(BuildContext context) {
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
              height: 240,
              child: ListView(
                physics: BouncingScrollPhysics(),
                padding: EdgeInsets.only(right: 8),
                scrollDirection: Axis.horizontal,
                children: <Widget>[
                  featuredMealCard("Classic Hamburger With Caesar Salad"),
                  featuredMealCard("Steaks"),
                  featuredMealCard("Steaks"),
                  featuredMealCard("Steaks"),
                ],
              ),
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
