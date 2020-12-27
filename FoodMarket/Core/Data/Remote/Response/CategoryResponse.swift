//
//  CategoryResponse.swift
//  FoodMarket
//
//  Created by ngurah on 30/11/20.
//

struct CategoryResponse: Decodable {
    let categoryName: String?
    let thumbnail: String?
    let descriptions: String?

    private enum CodingKeys: String, CodingKey {
        case categoryName = "strCategory"
        case thumbnail = "strCategoryThumb"
        case descriptions = "strCategoryDescription"
    }
}

struct CategoriesResponse: Decodable {
    let categories: [CategoryResponse]
}
