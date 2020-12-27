//
//  DetailMealUseCase.swift
//  FoodMarket
//
//  Created by ngurah on 01/12/20.
//

import RxSwift

protocol DetailMealUseCaseContract {
    func getDetailMeal(idMeal: String) -> Observable<[DetailMealModel]>

    func addFavorite(model: DetailCategoryModel) -> Observable<Bool>
    func deleteFavorite(idMeal: String) -> Observable<Bool>
    func checkFavorite(idMeal: String) -> Observable<Bool>
}

class DetailMealUseCase {
    static let shared: (RepositoryContract) -> DetailMealUseCase = { repository in
        DetailMealUseCase(repository: repository)
    }

    private let repository: RepositoryContract

    private init(repository: RepositoryContract) {
        self.repository = repository
    }
}

extension DetailMealUseCase: DetailMealUseCaseContract {
    func getDetailMeal(idMeal: String) -> Observable<[DetailMealModel]> {
        repository.getDetailMeal(idMeal: idMeal)
    }

    func addFavorite(model: DetailCategoryModel) -> Observable<Bool> {
        repository.addFavorite(model: model)
    }

    func deleteFavorite(idMeal: String) -> Observable<Bool> {
        repository.deleteFavorite(idMeal: idMeal)
    }

    func checkFavorite(idMeal: String) -> Observable<Bool> {
        repository.checkFavorite(idMeal: idMeal)
    }
}
