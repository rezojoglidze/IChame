//
//  MainCoordinator.swift
//  IChame
//
//  Created by Rezo Joglidze on 3/10/21.
//  Copyright © 2021 Rezo Joglidze. All rights reserved.
//

import Foundation
import XCoordinator

enum MainRoute: Route {
  case splashScreen
  case authorizationScreen(initialRoute: AuthRoute)
}

class MainCoordinator: NavigationCoordinator<MainRoute> {
  static let shared = MainCoordinator()
  
  override func prepareTransition(for route: RouteType) -> TransitionType {
    switch route {
    case .splashScreen:
      let viewController = SplashScreenViewController.instantiate(unownedRouter: self.unownedRouter)
      return .push(viewController)
    case .authorizationScreen(let initialRoute):
      let coordinator = AuthCoordinator(rootController: UINavigationController(), initialRoute: initialRoute)
      addChild(coordinator)
      return .presentFullScreen(coordinator, animation: nil)
    }
  }
}

extension Transition {
  
  static func presentFullScreen(_ presentable: Presentable, animation: Animation? = nil) -> Transition {
    presentable.viewController?.modalPresentationStyle = .fullScreen
    return .present(presentable, animation: animation)
  }
}
