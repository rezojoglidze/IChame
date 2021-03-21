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
    case menuDetails(menuItems: [MenuItem], title: String)
}

class MenuCoordinator: NavigationCoordinator<MenuRoute> {
    static let shared = MenuCoordinator()
    private let menu: Menu?
    
    init(menu: Menu? = nil) {
        self.menu = menu
        super.init(rootViewController: UINavigationController(), initialRoute: .menu)
    }
    
    override func prepareTransition(for route: RouteType) -> NavigationTransition {
        switch route {
        case .menu:
            let menu = MenuScreenViewController.instantiate(strongRouter: self.strongRouter, menu: self.menu)
            return .push(menu)
        case .menuDetails(let menuItems, let title):
            let menuDetails = MenuDetailsScreenViewController.instantiate(strongRouter: self.strongRouter, menuItems: menuItems, title: title)
            return .push(menuDetails)
        }
    }
}
