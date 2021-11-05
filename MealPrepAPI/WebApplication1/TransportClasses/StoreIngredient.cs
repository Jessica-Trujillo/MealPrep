//using Npgsql;
using System;

namespace WebApplication1.Controllers
{
  public class StoreIngredient
  {
    public int costInPennies { get; set; }
    public String quantity { get; set; }
    public String[] storeLinks { get; set; }
  }
}
