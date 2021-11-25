using Microsoft.AspNetCore.Mvc;
using Npgsql;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;
using WebApplication1.Queries;

namespace WebApplication1.Controllers
{
  public class MealQuery
  {
    public string tag { get; set; } 
    public string searchParam { get; set; }
  }


  [ApiController]
  [Route("[controller]")]
  public class MealRequestController : ControllerBase
  {

    [HttpPost]
    public async Task<Meal[]> Post(
      [FromBodyAttribute]
      MealQuery query)
    {


      String sqlQuery;
      if (String.IsNullOrWhiteSpace(query.tag))
      {
        sqlQuery = @"SELECT DISTINCT ""Meals"".""Id""
FROM ""Meals""
Where name like @seachParam
limit 20";
      }
      else
      {
        sqlQuery = @"SELECT DISTINCT ""Meals"".""Id""
FROM ""Meals""
INNER JOIN ""MealTags"" ON ""MealTags"".""MealId"" = ""Meals"".""Id""
INNER JOIN ""Tags"" ON ""TagId"" = ""Tags"".""Id""
Where name like @seachParam and
      ""Tags"".""Name"" = @tagName
limit 20";
      }

      

      query.searchParam = "%" + query.searchParam + "%";

      var connString = "Host=127.0.0.1;Username=postgres;Password=Jt680355;Database=mealPrepDB";
      var conn = new NpgsqlConnection(connString);

      await conn.OpenAsync();

      List<int> featureMealIds = new List<int>();
      await using (var cmd = new NpgsqlCommand(sqlQuery, conn))
      {

        cmd.Parameters.AddWithValue("tagName", query.tag);
        cmd.Parameters.AddWithValue("seachParam", query.searchParam);
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
