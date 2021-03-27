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
        self.container.register(MoreScreenService.self) { (_) -> MoreScreenService in
            return MoreScreenService()
        }
        self.container.register(MoreScreenViewModel.self) { (resolver, router: StrongRouter<MoreSceenRoute>) -> MoreScreenViewModel in
            let moreScreenService = resolver.resolve(MoreScreenService.self)
            let viewModel = MoreScreenViewModel(router: router, moreScreenService: moreScreenService)
            return viewModel
        }
        self.container.register(MoreScreenViewController.self) { (resolver, router: StrongRouter<MoreSceenRoute>) -> MoreScreenViewController in
            let viewController = MoreScreenViewController.loadFromStoryboard()
            let viewModel = resolver.resolve(MoreScreenViewModel.self, argument: router)
            viewController.viewModel = viewModel
            return viewController
        }
    }
}
