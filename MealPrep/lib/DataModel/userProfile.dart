
import 'dart:math';
import 'dart:typed_data';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:foodplanapp/main.dart';

class UserProfile {
 
  
  int getCalorieGoal(){
    if (heightInInches == null)
      return 2000;
    if (gender == null)
      return 2000;
    if (weightGoal == null)
      return 2000;
    if (weightGoalRate == null)
      return 2000;
    if (currentWeight == null)
      return 2000;
    if (birthday == null)
      return 2000;

    var age = DateTime.now().difference(birthday!).inDays / 365;

    double bmr;
    if (gender == "Male"){
      bmr = (66 + (6.3*currentWeight!) + (12.9 * heightInInches!) - (6.8 * age));
    }
    else{
      bmr = (655 + (4.3*currentWeight!) + (4.7 * heightInInches!) - (4.7 * age));
    }

    int baseCalories = (bmr * 1.5).toInt();

    if (weightGoal == "Lose"){
      if (weightGoalRate == "1/2 lb"){
        return max(baseCalories - 500, 100);
      }
      else if (weightGoalRate == "1 lb"){
        return max(baseCalories - 1000, 100);
      }
      else if (weightGoalRate == "1.5 lbs"){
        return max(baseCalories - 1500, 100);
      }
    }
    else if (weightGoal == "Gain"){
      if (weightGoalRate == "1/2 lb"){
        return baseCalories + 500;
      }
      else if (weightGoalRate == "1 lb"){
        return baseCalories + 1000;
      }
      else if (weightGoalRate == "1.5 lbs"){
        return baseCalories + 1500;
      }
    }
    return baseCalories;
  }

  bool finsihedRegistration;

  String username;
  String email;
  String? gender;

  int? targetWeight;
  int? currentWeight;
  int? calorieIntake;
  DateTime? birthday;
  String? weightGoal;
  String? weightGoalRate;

  String? currentMealPlanJson;
  FullMealPlan? resolvedMealPlan;
  DateTime? mealPlanStartDay;

  int? heightInInches;

  List<String>? dietaryRestrictions;
  List<String>? prepDays;

  List<DateTime> goodDays = [];
  List<DateTime> badDays = [];

  List<String> favoriteMeals = [];
  List<String> blacklistMeals = [];

  Uint8List? profilePicture;

  UserProfile(this.username, this.email, this.finsihedRegistration);

  List<String> readList(MapEntry<String, dynamic> entry){
    var dynList = entry.value as List<dynamic>?;
    List<String> newList = [];
    if (dynList != null){
      for (var item in dynList){
        newList.add(item.toString());
      }
    }

    return newList;
  }

  void load(Map<String,dynamic> data) {
    for (var entry in data.entries) {
      switch (entry.key){
        case "username":
          username = entry.value as String;
          break;
        case "gender":
          gender = entry.value as String?;
          break;
        case "heightInInches":
          heightInInches = int.tryParse(entry.value.toString());
          break;
        case "targetWeight":
          targetWeight = int.tryParse(entry.value.toString());
          break;
        case "currentWeight":
          currentWeight = int.tryParse(entry.value.toString());
          break;
        case "calorieIntake":
          calorieIntake = int.tryParse(entry.value.toString());
          break;
        case "weightGoal" :
          weightGoal = entry.value as String?;
          break;
        case "weightGoalRate" :
          weightGoalRate = entry.value as String?;
          break;
        case "currentMealPlanJson" :
          currentMealPlanJson = entry.value as String?;
          break;
        case "birthday":
          birthday = DateTime.tryParse(entry.value.toString());
          break;
        case "mealPlanStartDay":
          var time = entry.value;
          if (time is Timestamp){
            mealPlanStartDay = time.toDate();
          }else{
            mealPlanStartDay = DateTime.tryParse(entry.value.toString());
          }
          break;
        case "finsihedRegistration":
          finsihedRegistration = entry.value as bool;
          break;
        case "dietaryRestrictions":
          dietaryRestrictions = readList(entry);
          break;
        case "prepDays":
          prepDays = readList(entry);
          break;
        case "profilePicture":
          var dynList = entry.value as List<dynamic>?;
          List<int> newList = [];
          if (dynList != null){
            for (var item in dynList){
              if (item is int){
                newList.add(item);
                continue;
              }
              int? parsedInt = int.tryParse(item.toString());
              if (parsedInt != null){
                newList.add(parsedInt);
              }
            }
          }

          profilePicture = Uint8List.fromList(newList);
          break;
        case "goodDays":
          var dynList = entry.value as List<dynamic>?;
          List<DateTime> newList = [];
          if (dynList != null){
            for (var item in dynList){
              if (item is Timestamp) {
                newList.add(item.toDate());
              }
            }
          }

          goodDays = newList;
          break;
        case "badDays":
          var dynList = entry.value as List<dynamic>?;
          List<DateTime> newList = [];
          if (dynList != null){
            for (var item in dynList){
              if (item is Timestamp) {
                newList.add(item.toDate());
              }
            }
          }

          badDays = newList;
          break;
      }

      if (entry.key == "username"){
        username = entry.value as String;
      }
      else if (entry.key == "username"){
        username = entry.value as String;
      }
      
    }
  }

  Future<void> save() async {
    var collection = FirebaseFirestore.instance.collection('userProfiles');
    var doc = collection.doc(email.replaceAll(".", "|")); 

    Map<String,dynamic> documentData = {
      "username" : username,
      "gender" : gender,
      "targetWeight" : targetWeight,
      "currentWeight" : currentWeight,
      "calorieIntake" : calorieIntake,
      "birthday" : birthday,
      "dietaryRestrictions" : dietaryRestrictions,
      "prepDays" : prepDays,
      "goodDays" : goodDays,
      "badDays" : badDays,
      "favoriteMeals" : favoriteMeals,
      "blacklistMeals" : blacklistMeals,
      "finsihedRegistration" : finsihedRegistration,
      "heightInInches" : heightInInches,
      "weightGoal" : weightGoal,
      "weightGoalRate" : weightGoalRate,
      "currentMealPlanJson" : currentMealPlanJson,
      "mealPlanStartDay" : mealPlanStartDay,      
      "profilePicture" : profilePicture
    };

    await doc.set(documentData);
  }


}