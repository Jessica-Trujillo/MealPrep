using Microsoft.AspNetCore.Mvc;
using Microsoft.Extensions.Logging;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;

namespace WebApplication1.Controllers
{

  public class FullMealPlan
  {
    public MealTime[] Meals { get; set; }
    public Ingredient[] IngredientsNeeded { get; set; }
  }

  public class MealTime
  {
    public Meal meal { get; set; }
    
    public int Hour { get; set; }
    public int Minute { get; set; }
  }



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
    public double carbPercent { get; set; }
    public double fatPercent { get; set; }
    public double proteinPercent { get; set; }
    public String[] tags { get; set; }
  }

  public class IngredientInstance
  {
    public int ingredientId { get; set; }
    public String Quantity { get; set; }
  }

  public class StoreIngredient
  {
    public int costInPennies { get; set; }
    public String quantity { get; set; }
    public String[] storeLinks { get; set; }
  }

  public class Ingredient
  {
    public int id { get; set; }

    public string Name { get; set; }

    public double calories { get; set; }
    public String quantityForCalorie { get; set; }

    public StoreIngredient[] storeIngredients { get; set; }

    public String[] tags { get; set; }

    public int ExpirationTimeInDays { get; set; }
  }



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
      return new FullMealPlan()
      {
        IngredientsNeeded = new[] { 
          new Ingredient()
          {
            Name = "Whole Milk",
            calories = 100,
            ExpirationTimeInDays = 30,
            id = 1,
            quantityForCalorie = "100 grams",
            tags = new [] { "Dairy" },
            storeIngredients = new[]
            {
              new StoreIngredient()
              {
                costInPennies = 229,
                quantity = "1 gallon",
                storeLinks = new [] {"https://www.walmart.com/ip/Organic-Valley-Ultra-Pasteurized-Organic-Whole-Milk-128-oz/498874357" }
              }
            }
          },
          new Ingredient()
          {
            Name = "Cap'n Crunch Cereal",
            calories = 150,
            ExpirationTimeInDays = 120,
            id = 2,
            quantityForCalorie = "100 grams",
            tags = new [] { "Gluten" },
            storeIngredients = new[]
            {
              new StoreIngredient()
              {
                costInPennies = 455,
                quantity = "1133 grams",
                storeLinks = new [] { "https://www.walmart.com/ip/Cap-n-Crunch-Breakfast-Cereal-Crunch-Berries-40-oz-Bag/45912909" }
              }
            }
          }
        },
        Meals = new[]
        {
          new MealTime()
          {
            Hour = 8,
            Minute = 30,
            meal = new Meal()
            {
              name = "Cap'n Crunch Cereal with whole milk",
              calorieCounter = 400,
              carbPercent = 0.8,
              fatPercent = 0.1,
              proteinPercent = 0.1,
              costInPennies = 100,
              tags = new []{"Gluten", "Dairy" },
              recipe = "Take cereal out of bag, pour into bowl, add milk,  stir for 3 minutes, shake then serve",
              minutesNeededBeforeMeal = 2,
              totalCookTime = 0,
              totalPrepTime = 0,
              ingredients = new[]
              {
                new IngredientInstance()
                {
                  ingredientId = 1,
                  Quantity = "1 cup"
                },
                new IngredientInstance()
                {
                  ingredientId = 2,
                  Quantity = "1 cup"
                },

              }

            }
          },
         
        }
      };
    }
  }
}
