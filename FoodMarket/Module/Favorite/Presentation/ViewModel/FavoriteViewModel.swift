//
//  FavoriteViewModel.swift
//  FoodMarket
//
//  Created by ngurah on 02/12/20.
//

import RxSwift

protocol FavoriteViewModelContract {
    var loadingObservable: BehaviorSubject<Bool> {get}
    var modelObservable: PublishSubject<[DetailCategoryModel]> {get}

    func loadData()
}

class FavoriteViewModel {
    var loadingObservable: BehaviorSubject<Bool> = BehaviorSubject(value: false)
    var modelObservable: PublishSubject<[DetailCategoryModel]> = PublishSubject<[DetailCategoryModel]>()

    private let useCase: FavoriteUseCaseContract

    private let disposeBag = DisposeBag()

    init(useCase: FavoriteUseCase) {
        self.useCase = useCase
    }
}

extension FavoriteViewModel: FavoriteViewModelContract {
    func loadData() {
        loadingObservable.on(.next(true))
        useCase.getFavorites()
            .subscribe { data in
                self.loadingObservable.on(.next(false))
                self.modelObservable.on(.next(data))
            } onError: { error in
                self.modelObservable.on(.error(error))
            }.disposed(by: disposeBag)
    }
}
