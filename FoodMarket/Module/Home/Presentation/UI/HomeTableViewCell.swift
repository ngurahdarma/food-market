//
//  HomeTableViewCell.swift
//  FoodMarket
//
//  Created by ngurah on 30/11/20.
//

import UIKit
import Nuke

class HomeTableViewCell: UITableViewCell {
    @IBOutlet weak var imgThumbnail: UIImageView!
    @IBOutlet weak var lblCategory: UILabel!
    @IBOutlet weak var lblDescription: UILabel!

    func parse(_ item: CategoryModel) {
        lblCategory.text = item.categoryName
        lblDescription.text = item.descriptions

        if let url = URL(string: item.thumbnail) {
            Nuke.loadImage(with: url, into: imgThumbnail)
        }
    }
}
