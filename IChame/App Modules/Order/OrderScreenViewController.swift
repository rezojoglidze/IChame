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
    }
    
    private func setupNavigationBar() {
        navigationItem.title = "შეკვეთები"
        navigationController?.navigationBar.prefersLargeTitles = true
    }
}
