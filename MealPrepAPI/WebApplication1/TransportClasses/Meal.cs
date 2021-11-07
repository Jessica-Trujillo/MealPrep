using Npgsql;
using System;

namespace WebApplication1.Controllers
{
  public class Meal
  {
    public int Id { get; set; }
    public String name { get; set; }
    public String recipe { get; set; }
    public int totalPrepTime { get; set; } 
    public int totalCookTime { get; set; }
    public int minutesNeededBeforeMeal { get; set; }
    public IngredientInstance[] ingredients { get; set; }
    public int calorieCounter { get; set; }
    public int costInPennies { get; set; }
    public double carbPercent { get; set;}
    public double fatPercent { get; set; }
    public double proteinPercent { get; set; }
    public String[] tags { get; set; }

    public String PhotoPath { get; set; }

    public String MealType { get; set; }

    public async void ResolveIngredientInstances()
    {

    }

    public Meal()
    {

    }


    public Meal(NpgsqlDataReader reader)
    {
      Id = reader.GetInt32(0);
      name = reader.GetString(1);
      recipe = reader.GetString(2);

      totalPrepTime = reader.GetInt32(3);
      totalCookTime = reader.GetInt32(4);
      minutesNeededBeforeMeal = reader.GetInt32(5);
      calorieCounter = reader.GetInt32(6);
      costInPennies = reader.GetInt32(7);
      carbPercent = reader.GetDouble(8);
      fatPercent = reader.GetDouble(9);
      proteinPercent = reader.GetDouble(10);

      PhotoPath = reader.GetString(11);

      int mealType = reader.GetInt32(12);
      switch (mealType)
      {
        case 0:
          MealType = "Breakfast";
          break;
        case 1:
          MealType = "Lunch";
          break;
        case 2:
          MealType = "Dinner";
          break;
      }
    }


  }
}
