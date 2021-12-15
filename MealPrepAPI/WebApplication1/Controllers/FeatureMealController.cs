using Microsoft.AspNetCore.Mvc;
using Npgsql;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;
using WebApplication1.Queries;

namespace WebApplication1.Controllers
{
  [ApiController]
  [Route("[controller]")]
  public class FeatureMealsController : ControllerBase
  {



    [HttpGet]
    public async Task<Meal[]> Get()
    {

      String ingredientInstanceQuery =
@"SELECT ""MealId""
FROM ""FeaturedMeals""";

      var connString = "Host=127.0.0.1;Username=postgres;Password=Jt680355;Database=mealPrepDB";
      var conn = new NpgsqlConnection(connString);

      await conn.OpenAsync();

      List<int> featureMealIds = new List<int>();
      await using (var cmd = new NpgsqlCommand(ingredientInstanceQuery, conn))
      {
        await using (var reader = await cmd.ExecuteReaderAsync())
        {
          while (await reader.ReadAsync())
          {
            int idToAdd = reader.GetInt32(0);
            featureMealIds.Add(idToAdd);
          }
        }
      }

      var meals = await MealQueries.GetMealsWithIds(conn, featureMealIds.ToArray());

      foreach (var meal in meals)
      {
        await meal.ResolveIngredientInstances(conn);
      }

      foreach (var instance in meals.SelectMany(a => a.ingredients))
      {
        await instance.ResolveIngredient(conn);
      }

      await conn.CloseAsync();

      return meals.ToArray();
    }


  }
}
