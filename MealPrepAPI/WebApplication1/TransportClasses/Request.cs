//using Npgsql;

namespace WebApplication1.Controllers
{
  public class Request
  {
    public int calorieGoal { get; set; }
    public int numOfDays { get; set; }
    public int weeklyBudget { get; set; }
    public double carbPercentage { get; set; }
    public double fatPercentage { get; set; }
    public double proteinPercentage { get; set; }
    public string[] dietaryRestrictions { get; set; }
    public string[] favorites { get; set; }
    public string[] blacklist { get; set; }
    public string[] recent { get; set; }

  }
}
