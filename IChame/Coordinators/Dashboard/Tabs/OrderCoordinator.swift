//
//  OrderCoordinator.swift
//  IChame
//
//  Created by Rezo Joglidze on 4/10/21.
//  Copyright © 2021 Rezo Joglidze. All rights reserved.
//

import Foundation
import XCoordinator

enum OrderRoute: Route {
    case order
}

class OrderCoordinator: NavigationCoordinator<OrderRoute> {
    static let shared = BucketCoordinator()
    
    init() {
        super.init(rootViewController: UINavigationController(), initialRoute: .order)
    }
    
    override func prepareTransition(for route: RouteType) -> NavigationTransition {
        switch route {
        case .order:
            let bucket = OrderScreenViewController.instantiate(strongRouter: self.strongRouter)
            return .push(bucket)
        }
    }
}
