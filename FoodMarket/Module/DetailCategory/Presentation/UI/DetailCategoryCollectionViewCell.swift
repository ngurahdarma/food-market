//
//  DetailCategoryCollectionViewCell.swift
//  FoodMarket
//
//  Created by ngurah on 01/12/20.
//

import UIKit
import Nuke

class DetailCategoryCollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var imgThumbnail: UIImageView!
    @IBOutlet weak var lblMeal: UILabel!

    func parse(item: DetailCategoryModel) {
        lblMeal.text = item.meal

        if let url = URL(string: item.thumbnail) {
            Nuke.loadImage(with: url, into: imgThumbnail)
        }
    }
}
