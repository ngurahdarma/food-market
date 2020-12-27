//
//  DependencyInjection.swift
//  FoodMarket
//
//  Created by ngurah on 30/11/20.
//

import UIKit
import RealmSwift

struct DependencyInjection {
    static func rootViewController() -> UIViewController {
        let tabController = UITabBarController()
        tabController.viewControllers = [
            DependencyInjection.homeViewController(),
            DependencyInjection.favoriteViewController(),
            DependencyInjection.profileViewController()
        ]

        return tabController
    }

    static func provideRepository() -> RepositoryContract {
        let realm = try? Realm()
        let locale = LocaleDataSource.shared(realm)
        let remote = RemoteDataSource.shared

        return Repository.shared(locale, remote)
    }
}
