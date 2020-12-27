//
//  DetailMealDependencyInjection.swift
//  FoodMarket
//
//  Created by ngurah on 01/12/20.
//

import UIKit

extension DependencyInjection {
    static func detailMealViewController(detailCategory: DetailCategoryModel) -> UIViewController {
        let viewModel = provideDetailMealViewModel()
        let viewController = DetailMealViewController(viewModel: viewModel, detailCategory: detailCategory)

        viewController.navigationItem.title = TitleName.detail
        viewController.navigationItem.rightBarButtonItems = [
            UIBarButtonItem(
                image: IconName.favorite.image,
                style: .plain,
                target: viewController,
                action: #selector(viewController.menuFavoriteTapped)
            )
        ]

        return viewController
    }

    static func provideDetailMealUseCase() -> DetailMealUseCaseContract {
        let repository = provideRepository()
        return DetailMealUseCase.shared(repository)
    }

    static func provideDetailMealViewModel() -> DetailMealViewModelContract {
        let useCase = provideDetailMealUseCase()
        return DetailMealViewModel(useCase: useCase)
    }
}
