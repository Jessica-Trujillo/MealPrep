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
    
    public int Day { get; set; }

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
    public double carbPercent { get; set;}
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
          },
          new Ingredient()
          {
            Name = "Bread",
            calories = 130,
            ExpirationTimeInDays = 7,
            id = 3,
            quantityForCalorie = "1 slice",
            tags = new [] { "Gluten" },
            storeIngredients = new[]
            {
              new StoreIngredient()
              {
                costInPennies = 298,
                quantity = "12 slices",
                storeLinks = new [] { "https://www.walmart.com/ip/Oroweat-Whole-Grains-100-Whole-Wheat-Bread-Baked-with-Simple-Ingredients-Whole-Wheat-24-oz/10451446" }
              }
            }
          },
          new Ingredient()
          {
            Name = "Lunch Meat Turkey",
            calories = 130,
            ExpirationTimeInDays = 7,
            id = 4,
            quantityForCalorie = "1 slice",
            tags = new String[] {},
            storeIngredients = new[]
            {
              new StoreIngredient()
              {
                costInPennies = 443,
                quantity = "12 slices",
                storeLinks = new [] { "https://www.walmart.com/ip/Great-Value-Thin-Sliced-Oven-Roasted-Turkey-Breast-Family-Pack-8-oz-2-count/47394316" }
              }
            }
          }
        },
        Meals = new[]
        {
          new MealTime()
          {
            Day = 0,
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
          new MealTime()
          {
            Day = 0,
            Hour = 12,
            Minute = 30,
            meal = new Meal()
            {
              name = "Sandwich",
              calorieCounter = 450,
              carbPercent = 0.9,
              fatPercent = 0.05,
              proteinPercent = 0.05,
              costInPennies = 200,
              tags = new []{"Gluten", "Dairy" },
              recipe = "Call Jessica, have her make you a sandwich",
              minutesNeededBeforeMeal = 2,
              totalCookTime = 0,
              totalPrepTime = 2,
              ingredients = new[]
              {
                new IngredientInstance()
                {
                  ingredientId = 3,
                  Quantity = "2 slices"
                },
                new IngredientInstance()
                {
                  ingredientId = 4,
                  Quantity = "3 slices"
                },

              }

            }
          },
          new MealTime()
          {
            Day = 0,
            Hour = 17,
            Minute = 0,
            meal = new Meal()
            {
              name = "Turkey Dinner",
              calorieCounter = 450,
              carbPercent = 0.2,
              fatPercent = 0.3,
              proteinPercent = 0.5,
              costInPennies = 200,
              tags = new String[]{  },
              recipe = "Take turkey out of container,  place on plate",
              minutesNeededBeforeMeal = 2,
              totalCookTime = 0,
              totalPrepTime = 2,
              ingredients = new[]
              {
                new IngredientInstance()
                {
                  ingredientId = 4,
                  Quantity = "6 slices"
                },
              }

            }
          },

          new MealTime()
          {
            Day = 1,
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
          new MealTime()
          {
            Day = 1,
            Hour = 12,
            Minute = 30,
            meal = new Meal()
            {
              name = "Sandwich",
              calorieCounter = 450,
              carbPercent = 0.9,
              fatPercent = 0.05,
              proteinPercent = 0.05,
              costInPennies = 200,
              tags = new []{"Gluten", "Dairy" },
              recipe = "Call Jessica, have her make you a sandwich",
              minutesNeededBeforeMeal = 2,
              totalCookTime = 0,
              totalPrepTime = 2,
              ingredients = new[]
              {
                new IngredientInstance()
                {
                  ingredientId = 3,
                  Quantity = "2 slices"
                },
                new IngredientInstance()
                {
                  ingredientId = 4,
                  Quantity = "3 slices"
                },

              }

            }
          },
          new MealTime()
          {
            Day = 1,
            Hour = 17,
            Minute = 0,
            meal = new Meal()
            {
              name = "Turkey Dinner",
              calorieCounter = 450,
              carbPercent = 0.2,
              fatPercent = 0.3,
              proteinPercent = 0.5,
              costInPennies = 200,
              tags = new String[]{  },
              recipe = "Take turkey out of container,  place on plate",
              minutesNeededBeforeMeal = 2,
              totalCookTime = 0,
              totalPrepTime = 2,
              ingredients = new[]
              {
                new IngredientInstance()
                {
                  ingredientId = 4,
                  Quantity = "6 slices"
                },
              }

            }
          },


          new MealTime()
          {
            Day = 2,
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
          new MealTime()
          {
            Day = 2,
            Hour = 12,
            Minute = 30,
            meal = new Meal()
            {
              name = "Sandwich",
              calorieCounter = 450,
              carbPercent = 0.9,
              fatPercent = 0.05,
              proteinPercent = 0.05,
              costInPennies = 200,
              tags = new []{"Gluten", "Dairy" },
              recipe = "Call Jessica, have her make you a sandwich",
              minutesNeededBeforeMeal = 2,
              totalCookTime = 0,
              totalPrepTime = 2,
              ingredients = new[]
              {
                new IngredientInstance()
                {
                  ingredientId = 3,
                  Quantity = "2 slices"
                },
                new IngredientInstance()
                {
                  ingredientId = 4,
                  Quantity = "3 slices"
                },

              }

            }
          },
          new MealTime()
          {
            Day = 2,
            Hour = 17,
            Minute = 0,
            meal = new Meal()
            {
              name = "Turkey Dinner",
              calorieCounter = 450,
              carbPercent = 0.2,
              fatPercent = 0.3,
              proteinPercent = 0.5,
              costInPennies = 200,
              tags = new String[]{  },
              recipe = "Take turkey out of container,  place on plate",
              minutesNeededBeforeMeal = 2,
              totalCookTime = 0,
              totalPrepTime = 2,
              ingredients = new[]
              {
                new IngredientInstance()
                {
                  ingredientId = 4,
                  Quantity = "6 slices"
                },
              }

            }
          },


          new MealTime()
          {
            Day = 3,
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
          new MealTime()
          {
            Day = 3,
            Hour = 12,
            Minute = 30,
            meal = new Meal()
            {
              name = "Sandwich",
              calorieCounter = 450,
              carbPercent = 0.9,
              fatPercent = 0.05,
              proteinPercent = 0.05,
              costInPennies = 200,
              tags = new []{"Gluten", "Dairy" },
              recipe = "Call Jessica, have her make you a sandwich",
              minutesNeededBeforeMeal = 2,
              totalCookTime = 0,
              totalPrepTime = 2,
              ingredients = new[]
              {
                new IngredientInstance()
                {
                  ingredientId = 3,
                  Quantity = "2 slices"
                },
                new IngredientInstance()
                {
                  ingredientId = 4,
                  Quantity = "3 slices"
                },

              }

            }
          },
          new MealTime()
          {
            Day = 3,
            Hour = 17,
            Minute = 0,
            meal = new Meal()
            {
              name = "Turkey Dinner",
              calorieCounter = 450,
              carbPercent = 0.2,
              fatPercent = 0.3,
              proteinPercent = 0.5,
              costInPennies = 200,
              tags = new String[]{  },
              recipe = "Take turkey out of container,  place on plate",
              minutesNeededBeforeMeal = 2,
              totalCookTime = 0,
              totalPrepTime = 2,
              ingredients = new[]
              {
                new IngredientInstance()
                {
                  ingredientId = 4,
                  Quantity = "6 slices"
                },
              }

            }
          },


          new MealTime()
          {
            Day = 4,
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
          new MealTime()
          {
            Day = 4,
            Hour = 12,
            Minute = 30,
            meal = new Meal()
            {
              name = "Sandwich",
              calorieCounter = 450,
              carbPercent = 0.9,
              fatPercent = 0.05,
              proteinPercent = 0.05,
              costInPennies = 200,
              tags = new []{"Gluten", "Dairy" },
              recipe = "Call Jessica, have her make you a sandwich",
              minutesNeededBeforeMeal = 2,
              totalCookTime = 0,
              totalPrepTime = 2,
              ingredients = new[]
              {
                new IngredientInstance()
                {
                  ingredientId = 3,
                  Quantity = "2 slices"
                },
                new IngredientInstance()
                {
                  ingredientId = 4,
                  Quantity = "3 slices"
                },

              }

            }
          },
          new MealTime()
          {
            Day = 4,
            Hour = 17,
            Minute = 0,
            meal = new Meal()
            {
              name = "Turkey Dinner",
              calorieCounter = 450,
              carbPercent = 0.2,
              fatPercent = 0.3,
              proteinPercent = 0.5,
              costInPennies = 200,
              tags = new String[]{  },
              recipe = "Take turkey out of container,  place on plate",
              minutesNeededBeforeMeal = 2,
              totalCookTime = 0,
              totalPrepTime = 2,
              ingredients = new[]
              {
                new IngredientInstance()
                {
                  ingredientId = 4,
                  Quantity = "6 slices"
                },
              }

            }
          },


          new MealTime()
          {
            Day = 5,
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
          new MealTime()
          {
            Day = 5,
            Hour = 12,
            Minute = 30,
            meal = new Meal()
            {
              name = "Sandwich",
              calorieCounter = 450,
              carbPercent = 0.9,
              fatPercent = 0.05,
              proteinPercent = 0.05,
              costInPennies = 200,
              tags = new []{"Gluten", "Dairy" },
              recipe = "Call Jessica, have her make you a sandwich",
              minutesNeededBeforeMeal = 2,
              totalCookTime = 0,
              totalPrepTime = 2,
              ingredients = new[]
              {
                new IngredientInstance()
                {
                  ingredientId = 3,
                  Quantity = "2 slices"
                },
                new IngredientInstance()
                {
                  ingredientId = 4,
                  Quantity = "3 slices"
                },

              }

            }
          },
          new MealTime()
          {
            Day = 5,
            Hour = 17,
            Minute = 0,
            meal = new Meal()
            {
              name = "Turkey Dinner",
              calorieCounter = 450,
              carbPercent = 0.2,
              fatPercent = 0.3,
              proteinPercent = 0.5,
              costInPennies = 200,
              tags = new String[]{  },
              recipe = "Take turkey out of container,  place on plate",
              minutesNeededBeforeMeal = 2,
              totalCookTime = 0,
              totalPrepTime = 2,
              ingredients = new[]
              {
                new IngredientInstance()
                {
                  ingredientId = 4,
                  Quantity = "6 slices"
                },
              }

            }
          },


          new MealTime()
          {
            Day = 6,
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
          new MealTime()
          {
            Day = 6,
            Hour = 12,
            Minute = 30,
            meal = new Meal()
            {
              name = "Sandwich",
              calorieCounter = 450,
              carbPercent = 0.9,
              fatPercent = 0.05,
              proteinPercent = 0.05,
              costInPennies = 200,
              tags = new []{"Gluten", "Dairy" },
              recipe = "Call Jessica, have her make you a sandwich",
              minutesNeededBeforeMeal = 2,
              totalCookTime = 0,
              totalPrepTime = 2,
              ingredients = new[]
              {
                new IngredientInstance()
                {
                  ingredientId = 3,
                  Quantity = "2 slices"
                },
                new IngredientInstance()
                {
                  ingredientId = 4,
                  Quantity = "3 slices"
                },

              }

            }
          },
          new MealTime()
          {
            Day = 6,
            Hour = 17,
            Minute = 0,
            meal = new Meal()
            {
              name = "Turkey Dinner",
              calorieCounter = 450,
              carbPercent = 0.2,
              fatPercent = 0.3,
              proteinPercent = 0.5,
              costInPennies = 200,
              tags = new String[]{  },
              recipe = "Take turkey out of container,  place on plate",
              minutesNeededBeforeMeal = 2,
              totalCookTime = 0,
              totalPrepTime = 2,
              ingredients = new[]
              {
                new IngredientInstance()
                {
                  ingredientId = 4,
                  Quantity = "6 slices"
                },
              }

            }
          },

        }
      };
    }
  }
}
