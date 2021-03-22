//
//  BucketScreenViewController.swift
//  IChame
//
//  Created by Rezo Joglidze on 3/19/21.
//  Copyright © 2021 Rezo Joglidze. All rights reserved.
//

import UIKit
import XCoordinator
import RxSwift

class BucketScreenViewController: UIViewController {
    
    var viewModel: BucketScreenViewModelProtocol!
    private var disposeBag = DisposeBag()

    @IBOutlet private weak var tableView: UITableView!
    
    static func instantiate(strongRouter: StrongRouter<BucketRoute>) -> Self {
        let viewController = ScreensAssembly.shared.container.resolve(Self.self, argument: strongRouter) ?? .init()
        return viewController
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.isNavigationBarHidden = true
        viewModel.loadBucket(fail: self.standardFailBlock)
        self.startLoader()
        setupTableView()
        setupObservables()
    }
    
    private func setupObservables() {
        viewModel.bucketDidLoaded.subscribe(onNext: { [weak self] in
            self?.stopLoader()
            self?.tableView.reloadData()
        }).disposed(by: disposeBag)
    }
    
    private func setupTableView() {
        tableView.register(UINib(nibName: String(describing: MenuDetailsTableViewCell.self), bundle: nil), forCellReuseIdentifier: String(describing: MenuDetailsTableViewCell.self))
        tableView.tableFooterView = UIView()
        tableView.dataSource = self
        tableView.delegate = self
    }
}

extension BucketScreenViewController: UITableViewDataSource, UITableViewDelegate {
    func numberOfSections(in tableView: UITableView) -> Int {
        return viewModel.numberOfSections()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.numberOfRows(section: section)
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.section <= 4 {
            if let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: MenuDetailsTableViewCell.self)) as? MenuDetailsTableViewCell {
                if let item = viewModel.item(at: indexPath) {
                    cell.fill(item: item, isHiddenActionBtn: true)
                }
                return cell
            }
        }
        return UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        var title = "ცხელი კერძები"
        if section == 1 {
          title = "ცივი კერძები"
        } else if section == 2 {
          title = "სასმელები"
        } else if section == 3 {
          title = "სოუსები"
        }
        return title
    }

    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 40
    }
}
