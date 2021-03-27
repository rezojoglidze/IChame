//
//  MoreSceenCoordinator.swift
//  IChame
//
//  Created by Rezo Joglidze on 3/19/21.
//  Copyright © 2021 Rezo Joglidze. All rights reserved.
//

import Foundation
import XCoordinator

enum MoreSceenRoute: Route {
    case moreSceen
    case logout
}

class MoreSceenCoordinator: NavigationCoordinator<MoreSceenRoute> {
    static let shared = MoreSceenCoordinator()
    
    init() {
        super.init(rootViewController: UINavigationController(), initialRoute: .moreSceen)
    }
    
    override func prepareTransition(for route: RouteType) -> NavigationTransition {
        switch route {
        case .moreSceen:
            let moreSceen = MoreScreenViewController.instantiate(strongRouter: self.strongRouter)
            return .push(moreSceen)
        case .logout:
            return .presentFullScreen(AuthCoordinator(rootController: UINavigationController(), initialRoute: .authScreen))
        }
    }
}
