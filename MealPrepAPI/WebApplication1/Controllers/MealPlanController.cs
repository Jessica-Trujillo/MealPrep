using Microsoft.AspNetCore.Mvc;

namespace WebApplication1.Controllers
{


  [ApiController]
  [Route("[controller]")]
  public class MealPlanController : ControllerBase
  {

    public MealPlanController()
    {
    }

    [HttpPost]
    public FullMealPlan Post(
      [FromBodyAttribute]
      Request request)
    {
      return MealPlanCalculator.GetFullMealPlanFromRequest(request);
    }
  }
}
