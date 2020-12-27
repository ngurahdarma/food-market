//
//  HomeUseCase.swift
//  FoodMarket
//
//  Created by ngurah on 30/11/20.
//

import RxSwift

protocol HomeUseCaseContract {
    func getCategories() -> Observable<[CategoryModel]>
}

class HomeUseCase {
    static let shared: (RepositoryContract) -> HomeUseCaseContract = { repository in
        HomeUseCase(repository: repository)
    }

    private let repository: RepositoryContract

    private init(repository: RepositoryContract) {
        self.repository = repository
    }
}

extension HomeUseCase: HomeUseCaseContract {
    func getCategories() -> Observable<[CategoryModel]> {
        repository.getCategories()
    }
}
