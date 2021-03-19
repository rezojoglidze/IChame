//
//  ScreenAssembly+MoreScreen.swift
//  IChame
//
//  Created by Rezo Joglidze on 3/19/21.
//  Copyright © 2021 Rezo Joglidze. All rights reserved.
//

import Foundation
import XCoordinator
import Swinject

extension ScreensAssembly {
    func setupMoreScreens() {
        setupMoreScreen()
    }
    
    func setupMoreScreen() {
        self.container.register(BucketScreenViewModel.self) { (resolver, router: StrongRouter<BucketRoute>) -> BucketScreenViewModel in
            let viewModel = BucketScreenViewModel(router: router)
            return viewModel
        }
        
        self.container.register(BucketScreenViewController.self) { (resolver, router: StrongRouter<BucketRoute>) -> BucketScreenViewController in
            let viewController = BucketScreenViewController.loadFromStoryboard()
            let viewModel = resolver.resolve(BucketScreenViewModel.self, argument: router)
            viewController.viewModel = viewModel
            return viewController
        }
    }
}
