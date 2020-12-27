//
//  CategoryEntity.swift
//  FoodMarket
//
//  Created by ngurah on 01/12/20.
//

import Foundation
import RealmSwift

class CategoryEntity: Object {
    @objc dynamic var categoryName: String = ""
    @objc dynamic var thumbnail: String = ""
    @objc dynamic var descriptions: String = ""

    override class func primaryKey() -> String? {
        PrimaryKey.category
    }
}
