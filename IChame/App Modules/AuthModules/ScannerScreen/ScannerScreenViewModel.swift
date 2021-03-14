//
//  ScannerScreenViewModel.swift
//  IChame
//
//  Created by Rezo Joglidze on 3/14/21.
//  Copyright © 2021 Rezo Joglidze. All rights reserved.
//

import Foundation
import XCoordinator

protocol ScannerScreenViewModelProocol {
  var router: UnownedRouter<AuthRoute> { get }
}

class ScannerScreenViewModel {
  var router: UnownedRouter<AuthRoute>
  
  init(router: UnownedRouter<AuthRoute>) {
    self.router = router
  }
}


extension ScannerScreenViewModel: ScannerScreenViewModelProocol {
  
}
