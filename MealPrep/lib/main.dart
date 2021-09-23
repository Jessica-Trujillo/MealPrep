
import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

void main() {
  HttpOverrides.global = new MyHttpOverrides();
  runApp(MyApp());
} 


 class MyHttpOverrides extends HttpOverrides{


  @override
  HttpClient createHttpClient(SecurityContext? context){
    return super.createHttpClient(context)
      ..badCertificateCallback = (X509Certificate cert, String host, int port)=> true;
  }
}

class Request
{
  Request({
     required this.calorieGoal, 
     required this.numOfDays, 
     required this.weeklyBudget,
     required this.carbPercentage, 
     required this.fatPercentage,
     required this.proteinPercentage, 
     required this.dietaryRestrictions, 
     required this.favorites, 
     required this.blacklist, 
     required this.recent
});
  int calorieGoal;
  int numOfDays;
  int weeklyBudget;
  double carbPercentage;
  double fatPercentage;
  double proteinPercentage;
  List<String> dietaryRestrictions;
  List<String> favorites;
  List<String> blacklist;
  List<String> recent;

  Map<String,dynamic> toMap(){
    return {
      "calorieGoal":calorieGoal,
      "numOfDays":numOfDays,
      "weeklyBudget":weeklyBudget,
      "carbPercentage":carbPercentage,
      "fatPercentage":fatPercentage,
      "proteinPercentage":proteinPercentage,
      "dietaryRestrictions":dietaryRestrictions,
      "favorites":favorites,
      "blacklist":blacklist,
      "recent":recent
    }; 
  }
}


  class FullMealPlan
  {
    static FullMealPlan fromMap(Map<String, dynamic> map){
      var mealPlan = FullMealPlan();

      for (var entry in map.entries){
        if (entry.key == "meals"){
          List<MealTime> meals = [];
          List<dynamic> value = entry.value;
          for (var item in value){
            if (item is Map<String, dynamic>){
              meals.add(MealTime.fromMap(item));
            }
          }
          mealPlan.Meals = meals;
        }
        else if (entry.key == "ingredientsNeeded"){
          List<Ingredient> ingredients = [];
          List<dynamic> value = entry.value;
          for (var item in value){
            if (item is Map<String, dynamic>){
              ingredients.add(Ingredient.fromMap(item));
            }
          }
          mealPlan.IngredientsNeeded = ingredients;
        }
      }

      return mealPlan;
    }

    List<MealTime>? Meals;
    List<Ingredient>? IngredientsNeeded;
  }

  class MealTime
  {
    static MealTime fromMap(Map<String, dynamic> map){
      MealTime mealTime = MealTime();
      for(var entry in map.entries) {
        if(entry.key == "meal"){
          mealTime.meal = Meal.fromMap(entry.value);
        }
        if(entry.key == "hour") {
          mealTime.Hour = int.parse(entry.value.toString());
        }
        if(entry.key == "minute"){
          mealTime.Minute = int.parse(entry.value.toString());
        }
      }
      return mealTime;
    }

    Meal? meal;
    
    int? Hour;
    int? Minute;
  }

  class Meal
  {

    
    static Meal fromMap(Map<String, dynamic> map){
      Meal meal = Meal();

      for(var entry in map.entries) {
        if(entry.key == "name"){
          meal.name = entry.value.toString();
        }
        else if (entry.key == "recipe"){
          meal.recipe = entry.value.toString();
        }
        else if (entry.key == "totalPrepTime") {
          meal.totalPrepTime = int.parse(entry.value.toString());
        }
        else if (entry.key == "totalCookTime") {
          meal.totalCookTime = int.parse(entry.value.toString());
        }
        else if (entry.key == "minutesNeededBeforeMeal") {
          meal.minutesNeededBeforeMeal = int.parse(entry.value.toString());
        }
        else if (entry.key == "ingredients") {
          List<IngredientInstance> ingredients = [];
          List<dynamic> value = entry.value;
          for (var item in value){
            if (item is Map<String, dynamic>){
              ingredients.add(IngredientInstance.fromMap(item));
            }
          }
          meal.ingredients = ingredients;
        }
        else if (entry.key == "calorieCounter") {
          meal.calorieCounter = int.parse(entry.value.toString());
        }
        else if (entry.key == "costInPennies") {
          meal.costInPennies = int.parse(entry.value.toString());
        }
        else if (entry.key == "carbPercent") {
          meal.carbPercent = double.parse(entry.value.toString());
        }
        else if (entry.key == "fatPercent") {
          meal.fatPercent = double.parse(entry.value.toString());
        }
        else if (entry.key == "proteinPercent") {
          meal.proteinPercent = double.parse(entry.value.toString());
        }
        else if (entry.key == "tags") {
          List<String> tagStr = [];
          List<dynamic> tags = entry.value;
          for (var tag in tags){
            tagStr.add(tag.toString());
          }
          meal.tags = tagStr;
        }
      }



      return meal;
    }


    String? name;
    String? recipe;
    int? totalPrepTime;
    int? totalCookTime;
    int? minutesNeededBeforeMeal;
    List<IngredientInstance>? ingredients;
    int? calorieCounter;
    int? costInPennies;
    double? carbPercent;
    double? fatPercent;
    double? proteinPercent;
    List<String>? tags;
  }

  class IngredientInstance
  {
    
    static IngredientInstance fromMap(Map<String, dynamic> map){
      IngredientInstance ing = IngredientInstance();

      for (var entry in map.entries){
        if (entry.key == "ingredientId"){
          ing.ingredientId = int.parse(entry.value.toString());
        }
        else if (entry.key == "quantity"){
          ing.Quantity = entry.value.toString();
        }
      }

      return ing;
    }
    int? ingredientId;
    String? Quantity;
  }

  class StoreIngredient
  {
    
    static StoreIngredient fromMap(Map<String, dynamic> map){
      StoreIngredient ing = StoreIngredient();

      for (var entry in map.entries){
        if (entry.key == "costInPennies"){
          ing.costInPennies = int.parse(entry.value.toString());
        }
        else if (entry.key == "quantity"){
          ing.quantity = entry.value.toString();
        }
        else if (entry.key == "storeLinks"){
          List<String> storeLinks = [];
          List<dynamic> dynStoreLinks = entry.value;
          for (var link in dynStoreLinks){
            storeLinks.add(link.toString());
          }
          ing.storeLinks = storeLinks;
        }
      }

      return ing;
    }

    int? costInPennies;
    String? quantity;
    List<String>? storeLinks;
  }

  class Ingredient
  {
    
    static Ingredient fromMap(Map<String, dynamic> map){
      Ingredient ing = Ingredient();

      for (var entry in map.entries){
        if (entry.key == "id"){
          ing.id = int.parse(entry.value.toString());
        }
        else if (entry.key == "name"){
          ing.name = entry.value.toString();
        }
        else if (entry.key == "calories"){
          ing.calories = double.parse(entry.value.toString());
        }
        else if (entry.key == "quantityForCalorie"){
          ing.quantityForCalorie = entry.value.toString();
        }
        else if (entry.key == "storeIngredients"){
          List<dynamic> list = entry.value;
          List<StoreIngredient> storeIng = [];
          for (var item in list){
            storeIng.add(StoreIngredient.fromMap(item));
          }
          ing.storeIngredients = storeIng;
        }
        else if (entry.key == "tags"){
          List<dynamic> list = entry.value;
          List<String> tags = [];
          for (var item in list){
            tags.add(item.toString());
          }
          ing.tags = tags;
        }
        else if (entry.key == "expirationTimeInDays"){
          ing.ExpirationTimeInDays = int.parse(entry.value.toString());
        }
      }

      return ing;
    }


    int? id;

    String? name;
    double? calories;
    String? quantityForCalorie;

    List<StoreIngredient>? storeIngredients;

    List<String>? tags;

    int? ExpirationTimeInDays;
  }

class MyApp extends StatelessWidget {

  TextEditingController controller = TextEditingController();

  void testAPIClicked() async {
    var request = Request(calorieGoal: 1700, 
                          numOfDays: 10, 
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

    dynamic asJson = jsonDecode(response.body);
    FullMealPlan mealPlan = FullMealPlan.fromMap(asJson);

    controller.text = asJson.toString();
  }


  @override
  Widget build(BuildContext context) {
     
    return MaterialApp(
      title: 'Mobile Food APP API TEST',
      home: Scaffold (
        appBar: AppBar(
          title: const Text('API TEST'),
        ),
        body: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
          Container(margin: EdgeInsets.fromLTRB(0, 20, 0, 0), child: 
            Container(width: 150, height: 40, child:
              ElevatedButton(onPressed: testAPIClicked, child: Text("Test API", style: TextStyle(color: Colors.white, fontSize: 20),)),
            )
          ),
          Expanded(child:
            Container(margin: EdgeInsets.all(20), color: Colors.grey[200],
              child: 
                TextField(controller: controller, expands: true, minLines: null, maxLines: null, style: TextStyle(fontSize: 16, color: Colors.black), decoration: new InputDecoration(
                  focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.black),
                  ),
                  enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.black),
                  ),
              ),)
            )
          ),
        ],)
      ),
    );
  }
}


