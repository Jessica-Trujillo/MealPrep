import 'package:flutter/material.dart';
import 'package:foodplanapp/APIInterface.dart';
import 'package:foodplanapp/MyColors.dart';
import 'package:foodplanapp/Recipes/Recipe.dart';
import 'package:foodplanapp/main.dart';

class RecipesPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _RecipesPageState();
  }
}

enum TagCategories {
  Ethnicity,
  Dietary,
  Other
}


class TagFilter{
  String tagName;
  late String displayName;
  TagCategories tagCategory;

  TagFilter({required this.tagName, required this.tagCategory}){
    displayName = tagName;
  }
  TagFilter.withDisplayName({required this.tagName, required this.displayName, required this.tagCategory});
}

Color getColorForTag(TagFilter tag) {
  switch (tag.tagCategory){
    case TagCategories.Dietary:
      return MyColors.yellow;
    case TagCategories.Ethnicity:
      return MyColors.green;
    case TagCategories.Other:
      return MyColors.grey;
  }
}

List<TagFilter> tagFilters = [
  TagFilter(tagName: "Vegan", tagCategory: TagCategories.Dietary),
  TagFilter(tagName: "Dairy", tagCategory: TagCategories.Dietary),
  TagFilter(tagName: "Dairy-Free", tagCategory: TagCategories.Dietary),
  TagFilter(tagName: "Glucose-Free", tagCategory: TagCategories.Dietary),
  TagFilter(tagName: "Asian", tagCategory: TagCategories.Ethnicity),
  TagFilter(tagName: "American", tagCategory: TagCategories.Ethnicity),
  TagFilter(tagName: "Mexican", tagCategory: TagCategories.Ethnicity),
];

class _RecipesPageState extends State<RecipesPage> {

  TextEditingController searchController = TextEditingController();

  void performSearch() async {
    if (selectedTagFilter == null && searchController.text.isEmpty){
      setState(() {
        mealsFromSearch = null;
      });
      return;
    }

    setState(() {
      isSearching = true;
    });
    var query = MealQuery(tag: selectedTagFilter?.tagName ?? "", searchParam: searchController.text);

    var newMeals = await APIInterface.searchForMeals(query);
    setState(() {
      isSearching = false;
      mealsFromSearch = newMeals;
    });

  }


  Widget buildChip(TagFilter filter) {
    Color color = filter == selectedTagFilter ? Colors.blue : getColorForTag(filter);
    return  GestureDetector(onTap: (){ setState(() {
      if (selectedTagFilter == filter)
        selectedTagFilter = null;
      else
        selectedTagFilter = filter;

      performSearch();
    });},
      child: 
        Chip(
            labelPadding: EdgeInsets.fromLTRB(13, 3, 13, 3),
            label: Text(filter.displayName),
            labelStyle: TextStyle(
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
            backgroundColor: color)
    );
  }

  static List<Meal>? featuredMeals;
  List<Meal>? mealsFromSearch;
  bool isSearching = false;

  void initAsync() async {
    if (featuredMeals == null){
      var foundMeals = await APIInterface.getFeaturedMeals();
      setState(() {
        featuredMeals = foundMeals;
      });
    }
  }

  TagFilter? selectedTagFilter;



  Widget mealCard(String title, String calories, String mealTitle, String ingredient1, String ingredient2) {
    return 
      Container(
        margin: EdgeInsets.only(bottom: 18),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10), color: MyColors.lightGrey),
        child: Container(
            child: Row(children: [
          Container(
              height: 125,
              width: 125,
              child: ClipRRect(
                borderRadius: BorderRadius.horizontal(left: Radius.circular(10)),
                child: FittedBox(
                  fit: BoxFit.cover,
                  clipBehavior: Clip.hardEdge,
                  child: Image.asset("images/backgroundImage.png"),
                ),
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
  void initState(){
    initAsync();
    super.initState();
  }

  String upperCaseFirstLetter(String str){
    String rtn = "";

    for(int i = 0; i < str.length; i++) {
      if (i == 0){
        rtn += str[i].toUpperCase();
        continue;
      }
      if(str[i - 1] == " "){
        rtn += str[i].toUpperCase();
        continue;
      }
      rtn += str[i];
    }
    return rtn;
  }

  void cardTapped(Meal meal){
    Navigator.of(context).push(MaterialPageRoute(builder: (context)=> RecipeNew(meal: meal)));    
  }

  Widget buildMealCard(Meal meal) {
    return GestureDetector(onTap: (){
      cardTapped(meal);
    },
    child:
      Column(children: [
        Container(margin: EdgeInsets.all(10), height: 100, width: 100, 
          child: FittedBox(
            fit: BoxFit.cover,
            clipBehavior: Clip.hardEdge,
            child:  
              Expanded(child: 
                meal.photoPath == null ? Image.asset("images/spices.jpg") : Image.network(meal.photoPath!),               
              ),
          ), 
        ),
        Text(meal.name == null ? "Unknown" : upperCaseFirstLetter(meal.name!), style: TextStyle(fontWeight: FontWeight.bold),)
      ])
    );
  }

  Widget buildFeatured(){
    List<Widget> featuredMealCards= [];
    if (featuredMeals != null){
      for (var meal in featuredMeals!){
        featuredMealCards.add(
          buildMealCard(meal)
        );
      }
    }

    return Column(children: [
      Container(
                margin: EdgeInsets.only(top: 20),
                alignment: Alignment.bottomLeft,
                child: Text('Featured', style: MyStyles.h1Text)),
            Container(
              alignment: Alignment.centerLeft,
              child:
              SingleChildScrollView(scrollDirection: Axis.horizontal, child: 
                Row(
                  children: featuredMealCards,
                ),
              )
            ),
    ],);
  }

  Widget buildSearchBar(){
    List<Widget> tagFilterWidgets = [];
    for (var filter in tagFilters) {
      tagFilterWidgets.add(buildChip(filter));
    }

    return Column(
      children: [
        Container(
              margin: EdgeInsets.only(top: 25, right: 25, bottom: 20),
              height: 39,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: MyColors.lightGrey,
              ),
              child: Stack(children: [
                Positioned(
                    left: 10,
                    top: 0,
                    bottom: 0,
                    child: Icon(
                      Icons.search,
                      color: MyColors.grey,
                    )),
                TextField(
                    style: MyStyles.bodyText,
                    controller: searchController,
                    onSubmitted: (text) {
                      performSearch();
                    },
                    decoration: InputDecoration(
                      contentPadding:
                          EdgeInsets.only(left: 40, right: 15, bottom: 8),
                      border: InputBorder.none,
                      hintText: "Search recipe",
                    )),
              ]),
            ),
            Container(
              margin: EdgeInsets.only(right: 25),
              alignment: Alignment.bottomLeft,
              child: Wrap(
                spacing: 8,
                children: tagFilterWidgets,
              ),
            ),
      ],
    );
  }

  Widget buildSearchResults(){
    List<Widget> mealCardWidgets = [];
    if (mealsFromSearch != null){
      for (var meal in mealsFromSearch!){
        mealCardWidgets.add(
          //Container(width: 200, height: 200,
         // child: 
          
          buildMealCard(meal)
          //)
        );
      }
    }

    return Column(children: [
      Container(
                margin: EdgeInsets.only(top: 20),
                alignment: Alignment.bottomLeft,
                child: Text('Seach Results', style: MyStyles.h1Text)),
         // Expanded(child: 
           // SingleChildScrollView(scrollDirection: Axis.horizontal, child: 
              Wrap(
                children: mealCardWidgets,
              ),
           // )
          //)
            
    ],);
  }

  Widget buildBottom(){
    if (isSearching){
      return Text("Searching..", style: TextStyle(fontSize: 20),);
    }

    if (mealsFromSearch != null){
      return buildSearchResults();
    }

    return buildFeatured();
  }

  @override
  Widget build(BuildContext context) {
    

    return Scaffold(
      appBar: AppBar(
        titleSpacing: 25,
        backgroundColor: MyColors.accentColor,
        title: const Text('Recipes'),
      ),
      body: Container(
        margin: EdgeInsets.only(left: 25),
        child: ListView(
          physics: BouncingScrollPhysics(),
          children: <Widget>[
            buildSearchBar(),
            buildBottom(),
          ],
        ),
      ),
    );
  }
}
