import 'package:flutter/material.dart';
import 'package:foodplanapp/MyColors.dart';

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

  Widget featuredMealCard(String mealTitle) {
    return Card(
        margin: EdgeInsets.fromLTRB(20, 5, 0, 5),
        color: MyColors.cardColor,
        child: Container(
            child: Column(
          children: [
            Container(
              height: 167,
              width: 167,
              child: FittedBox(
                  fit: BoxFit.cover,
                  clipBehavior: Clip.hardEdge,
                  child: Image.asset("images/backgroundImage.png")),
            ),
            Container(
                margin: EdgeInsets.all(10),
                child: Text(mealTitle,
                    style:
                        TextStyle(fontWeight: FontWeight.bold, fontSize: 16)))
          ],
        )));
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: MyColors.accentColor,
          title: const Text('Recipes'),
        ),
        body: SingleChildScrollView(
          child: Column(children: [
            Container(
              margin: EdgeInsets.only(top: 15),
              child: Wrap(
                spacing: 8,
                children: [
                  buildChip("Vegan", Color(0xfff2b100)),
                  buildChip("Vegetarian", Color(0xfff2b100)),
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
                margin: EdgeInsets.only(top: 15),
                child: Text('Featured', style: MyStyles.h1Text)),
            Container(
              alignment: Alignment.center,
              child: Row(
                children: [
                  featuredMealCard("Sandwich"),
                  featuredMealCard("Steaks")
                ],
              ),
            ),
            Container(
                margin: EdgeInsets.only(top: 15),
                child: Text('Recipes', style: MyStyles.h1Text)),
            Container(
                child: Column(children: [
              mealCard("Breakfast", "422", "Frosted Flakes", "1 cup whole milk",
                  "1 cup frosted flakes"),
              mealCard(
                  "Lunch", "360", "Sandwich", "2 slices bread", "1 cup cheese"),
              mealCard("Dinner", "500", "Steaks", "1 cup steak", "5 lb potato"),
            ]))
          ]),
        ));
  }
}
