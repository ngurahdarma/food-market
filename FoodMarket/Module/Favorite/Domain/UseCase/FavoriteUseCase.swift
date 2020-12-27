//
//  FavoriteUseCase.swift
//  FoodMarket
//
//  Created by ngurah on 02/12/20.
//

import RxSwift

protocol FavoriteUseCaseContract {
    func getFavorites() -> Observable<[DetailCategoryModel]>
}

class FavoriteUseCase {
    static let shared: (RepositoryContract) -> FavoriteUseCase = { repository in
        FavoriteUseCase(repository: repository)
    }

    private let repository: RepositoryContract

    private init(repository: RepositoryContract) {
        self.repository = repository
    }
}

extension FavoriteUseCase: FavoriteUseCaseContract {
    func getFavorites() -> Observable<[DetailCategoryModel]> {
        repository.getFavorites()
    }
}
