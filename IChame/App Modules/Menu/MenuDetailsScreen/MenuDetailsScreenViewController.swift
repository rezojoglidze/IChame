//
//  MenuDetailsScreenViewController.swift
//  IChame
//
//  Created by Rezo Joglidze on 3/19/21.
//  Copyright © 2021 Rezo Joglidze. All rights reserved.
//

import UIKit
import XCoordinator

class MenuDetailsScreenViewController: UIViewController {
    
    var viewModel: MenuDetailsScreenViewModel!
    
    @IBOutlet weak var tableView: UITableView!
    
    static func instantiate(strongRouter: StrongRouter<MenuRoute>, menuItems: [MenuItem]) -> Self {
        let viewController = ScreensAssembly.shared.container.resolve(Self.self, arguments: strongRouter, menuItems) ?? .init()
        return viewController
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavigationBar()
        setupTableView()
    }
    
    private func setupNavigationBar() {
        navigationItem.title = "დეტალები"
        navigationItem.largeTitleDisplayMode = .never
    }
    
    private func setupTableView() {
        tableView.register(UINib(nibName: String(describing: MenuDetailsTableViewCell.self), bundle: nil), forCellReuseIdentifier: String(describing: MenuDetailsTableViewCell.self))
        tableView.tableFooterView = UIView()
        tableView.dataSource = self
        tableView.delegate = self
    }
}

extension MenuDetailsScreenViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.numberOfRows()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: MenuDetailsTableViewCell.self)) as! MenuDetailsTableViewCell
        if let item = viewModel.item(at: indexPath) {
            cell.fill(item: item)
        }
        return cell
    }
}
