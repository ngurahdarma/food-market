//
//  ProfileDependencyInjection.swift
//  FoodMarket
//
//  Created by ngurah on 30/11/20.
//

import UIKit

extension DependencyInjection {
    static func profileViewController() -> UIViewController {
        let navController = UINavigationController()
        let viewController = ProfileViewController()

        viewController.navigationItem.title = TitleName.profile
        viewController.tabBarItem = UITabBarItem(
            title: TitleName.profile,
            image: IconName.profile.image,
            selectedImage: IconName.profile.selectedImage
        )

        navController.viewControllers = [viewController]
        return navController
    }
}
