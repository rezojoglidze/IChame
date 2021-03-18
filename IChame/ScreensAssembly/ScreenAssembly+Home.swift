//
//  ScreenAssembly+Home.swift
//  IChame
//
//  Created by Rezo Joglidze on 3/18/21.
//  Copyright © 2021 Rezo Joglidze. All rights reserved.
//

import Foundation
import Swinject
import XCoordinator

extension ScreensAssembly {
  func setupHome() {
    setupHomeScreen()
  }
  
  func setupHomeScreen() {
    self.container.register(MenuScreenViewModel.self) { (resolver, router: StrongRouter<MenuRoute>) -> MenuScreenViewModel in
      let viewModel = MenuScreenViewModel(router: router)
      return viewModel
    }
    
    self.container.register(MenuScreenViewController.self) { (resolver, router: StrongRouter<MenuRoute>) -> MenuScreenViewController in
      let viewModel = resolver.resolve(MenuScreenViewModel.self, argument: router)
      let viewController = MenuScreenViewController.loadFromStoryboard()
      viewController.viewModel = viewModel
      return viewController
    }
  }
}
