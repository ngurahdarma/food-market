//
//  IconName.swift
//  FoodMarket
//
//  Created by ngurah on 30/11/20.
//

import UIKit

enum IconName {
    case home
    case favorite
    case profile

    var image: UIImage {
        switch self {
        case .home: return UIImage(systemName: "house.circle")!
        case .favorite: return UIImage(systemName: "bookmark.circle")!
        case .profile: return UIImage(systemName: "person.circle")!
        }
    }

    var selectedImage: UIImage {
        switch self {
        case .home: return UIImage(systemName: "house.fill")!
        case .favorite: return UIImage(systemName: "bookmark.fill")!
        case .profile: return UIImage(systemName: "person.fill")!
        }
    }
}
