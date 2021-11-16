import 'package:flutter/material.dart';

import 'MyColors.dart';
import 'Recipes/Recipe.dart';
import 'main.dart';

class MealCard extends StatefulWidget{
  final Meal meal;
  final String? title;

  const MealCard({Key? key, required this.meal, this.title}) : super(key: key);


  @override
  State<StatefulWidget> createState() {
    return _MealCardState();
  }

}

class _MealCardState extends State<MealCard>{

  

  void cardTapped(Meal meal){
    Navigator.of(context).push(MaterialPageRoute(builder: (context)=> Recipe(meal: meal)));    
  }

  Widget buildCard(Meal meal, String title, String calories, String mealTitle,
      String ingredient1, String ingredient2, String imagePath) {
    return GestureDetector(onTap: (){
        cardTapped(meal);
      },
      child: Card(
        margin: EdgeInsets.fromLTRB(20, 5, 20, 5),
        color: MyColors.cardColor,
        child: Container(
            child: Row(
              
              children: [
          Container(
              height: 125,
              width: 125,
              child: FittedBox(
                fit: BoxFit.cover,
                clipBehavior: Clip.hardEdge,
                child: Image.network(imagePath), 
              )),
          Expanded(child: 
            Container(
                margin: EdgeInsets.fromLTRB(15, 10, 5, 10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
                      FittedBox(
                          child: Text(title,
                              style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                  color: Color(0xff333333)))),
                      FittedBox(
                          child:
                              Text(calories + " Calories", style: MyStyles.bodyText)),
                    ],),
                    
                    Container(height: 5),
                    Text(mealTitle, style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                  color: Color(0xff333333))),
                    Divider(color: Colors.black, thickness: 1),
                    Text(ingredient1, style: MyStyles.bodyText),
                    Text(ingredient2, style: MyStyles.bodyText),
                  ],
                )
              )
          )
        ])),
      )
    );
  }





  @override
  Widget build(BuildContext context) {
    String line1 ="";
    String line2 = "";
    var ings = this.widget.meal.ingredients;
    if (ings != null){
      if (ings.length == 1){
          line1 = ings[0].ingredient?.name ?? "";
      }
      else if (ings.length == 2){
          line1 = ings[0].ingredient?.name ?? "";

          line2 = ings[1].ingredient?.name ?? "";
      }
      else if (ings.length > 2){
          line1 = ings[0].ingredient?.name ?? "";

          line2 = "...";
      }
    }
    var meal = this.widget.meal;

    return
      buildCard(meal, this.widget.title ?? "", 
                meal.calorieCounter?.toString() ?? "Unknown", 
                meal.name ?? "Unknown", 
                line1,
                line2,
                meal.photoPath ?? "");
    
  }


}