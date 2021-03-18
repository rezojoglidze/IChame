//
//  BucketScreenViewModel.swift
//  IChame
//
//  Created by Rezo Joglidze on 3/19/21.
//  Copyright © 2021 Rezo Joglidze. All rights reserved.
//

import Foundation
import XCoordinator

protocol BucketScreenViewModelProtocol {
  var router: StrongRouter<BucketRoute> { get }
}

class BucketScreenViewModel {
  var router: StrongRouter<BucketRoute>
  
  init(router: StrongRouter<BucketRoute>) {
    self.router = router
  }
}

extension BucketScreenViewModel: BucketScreenViewModelProtocol {
  
}
