//
//  ScreenAssembly+Menu.swift
//  IChame
//
//  Created by Rezo Joglidze on 3/18/21.
//  Copyright © 2021 Rezo Joglidze. All rights reserved.
//

import Foundation
import Swinject
import XCoordinator

extension ScreensAssembly {
    func setupMenu() {
        setupMenuScreen()
        setupMenuDetailsScreen()
    }
    
    func setupMenuScreen() {
        
        self.container.register(MenuScreenViewModel.self) { (resolver, router: StrongRouter<MenuRoute>, menu: Menu?) -> MenuScreenViewModel in
            let viewModel = MenuScreenViewModel(router: router, menu: menu)
            return viewModel
        }
        
        self.container.register(MenuScreenViewController.self) { (resolver, router: StrongRouter<MenuRoute>, menu: Menu?) -> MenuScreenViewController in
            let viewModel = resolver.resolve(MenuScreenViewModel.self, arguments: router, menu)
            let viewController = MenuScreenViewController.loadFromStoryboard()
            viewController.viewModel = viewModel
            return viewController
        }
    }
    
    func setupMenuDetailsScreen() {
        self.container.register(BucketService.self) { (_) -> BucketService in
            return BucketService()
        }
        self.container.register(MenuDetailsScreenViewModel.self) { (resolver, router: StrongRouter<MenuRoute>, menuItems: [MenuItem]) -> MenuDetailsScreenViewModel in
            let bucketService = resolver.resolve(BucketService.self)
            let viewModel = MenuDetailsScreenViewModel(router: router, menuItems: menuItems, bucketService: bucketService)
            return viewModel
        }
        self.container.register(MenuDetailsScreenViewController.self) { (resolver, router: StrongRouter<MenuRoute>, menuItems: [MenuItem], title: String) -> MenuDetailsScreenViewController in
            let viewModel = resolver.resolve(MenuDetailsScreenViewModel.self, arguments: router, menuItems)
            let viewController = MenuDetailsScreenViewController.loadFromStoryboard()
            viewController.viewModel = viewModel
            viewController.navigationTitle = title
            return viewController
        }
    }
}
