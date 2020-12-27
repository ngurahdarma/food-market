//
//  DetailCategoryDependencyInjection.swift
//  FoodMarket
//
//  Created by ngurah on 30/11/20.
//

import UIKit

extension DependencyInjection {
    static func detailCategoryViewController(category: CategoryModel) -> UIViewController {
        let viewModel = DependencyInjection.provideDetailCategoryViewModel()
        let router = DetailCategoryRouter()
        let viewController = DetailCategoryViewController(viewModel: viewModel, router: router, category: category)

        viewController.navigationItem.title = category.categoryName
        return viewController
    }

    static func provideDetailCategoryUseCase() -> DetailCategoryUseCase {
        let repository = provideRepository()
        return DetailCategoryUseCase.shared(repository)
    }

    static func provideDetailCategoryViewModel() -> DetailCategoryViewModelContract {
        let useCase = provideDetailCategoryUseCase()
        return DetailCategoryViewModel(useCase: useCase)
    }
}
