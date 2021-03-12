//
//  AuthorizationScreenViewModel.swift
//  IChame
//
//  Created by Rezo Joglidze on 3/11/21.
//  Copyright © 2021 Rezo Joglidze. All rights reserved.
//

import Foundation
import XCoordinator

protocol AuthorizationScreenViewModelProtocol {
  var router: UnownedRouter<AuthRoute> { get }
  func acountHaveNotBtnTapped()
}

class AuthorizationScreenViewModel {
  var router: UnownedRouter<AuthRoute>
  
  init(router: UnownedRouter<AuthRoute>) {
    self.router = router
  }
}

extension AuthorizationScreenViewModel: AuthorizationScreenViewModelProtocol {
  func acountHaveNotBtnTapped() {
    router.trigger(.registrationScreen)
  }
}
