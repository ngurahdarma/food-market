//
//  DetailCategoryRouter.swift
//  FoodMarket
//
//  Created by ngurah on 01/12/20.
//

import UIKit

protocol DetailCategoryRouterContract {
    func toDetailMeal(_ sender: UIViewController, detailCategory: DetailCategoryModel)
}

class DetailCategoryRouter: DetailCategoryRouterContract {
    func toDetailMeal(_ sender: UIViewController, detailCategory: DetailCategoryModel) {
        let detailVC = DependencyInjection.detailMealViewController(detailCategory: detailCategory)
        sender.navigationController?.pushViewController(detailVC, animated: true)
    }
}
