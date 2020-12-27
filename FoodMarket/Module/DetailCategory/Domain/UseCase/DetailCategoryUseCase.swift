//
//  DetailCategoryUseCase.swift
//  FoodMarket
//
//  Created by ngurah on 01/12/20.
//

import RxSwift

protocol DetailCategoryUseCaseContract {
    func getDetailCategory(categoryName: String) -> Observable<[DetailCategoryModel]>
}

class DetailCategoryUseCase {
    static let shared: (RepositoryContract) -> DetailCategoryUseCase = { repository in
        DetailCategoryUseCase(repository: repository)
    }

    private let repository: RepositoryContract

    private init(repository: RepositoryContract) {
        self.repository = repository
    }
}

extension DetailCategoryUseCase: DetailCategoryUseCaseContract {
    func getDetailCategory(categoryName: String) -> Observable<[DetailCategoryModel]> {
        repository.getDetailCategory(categoryName: categoryName)
    }
}
