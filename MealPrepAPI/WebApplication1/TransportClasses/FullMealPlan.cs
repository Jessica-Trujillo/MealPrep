//using Npgsql;

namespace WebApplication1.Controllers
{
  public class FullMealPlan
  {
    public MealTime[] Meals { get; set; }
    public Ingredient[] IngredientsNeeded { get; set; }
  }
}
