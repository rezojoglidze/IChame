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
    
    static func instantiate(strongRouter: StrongRouter<OrderRoute>) -> Self {
        let viewController = ScreensAssembly.shared.container.resolve(Self.self, argument: strongRouter) ?? .init()
        return viewController
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavigationBar()
        setupObservables()
        viewModel.loadOrder(fail: self.standardFailBlock)
    }
    
    private func setupNavigationBar() {
        navigationItem.title = "შეკვეთები"
        navigationController?.navigationBar.prefersLargeTitles = true
    }
    
    private func setupObservables() {
        viewModel.orderDidLoaded.subscribe(onNext: { [weak self] _ in
            self?.stopLoader()
        }).disposed(by: disposeBag)
        
        viewModel.showLoader.subscribe(onNext: { [weak self] show in
            show ? self?.startLoader() : self?.stopLoader()
        }).disposed(by: disposeBag)
    }
}
