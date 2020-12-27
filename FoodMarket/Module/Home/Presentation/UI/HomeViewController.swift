//
//  HomeViewController.swift
//  FoodMarket
//
//  Created by ngurah on 30/11/20.
//

import UIKit
import RxSwift

class HomeViewController: UIViewController {
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!

    private let viewModel: HomeViewModelContract
    private let router: HomeRouterContract

    private let disposeBag = DisposeBag()

    private var model: [CategoryModel] = []

    init(viewModel: HomeViewModelContract, router: HomeRouterContract) {
        self.viewModel = viewModel
        self.router = router
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        setupTableView()
        setupLoadingObserver()
        setupModelObserver()
        loadData()
    }

    private func setupTableView() {
        tableView.delegate = self
        tableView.dataSource = self
        tableView.tableFooterView = UIView()

        tableView.register(
            UINib(nibName: CellName.homeCell, bundle: nil),
            forCellReuseIdentifier: CellName.homeCell
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
            self.tableView.reloadData()
        }, onError: { error in
            print(error.localizedDescription)
        }).disposed(by: disposeBag)
    }

    private func loadData() {
        viewModel.loadData()
    }
}

extension HomeViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return model.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: CellName.homeCell) as? HomeTableViewCell
        else {return UITableViewCell()}

        let item = model[indexPath.row]
        cell.parse(item)

        return cell
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let category = model[indexPath.row]
        tableView.deselectRow(at: indexPath, animated: true)
        router.toDetailCategory(self, category: category)
    }
}
