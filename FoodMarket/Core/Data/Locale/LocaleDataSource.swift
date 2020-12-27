//
//  LocaleDataSource.swift
//  FoodMarket
//
//  Created by ngurah on 01/12/20.
//

import RxSwift
import RealmSwift

protocol LocaleDataSourceContract {
    func getCategories() -> Observable<[CategoryEntity]>
    func addCategories(categories: [CategoryEntity]) -> Observable<Bool>

    func getDetailCategory(categoryName: String) -> Observable<[DetailCategoryEntity]>
    func addDetailCategory(categoryName: String, detailCategory: [DetailCategoryEntity]) -> Observable<Bool>

    func getDetailMeal(idMeal: String) -> Observable<[DetailMealEntity]>
    func addDetailMeal(idMeal: String, detailMeal: [DetailMealEntity]) -> Observable<Bool>

    func getFavorites() -> Observable<[FavoriteEntity]>
    func addFavorite(entity: FavoriteEntity) -> Observable<Bool>
    func deleteFavorite(idMeal: String) -> Observable<Bool>
    func checkFavorite(idMeal: String) -> Observable<Bool>
}

class LocaleDataSource {
    static let shared: (Realm?) -> LocaleDataSource = { realm in
        LocaleDataSource(realm: realm)
    }

    private let realm: Realm?

    private init(realm: Realm?) {
        self.realm = realm
    }
}

extension LocaleDataSource: LocaleDataSourceContract {
    func getCategories() -> Observable<[CategoryEntity]> {
        Observable<[CategoryEntity]>.create { observer in
            if let realm = self.realm {
                let categories: Results<CategoryEntity> = {
                    realm.objects(CategoryEntity.self)
                        .sorted(byKeyPath: PrimaryKey.category, ascending: true)
                }()

                observer.onNext(categories.toArray(ofType: CategoryEntity.self))
                observer.onCompleted()
            } else {
                observer.onError(LocaleError.invalidInstance)
            }

            return Disposables.create()
        }
    }

    func addCategories(categories: [CategoryEntity]) -> Observable<Bool> {
        Observable<Bool>.create { observer in
            if let realm = self.realm {
                do {
                    try realm.write {
                        categories.forEach {
                            realm.add($0, update: .all)
                        }

                        observer.onNext(true)
                        observer.onCompleted()
                    }
                } catch {
                    observer.onError(LocaleError.requestFailed)
                }
            } else {
                observer.onError(LocaleError.invalidInstance)
            }

            return Disposables.create()
        }
    }

    func getDetailCategory(categoryName: String) -> Observable<[DetailCategoryEntity]> {
        Observable<[DetailCategoryEntity]>.create { observer in
            if let realm = self.realm {
                let detailCategory: Results<DetailCategoryEntity> = {
                    let predicate = NSPredicate(format: "\(PredicateKey.detailCategory) == %@", categoryName)
                    return realm.objects(DetailCategoryEntity.self)
                        .filter(predicate)
                        .sorted(byKeyPath: PrimaryKey.detailCategory, ascending: true)
                }()

                observer.onNext(detailCategory.toArray(ofType: DetailCategoryEntity.self))
                observer.onCompleted()
            } else {
                observer.onError(LocaleError.invalidInstance)
            }

            return Disposables.create()
        }
    }

    func addDetailCategory(categoryName: String, detailCategory: [DetailCategoryEntity]) -> Observable<Bool> {
        Observable<Bool>.create { observer in
            if let realm = self.realm {
                do {
                    try realm.write {
                        detailCategory.forEach {
                            $0.category = categoryName
                            realm.add($0, update: .all)
                        }

                        observer.onNext(true)
                        observer.onCompleted()
                    }
                } catch {
                    observer.onError(LocaleError.requestFailed)
                }
            } else {
                observer.onError(LocaleError.invalidInstance)
            }

            return Disposables.create()
        }
    }

    func getDetailMeal(idMeal: String) -> Observable<[DetailMealEntity]> {
        Observable<[DetailMealEntity]>.create { observer in
            if let realm = self.realm {
                let detailMeal: Results<DetailMealEntity> = {
                    let predicate = NSPredicate(format: "\(PredicateKey.detailMeal) == %@", idMeal)
                    return realm.objects(DetailMealEntity.self)
                        .filter(predicate)
                        .sorted(byKeyPath: PrimaryKey.detailMeal, ascending: true)
                }()

                observer.onNext(detailMeal.toArray(ofType: DetailMealEntity.self))
                observer.onCompleted()
            } else {
                observer.onError(LocaleError.invalidInstance)
            }

            return Disposables.create()
        }
    }

    func addDetailMeal(idMeal: String, detailMeal: [DetailMealEntity]) -> Observable<Bool> {
        Observable<Bool>.create { observer in
            if let realm = self.realm {
                do {
                    try realm.write {
                        detailMeal.forEach {
                            $0.idMeal = idMeal
                            realm.add($0, update: .all)
                        }

                        observer.onNext(true)
                        observer.onCompleted()
                    }
                } catch {
                    observer.onError(LocaleError.requestFailed)
                }
            } else {
                observer.onError(LocaleError.invalidInstance)
            }

            return Disposables.create()
        }
    }

    func getFavorites() -> Observable<[FavoriteEntity]> {
        Observable<[FavoriteEntity]>.create { observer in
            if let realm = self.realm {
                let favorite: Results<FavoriteEntity> = {
                    realm.objects(FavoriteEntity.self)
                        .sorted(byKeyPath: "createdDate", ascending: false)
                }()

                observer.onNext(favorite.toArray(ofType: FavoriteEntity.self))
                observer.onCompleted()
            } else {
                observer.onError(LocaleError.invalidInstance)
            }

            return Disposables.create()
        }
    }

    func addFavorite(entity: FavoriteEntity) -> Observable<Bool> {
        Observable<Bool>.create { observer in
            if let realm = self.realm {
                do {
                    try realm.write {
                        realm.add(entity, update: .all)
                    }

                    observer.onNext(true)
                    observer.onCompleted()
                } catch {
                    observer.onError(LocaleError.requestFailed)
                }
            } else {
                observer.onError(LocaleError.invalidInstance)
            }

            return Disposables.create()
        }
    }

    func deleteFavorite(idMeal: String) -> Observable<Bool> {
        Observable<Bool>.create { observer in
            if let realm = self.realm {
                do {
                    let predicate = NSPredicate(format: "\(PredicateKey.favorite) == %@", idMeal)
                    let entity = realm.objects(FavoriteEntity.self)
                        .filter(predicate)
                        .first

                    try realm.write {
                        if let entity = entity {
                            realm.delete(entity)
                        }
                    }

                    observer.onNext(true)
                    observer.onCompleted()
                } catch {
                    observer.onError(LocaleError.requestFailed)
                }
            } else {
                observer.onError(LocaleError.invalidInstance)
            }

            return Disposables.create()
        }
    }

    func checkFavorite(idMeal: String) -> Observable<Bool> {
        Observable<Bool>.create { observer in
            if let realm = self.realm {
                let predicate = NSPredicate(format: "\(PredicateKey.favorite) == %@", idMeal)
                let favorite: Results<FavoriteEntity> = {
                    realm.objects(FavoriteEntity.self)
                        .filter(predicate)
                }()

                observer.onNext(!favorite.isEmpty)
                observer.onCompleted()
            } else {
                observer.onError(LocaleError.invalidInstance)
            }

            return Disposables.create()
        }
    }
}
