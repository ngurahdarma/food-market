//
//  DetailCategoryViewModel.swift
//  FoodMarket
//
//  Created by ngurah on 01/12/20.
//

import RxSwift

protocol DetailCategoryViewModelContract {
    var loadingObservable: BehaviorSubject<Bool> {get}
    var modelObservable: PublishSubject<[DetailCategoryModel]> {get}

    func loadData(categoryName: String)
}

class DetailCategoryViewModel {
    var loadingObservable: BehaviorSubject<Bool> = BehaviorSubject(value: false)
    var modelObservable: PublishSubject<[DetailCategoryModel]> = PublishSubject<[DetailCategoryModel]>()

    private let useCase: DetailCategoryUseCase

    private let disposeBag = DisposeBag()

    init(useCase: DetailCategoryUseCase) {
        self.useCase = useCase
    }
}

extension DetailCategoryViewModel: DetailCategoryViewModelContract {
    func loadData(categoryName: String) {
        loadingObservable.on(.next(true))
        useCase.getDetailCategory(categoryName: categoryName)
            .subscribe { data in
                self.loadingObservable.on(.next(false))
                self.modelObservable.on(.next(data))
            } onError: { error in
                self.modelObservable.on(.error(error))
            }.disposed(by: disposeBag)
    }
}
