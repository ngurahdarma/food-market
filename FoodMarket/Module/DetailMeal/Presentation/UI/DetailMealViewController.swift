//
//  DetailMealViewController.swift
//  FoodMarket
//
//  Created by ngurah on 01/12/20.
//

import UIKit
import RxSwift
import Nuke

class DetailMealViewController: UIViewController {
    @IBOutlet weak var imgThumbnail: UIImageView!
    @IBOutlet weak var lblMeal: UILabel!
    @IBOutlet weak var lblCategoryArea: UILabel!
    @IBOutlet weak var txtInstruction: UITextView!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    @IBOutlet weak var imgFavorite: UIImageView!

    private let viewModel: DetailMealViewModelContract
    private let detailCategory: DetailCategoryModel

    private var model: [DetailMealModel] = []

    private let disposeBag = DisposeBag()

    init(
        viewModel: DetailMealViewModelContract,
        detailCategory: DetailCategoryModel
    ) {
        self.viewModel = viewModel
        self.detailCategory = detailCategory
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        setupLoadingObserver()
        setupModelObserver()
        setupFavoriteObserver()
        loadData()
    }

    private func setupLoadingObserver() {
        viewModel.loadingObservable.subscribe(onNext: { isLoading in
            if isLoading {
                self.activityIndicator.startAnimating()
            } else {
                self.activityIndicator.stopAnimating()
            }
        }).disposed(by: disposeBag)
    }

    private func setupModelObserver() {
        viewModel.modelObservable.subscribe(onNext: { data in
            self.model = data
            self.showData()
        }, onError: { error in
            print(error.localizedDescription)
        }).disposed(by: disposeBag)
    }

    private func setupFavoriteObserver() {
        viewModel.favoriteObservable.subscribe(onNext: { data in
            self.imgFavorite.isHidden = !data
        }).disposed(by: disposeBag)
    }

    private func loadData() {
        clearScreen()
        viewModel.loadData(idMeal: detailCategory.idMeal)
        viewModel.checkFavorite(idMeal: detailCategory.idMeal)
    }

    private func clearScreen() {
        imgThumbnail.image = nil
        lblMeal.text = ""
        lblCategoryArea.text = ""
        txtInstruction.text = ""
    }

    private func showData() {
        let data = model[0]

        if let url = URL(string: data.thumbnail) {
            Nuke.loadImage(with: url, into: imgThumbnail)
        }

        lblMeal.text = data.meal
        lblCategoryArea.text = "\(data.category) | \(data.area)"
        txtInstruction.text = data.instruction
    }

    @objc
    func menuFavoriteTapped() {
        if imgFavorite.isHidden {
            viewModel.addFavorite(model: detailCategory)
        } else {
            viewModel.deleteFavorite(idMeal: detailCategory.idMeal)
        }
    }
}
