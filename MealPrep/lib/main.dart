
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:foodplanapp/LoginRegistration/LoginPage.dart';
import 'package:firebase_core/firebase_core.dart';

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
          mealPlan.meals = meals;
        }
        else if (entry.key == "ingredientsNeeded"){
          List<Ingredient> ingredients = [];
          List<dynamic> value = entry.value;
          for (var item in value){
            if (item is Map<String, dynamic>){
              ingredients.add(Ingredient.fromMap(item));
            }
          }
          mealPlan.ingredientsNeeded = ingredients;
        }
      }

      return mealPlan;
    }

    List<MealTime>? meals;
    List<Ingredient>? ingredientsNeeded;
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
          mealTime.hour = int.parse(entry.value.toString());
        }
        if(entry.key == "minute"){
          mealTime.minute = int.parse(entry.value.toString());
        }
        if(entry.key == "day"){
          mealTime.day = int.parse(entry.value.toString());
        }
      }
      return mealTime;
    }

    Meal? meal;
    
    int? day;
    int? hour;
    int? minute;
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
          ing.quantity = entry.value.toString();
        }
      }

      return ing;
    }
    int? ingredientId;
    String? quantity;
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
          ing.expirationTimeInDays = int.parse(entry.value.toString());
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

    int? expirationTimeInDays;
  }

class MyApp extends StatefulWidget {

  @override
  State<StatefulWidget> createState() {
    return MyAppState();
  }
}


class MyAppState extends State<MyApp>{

  late Widget mainPage;

  bool isInitialized = false;

  void initAsync() async {    
    await Firebase.initializeApp();
    setState(() {
      isInitialized = true;
      mainPage = LoginPage();
    });
  }

  @override void initState(){
    mainPage = Scaffold(
      body: Container(alignment: Alignment.center, child: 
        Text("Initializing..", style: TextStyle(fontSize: 20))
      )
    );
    initAsync();
    super.initState();
  }


  @override
  Widget build(BuildContext context) {
    return MaterialApp(home: 
      mainPage
    );
  }

}


