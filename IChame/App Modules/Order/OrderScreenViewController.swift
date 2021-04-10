//
//  OrdersViewController.swift
//  IChame
//
//  Created by Rezo Joglidze on 4/10/21.
//  Copyright © 2021 Rezo Joglidze. All rights reserved.
//

import UIKit
import XCoordinator
import RxSwift

class OrderScreenViewController: UIViewController {
    
    var viewModel: OrderScreenViewModelProtocol!
    private var disposeBag = DisposeBag()
  lazy var refreshControl = UIRefreshControl()

    @IBOutlet private weak var tableView: UITableView!
    
    static func instantiate(strongRouter: StrongRouter<OrderRoute>) -> Self {
        let viewController = ScreensAssembly.shared.container.resolve(Self.self, argument: strongRouter) ?? .init()
        return viewController
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavigationBar()
        setupObservables()
        setupTableView()
        self.startLoader()
        viewModel.loadOrder(fail: self.standardFailBlock)
    }
    
    private func setupNavigationBar() {
        navigationItem.title = "შეკვეთები"
        navigationController?.navigationBar.prefersLargeTitles = true
    }
    
    private func setupObservables() {
        viewModel.orderDidLoaded.subscribe(onNext: { [weak self] _ in
            self?.tableView.reloadData()
            self?.stopLoader()
            self?.refreshControl.endRefreshing()
        }).disposed(by: disposeBag)
        
        viewModel.showLoader.subscribe(onNext: { [weak self] show in
            show ? self?.startLoader() : self?.stopLoader()
        }).disposed(by: disposeBag)
    }
    private func setupTableView() {
        tableView.register(UINib(nibName: String(describing: OrderScreenTableViewCell.self), bundle: nil), forCellReuseIdentifier: String(describing: OrderScreenTableViewCell.self))
        tableView.tableFooterView = UIView()
        tableView.dataSource = self
        tableView.delegate = self
        tableView.addSubview(refreshControl)
        refreshControl.addTarget(self, action: #selector(refreshOrders(_:)), for: .valueChanged)
    }
    
    @objc private func refreshOrders(_ sender: Any) {
        viewModel.loadOrder(fail: self.standardFailBlock)
    }
}

extension OrderScreenViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.numberOfRowsInSection()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: OrderScreenTableViewCell.self)) as! OrderScreenTableViewCell
        if let item = viewModel.item(at: indexPath) {
            cell.fill(order: item, index: indexPath.row)
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let cell = tableView.cellForRow(at: indexPath) else { return }
        cell.setSelected(false, animated: true)
        viewModel.openMenuDetails(with: indexPath)
    }
}
