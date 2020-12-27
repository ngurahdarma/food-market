//
//  HomeViewModel.swift
//  FoodMarket
//
//  Created by ngurah on 30/11/20.
//

import RxSwift

protocol HomeViewModelContract {
    var loadingObservable: BehaviorSubject<Bool> {get}
    var modelObservable: PublishSubject<[CategoryModel]> {get}

    func loadData()
}

class HomeViewModel {
    var loadingObservable: BehaviorSubject<Bool> = BehaviorSubject(value: false)
    var modelObservable: PublishSubject<[CategoryModel]> = PublishSubject<[CategoryModel]>()

    private let useCase: HomeUseCaseContract

    private let disposeBag = DisposeBag()

    init(useCase: HomeUseCaseContract) {
        self.useCase = useCase
    }
}

extension HomeViewModel: HomeViewModelContract {
    func loadData() {
        loadingObservable.on(.next(true))
        useCase.getCategories()
            .subscribe { data in
                self.loadingObservable.on(.next(false))
                self.modelObservable.on(.next(data))
            } onError: { error in
                self.modelObservable.on(.error(error))
            }.disposed(by: disposeBag)
    }
}
