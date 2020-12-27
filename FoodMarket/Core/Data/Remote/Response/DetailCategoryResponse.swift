//
//  DetailCategoryResponse.swift
//  FoodMarket
//
//  Created by ngurah on 30/11/20.
//

struct DetailCategoryResponse: Decodable {
    let idMeal: String?
    let meal: String?
    let thumbnail: String?

    private enum CodingKeys: String, CodingKey {
        case idMeal
        case meal = "strMeal"
        case thumbnail = "strMealThumb"
    }
}

struct DetailCategoriesResponse: Decodable {
    let meals: [DetailCategoryResponse]
}
