import 'package:flutter/material.dart';
import 'package:foodplanapp/MyColors.dart';

class RecipesPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _RecipesPageState();
  }
}

class _RecipesPageState extends State<RecipesPage> {
  Widget featuredMealCard(String mealTitle) {
    return Card(
        child: Container(
            child: Column(
      children: [
        Container(
          height: 100,
          width: 100,
          child: FittedBox(
              fit: BoxFit.cover,
              clipBehavior: Clip.hardEdge,
              child: Image.asset("images/backgroundImage.png")),
        ),
        Container(margin: EdgeInsets.all(10), child: Text(mealTitle))
      ],
    )));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: MyColors.accentColor,
          title: const Text('Recipes'),
         automaticallyImplyLeading: false,
        ),
        body: SingleChildScrollView(
          child: Column(children: [
            Container(
                margin: EdgeInsets.only(top: 15),
                child: Text('Featured', style: MyStyles.h1Text)),
            Row(
              children: [
                featuredMealCard("Sandwich"),
                featuredMealCard("Steaks")
              ],
            ),
            Container(
                margin: EdgeInsets.only(top: 15),
                child: Text('Recipes', style: MyStyles.h1Text))
          ]),
        ));
  }
}
