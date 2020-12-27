//
//  DetailMealEntity.swift
//  FoodMarket
//
//  Created by ngurah on 01/12/20.
//

import Foundation
import RealmSwift

class DetailMealEntity: Object {
    @objc dynamic var meal: String = ""
    @objc dynamic var category: String = ""
    @objc dynamic var area: String = ""
    @objc dynamic var instruction: String = ""
    @objc dynamic var thumbnail: String = ""
    @objc dynamic var idMeal: String = ""

    override class func primaryKey() -> String? {
        PrimaryKey.detailMeal
    }
}
