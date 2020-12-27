//
//  DetailMealResponse.swift
//  FoodMarket
//
//  Created by ngurah on 01/12/20.
//

struct DetailMealResponse: Decodable {
    let meal: String?
    let category: String?
    let area: String?
    let instruction: String?
    let thumbnail: String?

    private enum CodingKeys: String, CodingKey {
        case meal = "strMeal"
        case category = "strCategory"
        case area = "strArea"
        case instruction = "strInstructions"
        case thumbnail = "strMealThumb"
    }
}

struct DetailMealsResponse: Decodable {
    let meals: [DetailMealResponse]
}
