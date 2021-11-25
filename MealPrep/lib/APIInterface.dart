import 'dart:convert';
import 'package:foodplanapp/CurrentSession.dart';
import 'package:foodplanapp/main.dart';

import 'package:http/http.dart' as http;

class APIInterface {



  static Future<void> ensureMealPlan() async {
    var currentUser = CurrentSession.currentProfile;
    var timeGenerated = CurrentSession.currentProfile.mealPlanStartDay;
    var today = DateTime.now();
    if (currentUser.currentMealPlanJson == null || (timeGenerated == null) || (timeGenerated.difference(today).inDays < -7) ) {


      var request = Request(calorieGoal: currentUser.getCalorieGoal(), 
                          numOfDays: 7, 
                          weeklyBudget: 500, 
                          blacklist: ["C"], 
                          carbPercentage: 30, 
                          fatPercentage: 40, 
                          proteinPercentage: 30, 
                          dietaryRestrictions: ["B"], 
                          favorites: ["A"],
                          recent: ["D"]);

      var asJson1 = jsonEncode(request.toMap());
      var response = await http.post(Uri.parse('https://10.0.2.2:44314/MealPlan'),body: asJson1, headers: {"Content-Type": "application/json"} );
      currentUser.currentMealPlanJson = response.body;
      currentUser.mealPlanStartDay = DateTime.now();
      currentUser.save();

      dynamic asJson = jsonDecode(currentUser.currentMealPlanJson!);
      currentUser.resolvedMealPlan = FullMealPlan.fromMap(asJson);
    }
    else {
      dynamic asJson = jsonDecode(currentUser.currentMealPlanJson!);
      currentUser.resolvedMealPlan = FullMealPlan.fromMap(asJson);
    }
  }


  static Future<List<Meal>> getFeaturedMeals() async {
    List<Meal> featuredMeals = [];

    
    var response = await http.get(Uri.parse('https://10.0.2.2:44314/FeatureMeals'), headers: {"Content-Type": "application/json"} );
    dynamic asJson = jsonDecode(response.body);
   
    if (asJson is List<dynamic>){
      for(var item in asJson){
        featuredMeals.add(Meal.fromMap(item));
      }
    }

    return featuredMeals;
  }

}
