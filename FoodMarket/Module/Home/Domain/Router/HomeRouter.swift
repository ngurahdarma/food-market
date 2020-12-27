//
//  HomeRouter.swift
//  FoodMarket
//
//  Created by ngurah on 30/11/20.
//

import UIKit

protocol HomeRouterContract {
    func toDetailCategory(_ sender: UIViewController, category: CategoryModel)
}

class HomeRouter: HomeRouterContract {
    func toDetailCategory(_ sender: UIViewController, category: CategoryModel) {
        let detailVC = DependencyInjection.detailCategoryViewController(category: category)
        sender.navigationController?.pushViewController(detailVC, animated: true)
    }
}
