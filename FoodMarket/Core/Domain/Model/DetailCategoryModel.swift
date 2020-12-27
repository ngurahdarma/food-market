//
//  DetailCategoryModel.swift
//  FoodMarket
//
//  Created by ngurah on 01/12/20.
//

struct DetailCategoryModel {
    let idMeal: String
    let meal: String
    let thumbnail: String
}

struct DetailCategoriesModel {
    let meals: [DetailCategoryModel]
}
