import Foundation

public extension ApiClient {
  static var previewValue = ApiClient(
    fetchAllMeals: { _ in
//      try JSONDecoder().decode(
//        [ApiClient.Meal].self,
//        from: ApiClient.Meal.json.data(using: .utf8).unsafelyUnwrapped
//      )
      [.previewValue]
    },
    fetchMealDetailsById: { _ in
      [.previewValue]
//      try JSONDecoder().decode(
//        [ApiClient.MealDetails].self,
//        from: ApiClient.MealDetails.json.data(using: .utf8).unsafelyUnwrapped
//      )
    }
  )
}


// MARK: - Private Extensions

private extension ApiClient.Meal {
  static var json = """
  {
    "meals": [
      {
        "strMeal": "Apple & Blackberry Crumble",
        "strMealThumb": "https://www.themealdb.com/images/media/meals/xvsurr1511719182.jpg",
        "idMeal": "52893"
      },
      {
        "strMeal": "Banana Pancakes",
        "strMealThumb": "https://www.themealdb.com/images/media/meals/sywswr1511383814.jpg",
        "idMeal": "52855"
      },
      {
        "strMeal": "Carrot Cake",
        "strMealThumb": "https://www.themealdb.com/images/media/meals/vrspxv1511722107.jpg",
        "idMeal": "52897"
      },
      {
        "strMeal": "Dundee cake",
        "strMealThumb": "https://www.themealdb.com/images/media/meals/wxyvqq1511723401.jpg",
        "idMeal": "52899"
      },
      {
        "strMeal": "Eccles Cakes",
        "strMealThumb": "https://www.themealdb.com/images/media/meals/wtqrqw1511639627.jpg",
        "idMeal": "52888"
      }
    ]
  }
  """
}


private extension ApiClient.MealDetails {
  static var json = """
  {
    "meals": [
      {
        "idMeal": "52893",
        "strMeal": "Apple & Blackberry Crumble",
        "strDrinkAlternate": null,
        "strCategory": "Dessert",
        "strArea": "British",
        "strInstructions": "Heat oven to 190C/170C fan/gas 5. Tip the flour and sugar into a large bowl. Add the butter, then rub into the flour using your fingertips to make a light breadcrumb texture. Do not overwork it or the crumble will become heavy. Sprinkle the mixture evenly over a baking sheet and bake for 15 mins or until lightly coloured.\r\nMeanwhile, for the compote, peel, core and cut the apples into 2cm dice. Put the butter and sugar in a medium saucepan and melt together over a medium heat. Cook for 3 mins until the mixture turns to a light caramel. Stir in the apples and cook for 3 mins. Add the blackberries and cinnamon, and cook for 3 mins more. Cover, remove from the heat, then leave for 2-3 mins to continue cooking in the warmth of the pan.\r\nTo serve, spoon the warm fruit into an ovenproof gratin dish, top with the crumble mix, then reheat in the oven for 5-10 mins. Serve with vanilla ice cream.",
        "strMealThumb": "https://www.themealdb.com/images/media/meals/xvsurr1511719182.jpg",
        "strTags": "Pudding",
        "strYoutube": "https://www.youtube.com/watch?v=4vhcOwVBDO4",
        "strIngredient1": "Plain Flour",
        "strIngredient2": "Caster Sugar",
        "strMeasure1": "120g",
        "strMeasure2": "60g",
        "strSource": "https://www.bbcgoodfood.com/recipes/778642/apple-and-blackberry-crumble",
        "strImageSource": null,
        "strCreativeCommonsConfirmed": null,
        "dateModified": null
      }
    ]
  }
  """
}
