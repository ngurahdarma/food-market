//
//  FavoriteDependencyInjection.swift
//  FoodMarket
//
//  Created by ngurah on 30/11/20.
//

import UIKit

extension DependencyInjection {
    static func favoriteViewController() -> UIViewController {
        let navController = UINavigationController()
        let viewModel = provideFavoriteViewModel()
        let router = DetailCategoryRouter()
        let viewController = FavoriteViewController(viewModel: viewModel, router: router)

        viewController.navigationItem.title = TitleName.favorite
        viewController.tabBarItem = UITabBarItem(
            title: TitleName.favorite,
            image: IconName.favorite.image,
            selectedImage: IconName.favorite.selectedImage
        )

        navController.viewControllers = [viewController]
        return navController
    }

    static func provideFavoriteUseCase() -> FavoriteUseCase {
        let repository = provideRepository()
        return FavoriteUseCase.shared(repository)
    }

    static func provideFavoriteViewModel() -> FavoriteViewModelContract {
        let useCase = provideFavoriteUseCase()
        return FavoriteViewModel(useCase: useCase)
    }
}
