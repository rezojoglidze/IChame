//
//  HomeScreenViewController.swift
//  IChame
//
//  Created by Rezo Joglidze on 3/18/21.
//  Copyright © 2021 Rezo Joglidze. All rights reserved.
//

import UIKit
import XCoordinator

class MenuScreenViewController: UIViewController {
    
    var viewModel: MenuScreenViewModelProtocol!
    
    @IBOutlet private weak var tableView: UITableView!
    
    static func instantiate(strongRouter: StrongRouter<MenuRoute>) -> Self {
        let viewController = ScreensAssembly.shared.container.resolve(Self.self, argument: strongRouter) ?? .init()
        return viewController
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationController?.isNavigationBarHidden = true
    }
    
    private func setupTableView() {
        tableView.register(UINib(nibName: String(describing: MenuScreenCell.self), bundle: nil), forCellReuseIdentifier: String(describing: MenuScreenCell.self))
        tableView.tableFooterView = UIView()
        tableView.dataSource = self
        tableView.delegate = self
    }
}

extension MenuScreenViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 4
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: MenuScreenCell.self)) as! MenuScreenCell
        cell.fill(imgUrl: "", title: "ცხელი საჭმელი")
        return cell
    }
}
