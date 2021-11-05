//using Npgsql;

namespace WebApplication1.Controllers
{
  public class MealTime
  {
    public Meal meal { get; set; }
    
    public int Day { get; set; }

    public int Hour { get; set; }
    public int Minute { get; set; }
  }
}
