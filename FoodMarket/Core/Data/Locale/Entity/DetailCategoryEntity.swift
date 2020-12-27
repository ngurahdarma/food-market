//
//  DetailCategoryEntity.swift
//  FoodMarket
//
//  Created by ngurah on 01/12/20.
//

import Foundation
import RealmSwift

class DetailCategoryEntity: Object {
    @objc dynamic var idMeal: String = ""
    @objc dynamic var meal: String = ""
    @objc dynamic var thumbnail: String = ""
    @objc dynamic var category: String = ""

    override class func primaryKey() -> String? {
        PrimaryKey.detailCategory
    }
}
