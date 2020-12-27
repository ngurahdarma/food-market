//
//  Results+Ext.swift
//  FoodMarket
//
//  Created by ngurah on 01/12/20.
//

import RealmSwift

extension Results {
    func toArray<T>(ofType: T.Type) -> [T] {
        var array = [T]()

        for index in 0 ..< count {
            if let result = self[index] as? T {
                array.append(result)
            }
        }

        return array
    }
}
