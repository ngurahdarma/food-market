//
//  HomeDependencyInjection.swift
//  FoodMarket
//
//  Created by ngurah on 30/11/20.
//

import UIKit

extension DependencyInjection {
    static func homeViewController() -> UIViewController {
        let navController = UINavigationController()
        let viewModel = provideHomeViewModel()
        let router = HomeRouter()
        let viewController = HomeViewController(viewModel: viewModel, router: router)

        viewController.navigationItem.title = TitleName.home
        viewController.tabBarItem = UITabBarItem(
            title: TitleName.home,
            image: IconName.home.image,
            selectedImage: IconName.home.selectedImage
        )

        navController.viewControllers = [viewController]
        return navController
    }

    static func provideHomeUseCase() -> HomeUseCaseContract {
        let repository = provideRepository()
        return HomeUseCase.shared(repository)
    }

    static func provideHomeViewModel() -> HomeViewModelContract {
        let useCase = provideHomeUseCase()
        return HomeViewModel(useCase: useCase)
    }
}
