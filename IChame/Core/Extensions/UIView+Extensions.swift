//
//  UIView+Extensions.swift
//  IChame
//
//  Created by Rezo Joglidze on 3/13/21.
//  Copyright © 2021 Rezo Joglidze. All rights reserved.
//

import UIKit

extension UIView {
  func startLoader(animated: Bool = true, offset: CGFloat? = nil) {
    LoaderManager.shared.startLoader(forView: self, animated: animated, offset: offset)
  }
  
  func stopLoader(animated: Bool = true) {
    LoaderManager.shared.stopLoader(forView: self, animated: animated)
  }
}
