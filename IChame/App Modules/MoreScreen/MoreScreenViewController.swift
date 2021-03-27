//
//  MoreScreenViewController.swift
//  IChame
//
//  Created by Rezo Joglidze on 3/19/21.
//  Copyright © 2021 Rezo Joglidze. All rights reserved.
//

import UIKit
import XCoordinator

class MoreScreenViewController: UIViewController {
    
    var viewModel: MoreScreenViewModelProtocol!
    
    @IBOutlet private weak var tableView: UITableView!
        
    static func instantiate(strongRouter: StrongRouter<MoreSceenRoute>) -> Self {
        let viewController = ScreensAssembly.shared.container.resolve(Self.self, argument: strongRouter) ?? .init()
        return viewController
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTableView()
        navigationController?.isNavigationBarHidden = true
    }
    
    private func setupTableView() {
        tableView.register(UINib(nibName: String(describing: MoreScreenTableViewCell.self), bundle: nil), forCellReuseIdentifier: String(describing: MoreScreenTableViewCell.self))
        tableView.tableFooterView = UIView()
        tableView.dataSource = self
        tableView.delegate = self
    }
}


//MARK: UITableViewDataSource && UITableViewDelegate
extension MoreScreenViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.numberOfRows()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: MoreScreenTableViewCell.self)) as! MoreScreenTableViewCell
        let item = viewModel.itemAt(index: indexPath.row)
        cell.fill(item)
        return cell
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        if let header = MoreScreenHeaderView.load() {
            header.fill(name: User.current?.email ?? "")
            return header
        }
        return UIView()
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 60
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let item = viewModel.itemAt(index: indexPath.row)
        switch item.type {
        case .logout:
            viewModel.logout(fail: self.standardFailBlock)
        }
    }
}
