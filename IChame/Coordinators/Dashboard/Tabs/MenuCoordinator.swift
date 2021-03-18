//
//  HomeCoordinator.swift
//  IChame
//
//  Created by Rezo Joglidze on 3/18/21.
//  Copyright © 2021 Rezo Joglidze. All rights reserved.
//

import Foundation
import XCoordinator

enum MenuRoute: Route {
  case menu
}

class MenuCoordinator: NavigationCoordinator<MenuRoute> {
  static let shared = MenuCoordinator()
  private var menu: Menu?
  
  init(menu: Menu? = nil) {
    self.menu = menu
    super.init(rootViewController: UINavigationController(), initialRoute: .menu)
  }
  
  override func prepareTransition(for route: RouteType) -> NavigationTransition {
    switch route {
    case .menu:
      let home = MenuScreenViewController.instantiate(strongRouter: self.strongRouter, menu: menu)
      return .push(home)
    }
  }
}
