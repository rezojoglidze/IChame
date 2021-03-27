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
        self.startLoader()
        viewModel.loadBucket(fail: self.standardFailBlock)
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

//MARK: MenuDetailsTableViewCellDelegate
extension BucketScreenViewController: MenuDetailsTableViewCellDelegate {
    func didTapActionButton(cell: MenuDetailsTableViewCell, isAdd: Bool) {
        guard let indexPath = cell.indexPath,
              let type = cell.type else { return }
        viewModel.removeDishFromBucket(with: indexPath, type: type, fail: self.standardFailBlock)
    }
}

//MARK: UITableViewDataSource && UITableViewDelegate
extension BucketScreenViewController: UITableViewDataSource, UITableViewDelegate {
    func numberOfSections(in tableView: UITableView) -> Int {
        return viewModel.numberOfSections()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.numberOfRowsInSection(section: section)
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let type = viewModel.getSectionType(section: indexPath.section)
        let cell = tableView.dequeueReusableCell(withIdentifier: "MenuDetailsTableViewCell") as! MenuDetailsTableViewCell
        if let item = viewModel.item(at: indexPath, with: type) {
            cell.fill(item: item, isHiddenAddBtn: true)
            cell.indexPath = indexPath
            cell.type = type
            cell.delegate = self
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        let type = viewModel.getSectionType(section: section)
        return type.title
    }

    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 40
    }
}
