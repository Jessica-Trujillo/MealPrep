
import 'package:cloud_firestore/cloud_firestore.dart';

class UserProfile {
 
  bool finsihedRegistration;

  String username;
  String email;
  String? gender;

  int? targetWeight;
  int? currentWeight;
  int? calorieIntake;
  DateTime? birthday;
  String? weightGoal;

  int? heightInInches;

  List<String>? dietaryRestrictions;

  List<DateTime> goodDays = [];
  List<DateTime> badDays = [];

  List<String> favoriteMeals = [];
  List<String> blacklistMeals = [];


  UserProfile(this.username, this.email, this.finsihedRegistration);

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
        case "birthday":
          birthday = DateTime.tryParse(entry.value.toString());
          break;
        case "finsihedRegistration":
          finsihedRegistration = entry.value as bool;
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
      "goodDays" : goodDays,
      "badDays" : badDays,
      "favoriteMeals" : favoriteMeals,
      "blacklistMeals" : blacklistMeals,
      "finsihedRegistration" : finsihedRegistration,
      "heightInInches" : heightInInches,
      "weightGoal" : weightGoal,
    };

    await doc.set(documentData);
  }


}