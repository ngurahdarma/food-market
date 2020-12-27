//
//  Endpoint.swift
//  FoodMarket
//
//  Created by ngurah on 30/11/20.
//

struct Api {
    static private let baseUrl = "https://www.themealdb.com/api/json/"
    static private let jsonVersion = "v1/"
    static private let userKey = "1/"

    static let url = "\(Api.baseUrl)\(Api.jsonVersion)\(Api.userKey)"
}

enum Endpoint {
    case categories
    case detailCategory(String)
    case detailMeal(String)

    var url: String {
        switch self {
        case .categories: return "\(Api.url)categories.php"
        case .detailCategory(let category): return "\(Api.url)filter.php?c=\(category)"
        case .detailMeal(let idMeal): return "\(Api.url)lookup.php?i=\(idMeal)"
        }
    }
}
