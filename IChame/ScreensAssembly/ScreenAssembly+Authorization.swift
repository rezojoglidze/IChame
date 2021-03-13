//
//  ScreenAssembly+Authorization.swift
//  IChame
//
//  Created by Rezo Joglidze on 3/11/21.
//  Copyright © 2021 Rezo Joglidze. All rights reserved.
//

import Foundation
import Swinject
import XCoordinator

extension ScreensAssembly {
  
  func setupAuthorization() {
    setupSplashScreen()
    setupAuthorizationScreen()
    setupRegistrationScreen()
  }
  
  private func setupSplashScreen() {
    self.container.register(SplashScreenViewController.self) { (resolver, router: UnownedRouter<MainRoute>) -> SplashScreenViewController in
      let viewModel = resolver.resolve(SplashScreenViewModel.self, argument: router)
      let viewController = SplashScreenViewController.loadFromStoryboard()
      viewController.viewModel = viewModel
      return viewController
    }
    
    self.container.register(SplashScreenViewModel.self) { (_, router: UnownedRouter<MainRoute>) -> SplashScreenViewModel in
      let viewModel = SplashScreenViewModel(router: router)
      return viewModel
    }
  }
  
  private func setupAuthorizationScreen() {
    self.container.register(UserService.self) { (_) -> UserService in
      let userService = UserService()
      return userService
    }
    self.container.register(AuthorizationScreenViewModel.self) { (resolver, router: UnownedRouter<AuthRoute>) -> AuthorizationScreenViewModel in
      let userService = resolver.resolve(UserService.self)
      let viewModel = AuthorizationScreenViewModel(router: router, userService: userService)
      return viewModel
    }
    self.container.register(AuthorizationScreenViewController.self) { (resolver, router: UnownedRouter<AuthRoute>) -> AuthorizationScreenViewController in
      let viewModel = resolver.resolve(AuthorizationScreenViewModel.self, argument: router)
      let viewController = AuthorizationScreenViewController.loadFromStoryboard()
      viewController.viewModel = viewModel
      return viewController
    }
  }
  
  private func setupRegistrationScreen() {
    self.container.register(UserService.self) { (_) -> UserService in
      let userService = UserService()
      return userService
    }
    self.container.register(RegistrationScreenViewModel.self) { (resolver, router: UnownedRouter<AuthRoute>) -> RegistrationScreenViewModel in
      let userService = resolver.resolve(UserService.self)
      let viewModel = RegistrationScreenViewModel(router: router, userService: userService)
      return viewModel
    }
    self.container.register(RegistrationScreenViewController.self) { (resolver, router: UnownedRouter<AuthRoute>) -> RegistrationScreenViewController in
      let viewModel = resolver.resolve(RegistrationScreenViewModel.self, argument: router)
      let viewController = RegistrationScreenViewController.loadFromStoryboard()
      viewController.viewModel = viewModel
      return viewController
    }
  }
}
