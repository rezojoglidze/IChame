//
//  IChameTabbarController.swift
//  IChame
//
//  Created by Rezo Joglidze on 3/19/21.
//  Copyright © 2021 Rezo Joglidze. All rights reserved.
//

import Foundation
import UIKit

class IChameTabbarController: UITabBarController {
  
  override func viewDidAppear(_ animated: Bool) {
    layoutTabTitles()
  }
  
  func layoutTabTitles() {
    if let tabbarItems = self.tabBar.items {
      for item in tabbarItems {
        item.titlePositionAdjustment = UIOffset(horizontal: 0, vertical: -2)
      }
    }
  }
}
