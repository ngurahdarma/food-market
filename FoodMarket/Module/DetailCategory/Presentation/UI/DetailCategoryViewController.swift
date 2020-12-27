//
//  DetailCategoryViewController.swift
//  FoodMarket
//
//  Created by ngurah on 30/11/20.
//

import UIKit
import RxSwift

class DetailCategoryViewController: UIViewController {
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!

    private let viewModel: DetailCategoryViewModelContract
    private let router: DetailCategoryRouterContract
    private let category: CategoryModel

    private var model: [DetailCategoryModel] = []

    private let disposeBag = DisposeBag()

    init(
        viewModel: DetailCategoryViewModelContract,
        router: DetailCategoryRouterContract,
        category: CategoryModel
    ) {
        self.viewModel = viewModel
        self.router = router
        self.category = category
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        setupCollectionView()
        setupLoadingObserver()
        setupModelObserver()
        loadData()
    }

    private func setupCollectionView() {
        collectionView.delegate = self
        collectionView.dataSource = self

        collectionView.register(
            UINib(nibName: CellName.detailCategoryCell, bundle: nil),
            forCellWithReuseIdentifier: CellName.detailCategoryCell
        )
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
            self.collectionView.reloadData()
        }, onError: { error in
            print(error.localizedDescription)
        }).disposed(by: disposeBag)
    }

    private func loadData() {
        viewModel.loadData(categoryName: category.categoryName)
    }
}

extension DetailCategoryViewController: UICollectionViewDelegate, UICollectionViewDataSource,
                                        UICollectionViewDelegateFlowLayout {
    func collectionView(
        _ collectionView: UICollectionView,
        layout collectionViewLayout: UICollectionViewLayout,
        sizeForItemAt indexPath: IndexPath
    ) -> CGSize {
        let cellPerRow: CGFloat = 2
        let length = (collectionView.bounds.width - (cellPerRow - 2)) / cellPerRow
        return CGSize(width: length, height: length)
    }

    func collectionView(
        _ collectionView: UICollectionView,
        numberOfItemsInSection section: Int
    ) -> Int {
        return model.count
    }

    func collectionView(
        _ collectionView: UICollectionView,
        cellForItemAt indexPath: IndexPath
    ) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(
            withReuseIdentifier: CellName.detailCategoryCell,
            for: indexPath
        ) as? DetailCategoryCollectionViewCell
        else {return UICollectionViewCell()}

        let item = model[indexPath.row]
        cell.parse(item: item)

        return cell
    }

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let detailCategory = model[indexPath.row]
        collectionView.deselectItem(at: indexPath, animated: true)
        router.toDetailMeal(self, detailCategory: detailCategory)
    }
}
