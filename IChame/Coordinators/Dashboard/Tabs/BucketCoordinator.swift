//
//  BucketCoordinator.swift
//  IChame
//
//  Created by Rezo Joglidze on 3/19/21.
//  Copyright © 2021 Rezo Joglidze. All rights reserved.
//

import Foundation
import XCoordinator

enum BucketRoute: Route {
    case bucket
}

class BucketCoordinator: NavigationCoordinator<BucketRoute> {
    static let shared = BucketCoordinator()
    
    init() {
        super.init(rootViewController: UINavigationController(), initialRoute: .bucket)
    }
    
    override func prepareTransition(for route: RouteType) -> NavigationTransition {
        switch route {
        case .bucket:
            let bucket = BucketScreenViewController.instantiate(strongRouter: self.strongRouter)
            return .push(bucket)
        }
    }
}
