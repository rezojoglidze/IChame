//
//  HomeScreenViewModel.swift
//  IChame
//
//  Created by Rezo Joglidze on 3/18/21.
//  Copyright © 2021 Rezo Joglidze. All rights reserved.
//

import Foundation
import XCoordinator

protocol MenuScreenViewModelProtocol {
  var router: StrongRouter<MenuRoute> { get }
}

class MenuScreenViewModel {
  var router: StrongRouter<MenuRoute>
  
  init(router: StrongRouter<MenuRoute>) {
    self.router = router
    
  }
}

extension MenuScreenViewModel: MenuScreenViewModelProtocol {
  
}
