//
//  RegistrationScreenViewModel.swift
//  IChame
//
//  Created by Rezo Joglidze on 3/12/21.
//  Copyright © 2021 Rezo Joglidze. All rights reserved.
//

import Foundation
import XCoordinator

protocol RegistrationScreenViewModelDelegate {
  var router: UnownedRouter<AuthRoute> { get }
}

class RegistrationScreenViewModel {
  
  var router: UnownedRouter<AuthRoute>
  
  init(router: UnownedRouter<AuthRoute>) {
    self.router = router
  }
}

extension RegistrationScreenViewModel: RegistrationScreenViewModelDelegate {
  
}
