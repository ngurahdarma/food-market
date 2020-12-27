//
//  Repository.swift
//  FoodMarket
//
//  Created by ngurah on 30/11/20.
//

import RxSwift

protocol RepositoryContract {
    func getCategories() -> Observable<[CategoryModel]>
    func getDetailCategory(categoryName: String) -> Observable<[DetailCategoryModel]>
    func getDetailMeal(idMeal: String) -> Observable<[DetailMealModel]>

    func getFavorites() -> Observable<[DetailCategoryModel]>
    func addFavorite(model: DetailCategoryModel) -> Observable<Bool>
    func deleteFavorite(idMeal: String) -> Observable<Bool>
    func checkFavorite(idMeal: String) -> Observable<Bool>
}

class Repository {
    typealias Instance = (LocaleDataSourceContract, RemoteDataSourceContract) -> RepositoryContract

    static let shared: Instance = { locale, remote in
        Repository(locale: locale, remote: remote)
    }

    private let locale: LocaleDataSourceContract
    private let remote: RemoteDataSourceContract

    private init(locale: LocaleDataSourceContract, remote: RemoteDataSourceContract) {
        self.locale = locale
        self.remote = remote
    }
}

extension Repository: RepositoryContract {
    func getCategories() -> Observable<[CategoryModel]> {
        locale.getCategories()
            .map {LocaleMapper.mapCategoryEntityToModel(input: $0)}
            .filter {!$0.isEmpty}
            .ifEmpty(
                switchTo: self.remote.getCategories()
                    .map {RemoteMapper.mapCategoryResponseToEntity(input: $0)}
                    .flatMap {self.locale.addCategories(categories: $0)}
                    .flatMap { _ in self.locale.getCategories()
                        .map {LocaleMapper.mapCategoryEntityToModel(input: $0)}
                    }
            )
    }

    func getDetailCategory(categoryName: String) -> Observable<[DetailCategoryModel]> {
        locale.getDetailCategory(categoryName: categoryName)
            .map {LocaleMapper.mapDetailCategoryEntityToModel(input: $0)}
            .filter {!$0.isEmpty}
            .ifEmpty(
                switchTo: self.remote.getDetailCategory(categoryName: categoryName)
                    .map {RemoteMapper.mapDetailCategoryResponseToEntity(input: $0)}
                    .flatMap {self.locale.addDetailCategory(categoryName: categoryName, detailCategory: $0)}
                    .flatMap { _ in self.locale.getDetailCategory(categoryName: categoryName)
                        .map {LocaleMapper.mapDetailCategoryEntityToModel(input: $0)}
                    }
            )
    }

    func getDetailMeal(idMeal: String) -> Observable<[DetailMealModel]> {
        locale.getDetailMeal(idMeal: idMeal)
            .map {LocaleMapper.mapDetailMealEntityToModel(input: $0)}
            .filter {!$0.isEmpty}
            .ifEmpty(
                switchTo: self.remote.getDetailMeal(idMeal: idMeal)
                    .map {RemoteMapper.mapDetailMealResponseToEntity(input: $0)}
                    .flatMap {self.locale.addDetailMeal(idMeal: idMeal, detailMeal: $0)}
                    .flatMap { _ in self.locale.getDetailMeal(idMeal: idMeal)
                        .map {LocaleMapper.mapDetailMealEntityToModel(input: $0)}
                    }
            )
    }

    func getFavorites() -> Observable<[DetailCategoryModel]> {
        locale.getFavorites()
            .map {LocaleMapper.mapFavoriteEntityToDetailCategoryModel(input: $0)}
    }

    func addFavorite(model: DetailCategoryModel) -> Observable<Bool> {
        let entity = LocaleMapper.mapDetailCategoryModelToFavoriteEntity(input: model)
        return locale.addFavorite(entity: entity)
    }

    func deleteFavorite(idMeal: String) -> Observable<Bool> {
        locale.deleteFavorite(idMeal: idMeal)
    }

    func checkFavorite(idMeal: String) -> Observable<Bool> {
        locale.checkFavorite(idMeal: idMeal)
    }
}
