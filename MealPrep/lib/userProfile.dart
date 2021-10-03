
class UserProfile {
 
  String username;
  String email;
  String? gender;

  int? targetWeight;
  int? currentWeight;
  int? calorieIntake;
  DateTime? birthday;

  List<String>? dietaryRestrictions;

  List<DateTime>? goodDays;
  List<DateTime>? badDays;

  List<String>? favoriteMeals;
  List<String>? blacklistMeals;


  UserProfile(this.username, this.email);
}