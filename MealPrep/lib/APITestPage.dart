import 'dart:convert';

import 'package:flutter/material.dart';

import 'main.dart';

import 'package:http/http.dart' as http;

class APITestPage extends StatelessWidget {
  final TextEditingController controller = TextEditingController();

  void testAPIClicked() async {
    var request = Request(
        calorieGoal: 1700,
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
    var response = await http.post(Uri.parse('https://10.0.2.2:44314/MealPlan'),
        body: asJson1, headers: {"Content-Type": "application/json"});

    dynamic asJson = jsonDecode(response.body);
    // FullMealPlan mealPlan = FullMealPlan.fromMap(asJson);

    controller.text = asJson.toString();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Mobile Food APP API TEST',
      home: Scaffold(
          appBar: AppBar(
            title: const Text('API TEST'),
            titleSpacing: 25,
          ),
          body: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                  margin: EdgeInsets.fromLTRB(0, 20, 0, 0),
                  child: Container(
                    width: 150,
                    height: 40,
                    child: ElevatedButton(
                        onPressed: testAPIClicked,
                        child: Text(
                          "Test API",
                          style: TextStyle(color: Colors.white, fontSize: 20),
                        )),
                  )),
              Expanded(
                  child: Container(
                      margin: EdgeInsets.all(20),
                      color: Colors.grey[200],
                      child: TextField(
                        controller: controller,
                        expands: true,
                        minLines: null,
                        maxLines: null,
                        style: TextStyle(fontSize: 16, color: Colors.black),
                        decoration: new InputDecoration(
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.black),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.black),
                          ),
                        ),
                      ))),
            ],
          )),
    );
  }
}
