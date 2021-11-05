import 'package:flutter/material.dart';
import 'package:foodplanapp/MyColors.dart';

class Recipe extends StatefulWidget {
  final String recipeTitle;
  Recipe({required this.recipeTitle});

  @override
  State<StatefulWidget> createState() {
    return _RecipeState();
  }
}

class _RecipeState extends State<Recipe> {
  int step = 0;

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

  Widget buildDirection(String direction) {
    step++;

    return Column(children: [
      Container(
          margin: EdgeInsets.fromLTRB(0, 5, 0, 5),
          alignment: Alignment.centerLeft,
          child: Text("Step " + step.toString(),
              style: TextStyle(
                fontSize: 16,
                color: Color(0xff333333),
                fontWeight: FontWeight.bold,
              ))),
      Container(
          margin: EdgeInsets.only(bottom: 5),
          child: Text(
            direction,
            style: MyStyles.bodyText,
          )),
      Divider(color: Colors.black12, thickness: 1)
    ]);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: MyColors.accentColor,
          title: Text("Recipe"),
        ),
        body: PageView(children: [
          SingleChildScrollView(
              child: Column(children: [
            AspectRatio(
              aspectRatio: 3 / 2,
              child: Container(
                  child: FittedBox(
                fit: BoxFit.fitWidth,
                clipBehavior: Clip.hardEdge,
                child: Image.asset("images/backgroundImage.png"),
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
                    this.widget.recipeTitle,
                    style: MyStyles.h1Text,
                  ),
                ),
                Row(
                  children: [
                    Container(
                        width: 90,
                        child: Text(
                          "Servings:",
                          style: TextStyle(
                              fontSize: 16, fontWeight: FontWeight.bold),
                        )),
                    Text("1",
                        style: TextStyle(
                            fontSize: 16, fontWeight: FontWeight.bold))
                  ],
                ),
                Row(
                  children: [
                    Container(
                        width: 90,
                        child: Text(
                          "Cook Time:",
                          style: TextStyle(
                              fontSize: 16, fontWeight: FontWeight.bold),
                        )),
                    Container(
                        child: Text("1 Hour",
                            style: TextStyle(
                                fontSize: 16, fontWeight: FontWeight.bold)))
                  ],
                ),
                Row(
                  children: [
                    Container(
                        width: 90,
                        child: Text(
                          "Calories:",
                          style: TextStyle(
                              fontSize: 16, fontWeight: FontWeight.bold),
                        )),
                    Container(
                        child: Text("600",
                            style: TextStyle(
                                fontSize: 16, fontWeight: FontWeight.bold)))
                  ],
                ),
                Container(
                    margin: EdgeInsets.only(top: 20),
                    child: Text(
                      "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.",
                      style: MyStyles.bodyText,
                    ))
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
                  buildIngredient(qty: "12 oz", ingredient: "ground beef"),
                  buildIngredient(ingredient: "kosher salt, to taste"),
                  buildIngredient(ingredient: "kosher salt, to taste"),
                  buildIngredient(ingredient: "freshly ground black pepper"),
                  buildIngredient(qty: "1 tbsp", ingredient: "vegetable oil"),
                  buildIngredient(
                      qty: "1 slices", ingredient: "cheddar cheese"),
                  buildIngredient(qty: "1", ingredient: "hamburger bun"),
                  buildIngredient(ingredient: "toppings of your choice"),
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
                      buildDirection(
                          "In a bowl, mix ground beef, egg, onion, bread crumbs, Worcestershire, garlic, 1/2 teaspoon salt, and 1/4 teaspoon pepper until well blended. Divide mixture into four equal portions and shape each into a patty about 4 inches wide."),
                      buildDirection(
                          "Lay burgers on an oiled barbecue grill over a solid bed of hot coals or high heat on a gas grill (you can hold your hand at grill level only 2 to 3 seconds); close lid on gas grill. Cook burgers, turning once, until browned on both sides and no longer pink inside (cut to test), 7 to 8 minutes total. Remove from grill."),
                      buildDirection(
                          "Lay buns, cut side down, on grill and cook until lightly toasted, 30 seconds to 1 minute."),
                      buildDirection(
                          "Spread mayonnaise and ketchup on bun bottoms. Add lettuce, tomato, burger, onion, and salt and pepper to taste. Set bun tops in place.")
                    ],
                  )))
        ]));
  }
}
