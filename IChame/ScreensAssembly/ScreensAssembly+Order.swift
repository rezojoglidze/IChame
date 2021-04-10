//
//  ScreensAssembly+Order.swift
//  IChame
//
//  Created by Rezo Joglidze on 4/10/21.
//  Copyright © 2021 Rezo Joglidze. All rights reserved.
//

import Foundation
import XCoordinator
import Swinject

extension ScreensAssembly {
    func setupOrder() {
        setupOrderScreen()
    }
    
    func setupOrderScreen() {
        self.container.register(OrderService.self) { (_) -> OrderService in
            return OrderService()
        }
        self.container.register(OrderScreenViewModel.self) { (resolver, router: StrongRouter<OrderRoute>) -> OrderScreenViewModel in
            let orderService = resolver.resolve(OrderService.self)
            let viewModel = OrderScreenViewModel(router: router, orderService: orderService)
            return viewModel
        }
        self.container.register(OrderScreenViewController.self) { (resolver, router: StrongRouter<OrderRoute>) -> OrderScreenViewController in
            let viewController = OrderScreenViewController.loadFromStoryboard()
            let viewModel = resolver.resolve(OrderScreenViewModel.self, argument: router)
            viewController.viewModel = viewModel
            return viewController
        }
    }
}
