using Npgsql;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;
using WebApplication1.Queries;

namespace WebApplication1.Controllers
{

  public class MealPlanCalculator
  {

    public static async Task<FullMealPlan> GetFullMealPlanFromRequest(Request request)
    {
      var calculator = new MealPlanCalculator();
      return await calculator.DoGetFullMealPlanFromRequest(request);
    }

    private MealPlanCalculator()
    {

    }


    private async Task<Meal> GetMealFromDB(int calorieGoalMin, int calorieGoalMax, int mealType)
    {

      var connString = "Host=127.0.0.1;Username=postgres;Password=Jt680355;Database=mealPrepDB";
      var conn = new NpgsqlConnection(connString);

      await conn.OpenAsync();
      // Insert some data
      //await using (var cmd = new NpgsqlCommand("INSERT INTO data (some_field) VALUES (@p)", conn))
      //{
      //  cmd.Parameters.AddWithValue("p", "Hello world");
      //  await cmd.ExecuteNonQueryAsync();
      //}

      // Retrieve all rows

      var meals = await MealQueries.GetMealsWithBetweenCalories(conn, calorieGoalMin, calorieGoalMax, mealType);

      if (meals.Count == 0)
      {
        await conn.CloseAsync();
        return await GetMealFromDB(calorieGoalMin - 100, calorieGoalMax + 100, mealType);
      }

      Random rand = new Random();
      int randomMealIndex = rand.Next(0, meals.Count);

      var foundMeal = meals[randomMealIndex];

      await foundMeal.ResolveIngredientInstances(conn);

      String ingredientInstanceQuery = 
@"SELECT ""MealId"", ""IngrInstanceId""
FROM ""MealIngredients""
WHERE ""MealId"" = " + foundMeal.Id;

      List<int> instanceIds = new List<int>();
      await using (var cmd = new NpgsqlCommand(ingredientInstanceQuery, conn))
      {
        await using (var reader = await cmd.ExecuteReaderAsync())
        {
          while (await reader.ReadAsync())
          {
            int idToAdd = reader.GetInt32(1);
            instanceIds.Add(idToAdd);    
          }
        }
      }

      List<IngredientInstance> mealIngedients = new List<IngredientInstance>();

      foreach (var id in instanceIds)
      {
        String idQuery =
@"SELECT ""Id"", ""IngredientId"", ""Quantity""
FROM ""IngredientInstance""
WHERE ""Id"" = " + id;

        await using (var cmd = new NpgsqlCommand(idQuery, conn))
        {
          await using (var reader = await cmd.ExecuteReaderAsync())
          {
            while (await reader.ReadAsync())
            {
              mealIngedients.Add(new IngredientInstance(reader));
            }
          }
        }

      }

      foundMeal.ingredients = mealIngedients.ToArray();


      await conn.CloseAsync();
      return foundMeal;
    }




    private async Task<FullMealPlan> DoGetFullMealPlanFromRequest(Request request)
    {
      List<MealTime> mealTimes = new List<MealTime>();

      for (int i = 0; i < 7; i++)
      {
        int breakfastCalories = (int)(request.calorieGoal * 0.2);
        int dinnerCalories = (int)(request.calorieGoal * 0.47);

        var breakfast = await GetMealFromDB(breakfastCalories - 100, breakfastCalories + 100, 0);
        var dinner = await GetMealFromDB(dinnerCalories - 100, dinnerCalories + 100, 2);

        var currentTotal = breakfast.calorieCounter + dinner.calorieCounter;
        var lunchCalories = request.calorieGoal - currentTotal;

        var lunch = await GetMealFromDB(lunchCalories - 100, lunchCalories + 100, 1);

        mealTimes.Add(new MealTime()
        {
          Day = i,
          Hour = 8,
          Minute = 30,
          meal = breakfast
        });

        mealTimes.Add(new MealTime()
        {
          Day = i,
          Hour = 12,
          Minute = 00,
          meal = lunch
        });

        mealTimes.Add(new MealTime()
        {
          Day = i,
          Hour = 17,
          Minute = 0,
          meal = dinner
        });
      }

      var ingredientIds = mealTimes.SelectMany(a => a.meal.ingredients)
                                   .Select(a => a.ingredientId)
                                   .Distinct()
                                   .ToList();


      var connString = "Host=127.0.0.1;Username=postgres;Password=Jt680355;Database=mealPrepDB";
      var conn = new NpgsqlConnection(connString);

      await conn.OpenAsync();

      foreach (var instance in mealTimes.SelectMany(a => a.meal.ingredients))
      {
        await instance.ResolveIngredient(conn);
      }

      var ingredients = mealTimes.SelectMany(a => a.meal.ingredients.Select(a => a.ingredient))
                                 .GroupBy(a => a.id)
                                 .Select(a => a.FirstOrDefault())
                                 .ToArray();

      await conn.CloseAsync();

      return new FullMealPlan()
      {
        IngredientsNeeded = ingredients,
        Meals = mealTimes.ToArray()
      };
    }



  }
}
