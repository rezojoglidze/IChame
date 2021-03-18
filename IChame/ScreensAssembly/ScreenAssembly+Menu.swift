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
  func setupMenu() {
    setupMenuScreen()
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
}
