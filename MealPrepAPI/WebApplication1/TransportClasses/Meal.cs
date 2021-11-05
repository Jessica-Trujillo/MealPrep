//using Npgsql;
using System;

namespace WebApplication1.Controllers
{
  public class Meal
  {
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

    // TODO: MealPhotoPath
    // Add image property as String representing URL path to the image
  }
}
