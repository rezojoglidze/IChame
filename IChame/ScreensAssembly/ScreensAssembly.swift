//
//  ScreensAssembly.swift
//  IChame
//
//  Created by Rezo Joglidze on 3/11/21.
//  Copyright © 2021 Rezo Joglidze. All rights reserved.
//

import Foundation
import Swinject

class ScreensAssembly {
  
  static let shared = ScreensAssembly()
  let container = Container()
  
  init() {
    setupAuthorization()
    setupMenu()
    setupBucket()
    setupMoreScreens()
  }
}
