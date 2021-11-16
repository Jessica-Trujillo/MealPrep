using Npgsql;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;
using WebApplication1.Controllers;

namespace WebApplication1.Queries
{
  public class IngredientQueries
  {

    public static async Task<Ingredient> GetIngredientFromId(NpgsqlConnection conn, int ingredientId)
    {
      String ingQuery =
       @"SELECT ""Id"", name, calories, ""quantityForCalorie"", ""expirationTimeInDays""
FROM public.""Ingredient""
WHERE ""Id"" = " + ingredientId;


      await using (var cmd = new NpgsqlCommand(ingQuery, conn))
      {
        await using (var reader = await cmd.ExecuteReaderAsync())
        {
          while (await reader.ReadAsync())
          {
            return new Ingredient(reader);

          }
        }
      }
      return null;
    }

    public static async Task<List<Ingredient>> GetIngredientsFromIds(NpgsqlConnection conn, List<int> ingredientIds)
    {
      List<Ingredient> returnList = new List<Ingredient>();

      foreach (int id in ingredientIds)
      {
        var ing = await GetIngredientFromId(conn, id);
        if (ing != null)
          returnList.Add(ing);

      }

      return returnList;
    }
  }
}
