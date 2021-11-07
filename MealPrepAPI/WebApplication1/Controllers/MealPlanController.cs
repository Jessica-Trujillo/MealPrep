using Microsoft.AspNetCore.Mvc;
using System.Threading.Tasks;

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
    public async Task<FullMealPlan> Post(
      [FromBodyAttribute]
      Request request)
    {
      return await MealPlanCalculator.GetFullMealPlanFromRequest(request);
    }
  }
}
