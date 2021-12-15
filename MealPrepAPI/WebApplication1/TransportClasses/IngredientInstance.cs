//using Npgsql;
using Npgsql;
using System;
using System.Threading.Tasks;
using WebApplication1.Queries;

namespace WebApplication1.Controllers
{
  public class IngredientInstance
  {
    public int id { get; set; }
    public int ingredientId { get; set; }
    public String Quantity { get; set; }

    public Ingredient ingredient { get; set; }

    public async Task ResolveIngredient(NpgsqlConnection conn)
    {
      ingredient = await IngredientQueries.GetIngredientFromId(conn, ingredientId);
    }


    public IngredientInstance() { }

    public IngredientInstance(NpgsqlDataReader reader)
    {
      id = reader.GetInt32(0);
      ingredientId = reader.GetInt32(1);
      Quantity = reader.GetString(2);
    }
  }
}
