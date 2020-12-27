//
//  DetailMealViewModel.swift
//  FoodMarket
//
//  Created by ngurah on 01/12/20.
//

import RxSwift

protocol DetailMealViewModelContract {
    var loadingObservable: BehaviorSubject<Bool> {get}
    var modelObservable: PublishSubject<[DetailMealModel]> {get}

    var favoriteObservable: BehaviorSubject<Bool> {get}

    func loadData(idMeal: String)

    func addFavorite(model: DetailCategoryModel)
    func deleteFavorite(idMeal: String)
    func checkFavorite(idMeal: String)
}

class DetailMealViewModel {
    var loadingObservable: BehaviorSubject<Bool> = BehaviorSubject(value: false)
    var modelObservable: PublishSubject<[DetailMealModel]> = PublishSubject<[DetailMealModel]>()

    var favoriteObservable: BehaviorSubject<Bool> = BehaviorSubject(value: false)

    private let useCase: DetailMealUseCaseContract

    private let disposeBag = DisposeBag()

    init(useCase: DetailMealUseCaseContract) {
        self.useCase = useCase
    }
}

extension DetailMealViewModel: DetailMealViewModelContract {
    func loadData(idMeal: String) {
        loadingObservable.on(.next(true))
        useCase.getDetailMeal(idMeal: idMeal)
            .subscribe { data in
                self.loadingObservable.on(.next(false))
                self.modelObservable.on(.next(data))
            } onError: { error in
                self.modelObservable.on(.error(error))
            }.disposed(by: disposeBag)
    }

    func addFavorite(model: DetailCategoryModel) {
        loadingObservable.on(.next(true))
        useCase.addFavorite(model: model)
            .subscribe(onNext: { _ in
                self.loadingObservable.on(.next(false))
                self.favoriteObservable.on(.next(true))
            }).disposed(by: disposeBag)
    }

    func deleteFavorite(idMeal: String) {
        loadingObservable.on(.next(true))
        useCase.deleteFavorite(idMeal: idMeal)
            .subscribe(onNext: { _ in
                self.loadingObservable.on(.next(false))
                self.favoriteObservable.on(.next(false))
            }).disposed(by: disposeBag)
    }

    func checkFavorite(idMeal: String) {
        loadingObservable.on(.next(true))
        useCase.checkFavorite(idMeal: idMeal)
            .subscribe(onNext: { data in
                self.loadingObservable.on(.next(false))
                self.favoriteObservable.on(.next(data))
            }).disposed(by: disposeBag)
    }
}
