//
//  AuthCoordinator.swift
//  IChame
//
//  Created by Rezo Joglidze on 3/11/21.
//  Copyright © 2021 Rezo Joglidze. All rights reserved.
//

import Foundation
import XCoordinator

enum AuthRoute: Route {
  case authScreen
  case registrationScreen
}

class AuthCoordinator: NavigationCoordinator<AuthRoute> {
  static var shared: AuthCoordinator?

  init(rootController: UINavigationController, initialRoute: RouteType) {
      super.init(rootViewController: rootController, initialRoute: initialRoute)
      AuthCoordinator.shared = self
   }
  
  override func prepareTransition(for route: RouteType) -> TransitionType {
    switch route {
    case .authScreen:
      let viewController = AuthorizationScreenViewController.instantiate(unownedRouter: self.unownedRouter)
      return .push(viewController)
    case .registrationScreen:
      let viewController = RegistrationScreenViewController.instantiate(unownedRouter: self.unownedRouter)
      return .push(viewController)
    }
  }
}
