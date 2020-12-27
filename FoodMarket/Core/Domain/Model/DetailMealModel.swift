//
//  DetailMealModel.swift
//  FoodMarket
//
//  Created by ngurah on 01/12/20.
//

struct DetailMealModel {
    let meal: String
    let category: String
    let area: String
    let instruction: String
    let thumbnail: String
}

struct DetailMealsModel {
    let meals: [DetailMealModel]
}
