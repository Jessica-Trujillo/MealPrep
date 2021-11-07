//using Npgsql;
using Npgsql;
using System;

namespace WebApplication1.Controllers
{
  public class IngredientInstance
  {
    public int id { get; set; }
    public int ingredientId { get; set; }
    public String Quantity { get; set; }


    public IngredientInstance() { }

    public IngredientInstance(NpgsqlDataReader reader)
    {
      id = reader.GetInt32(0);
      ingredientId = reader.GetInt32(1);
      Quantity = reader.GetString(2);
    }
  }
}
