using Npgsql;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;
using WebApplication1.Controllers;

namespace WebApplication1.Queries
{
  public class MealQueries
  {

    public static async Task<Meal> GetMealWithId(NpgsqlConnection connection, int id)
    {
      String query =
@"SELECT ""Id"", ""name"", ""recipe"", ""totalPrepTime"", ""totalCookTime"", ""minutesNeededBeforeMeal"", ""calorieCounter"", ""costInPennies"", 
    ""carbPercent"", ""fatPercent"", ""proteinPercent"", ""photoPath"", ""mealType""
FROM ""Meals""
WHERE ""Id"" = " + id;

      List<Meal> meals = new List<Meal>();
      await using (var cmd = new NpgsqlCommand(query, connection))
      {
        await using (var reader = await cmd.ExecuteReaderAsync())
        {
          while (await reader.ReadAsync())
          {

            var newMeal = new Meal(reader);
            return newMeal;

          }
        }
      }

      return null;
    }



    public static async Task<List<Meal>> GetMealsWithIds(NpgsqlConnection connection, int[] ids)
    {
      List<Meal> meals = new List<Meal>();
      foreach (var id in ids)
      {
        meals.Add(await GetMealWithId(connection, id));
      }
     
      return meals;
    }

    public static async Task<List<Meal>> GetMealsWithBetweenCalories(NpgsqlConnection connection, int calorieMin, int calorieMax, int mealType)
    {

      String query =
@"SELECT ""Id"", ""name"", ""recipe"", ""totalPrepTime"", ""totalCookTime"", ""minutesNeededBeforeMeal"", ""calorieCounter"", ""costInPennies"", 
    ""carbPercent"", ""fatPercent"", ""proteinPercent"", ""photoPath"", ""mealType""
FROM ""Meals""
WHERE ""calorieCounter"" > " + calorieMin + @" and ""calorieCounter"" < " + calorieMax + @" and ""mealType"" = " + mealType;

      List<Meal> meals = new List<Meal>();
      await using (var cmd = new NpgsqlCommand(query, connection))
      {
        await using (var reader = await cmd.ExecuteReaderAsync())
        {
          while (await reader.ReadAsync())
          {
            var newMeal = new Meal(reader);
            meals.Add(newMeal);

          }
        }
      }

      return meals;
    }

  }
}
