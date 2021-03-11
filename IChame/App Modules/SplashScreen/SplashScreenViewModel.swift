//
//  SplashScreenViewModel.swift
//  IChame
//
//  Created by Rezo Joglidze on 3/10/21.
//  Copyright © 2021 Rezo Joglidze. All rights reserved.
//

import Foundation
import XCoordinator

protocol SplashScreenViewModelProtocol {
  var router: UnownedRouter<MainRoute> { get }
  func triggerSplashScreenCompletion()
}

class SplashScreenViewModel {
  
  var router: UnownedRouter<MainRoute>
  
  init(router: UnownedRouter<MainRoute>) {
    self.router = router
  }
}

extension SplashScreenViewModel: SplashScreenViewModelProtocol {
  func triggerSplashScreenCompletion() {
    router.trigger(.authorizationScreen(initialRoute: .authScreen))
  }
}
