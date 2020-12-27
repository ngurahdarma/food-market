//
//  RemoteDataSource.swift
//  FoodMarket
//
//  Created by ngurah on 30/11/20.
//

import Foundation
import RxSwift
import Alamofire

protocol RemoteDataSourceContract {
    func getCategories() -> Observable<[CategoryResponse]>
    func getDetailCategory(categoryName: String) -> Observable<[DetailCategoryResponse]>
    func getDetailMeal(idMeal: String) -> Observable<[DetailMealResponse]>
}

class RemoteDataSource {
    static let shared = RemoteDataSource()
}

extension RemoteDataSource: RemoteDataSourceContract {
    func getCategories() -> Observable<[CategoryResponse]> {
        Observable<[CategoryResponse]>.create { observer in
            let urlString = Endpoint.categories.url

            if let url = URL(string: urlString) {
                AF.request(url)
                    .validate()
                    .responseDecodable(of: CategoriesResponse.self) { response in
                        switch response.result {
                        case .success(let categories):
                            observer.onNext(categories.categories)
                            observer.onCompleted()
                        case .failure:
                            observer.onError(RemoteError.invalidResponse)
                        }
                    }
            } else {
                observer.onError(RemoteError.addressUnreachable(urlString))
            }

            return Disposables.create()
        }
    }

    func getDetailCategory(categoryName: String) -> Observable<[DetailCategoryResponse]> {
        Observable<[DetailCategoryResponse]>.create { observer in
            let urlString = Endpoint.detailCategory(categoryName).url

            if let url = URL(string: urlString) {
                AF.request(url)
                    .validate()
                    .responseDecodable(of: DetailCategoriesResponse.self) { response in
                        switch response.result {
                        case .success(let detailCategories):
                            observer.onNext(detailCategories.meals)
                            observer.onCompleted()
                        case .failure:
                            observer.onError(RemoteError.invalidResponse)
                        }
                    }
            } else {
                observer.onError(RemoteError.addressUnreachable(urlString))
            }

            return Disposables.create()
        }
    }

    func getDetailMeal(idMeal: String) -> Observable<[DetailMealResponse]> {
        Observable<[DetailMealResponse]>.create { observer in
            let urlString = Endpoint.detailMeal(idMeal).url

            if let url = URL(string: urlString) {
                AF.request(url)
                    .validate()
                    .responseDecodable(of: DetailMealsResponse.self) { response in
                        switch response.result {
                        case .success(let detailMeal):
                            observer.onNext(detailMeal.meals)
                            observer.onCompleted()
                        case .failure:
                            observer.onError(RemoteError.invalidResponse)
                        }
                    }
            } else {
                observer.onError(RemoteError.addressUnreachable(urlString))
            }

            return Disposables.create()
        }
    }
}
