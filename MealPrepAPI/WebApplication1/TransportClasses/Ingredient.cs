using Npgsql;
using System;

namespace WebApplication1.Controllers
{
  public class Ingredient
  {
    public int id { get; set; }

    public string Name { get; set; }

    public double calories { get; set; }
    public String quantityForCalorie { get; set; }

    public StoreIngredient[] storeIngredients { get; set; }

    public String[] tags { get; set; }

    public int ExpirationTimeInDays { get; set; }


    public Ingredient() { }

    public Ingredient(NpgsqlDataReader reader)
    {
      id = reader.GetInt32(0);
      Name = reader.GetString(1);
      calories = reader.GetDouble(2);
      quantityForCalorie = reader.GetString(3);
      ExpirationTimeInDays = reader.GetInt32(4);
    }
  }
}
