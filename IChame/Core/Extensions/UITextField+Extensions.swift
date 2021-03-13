//
//  UITextField+Extensions.swift
//  IChame
//
//  Created by Rezo Joglidze on 3/13/21.
//  Copyright © 2021 Rezo Joglidze. All rights reserved.
//

import Foundation
import UIKit

extension UITextField {
  
  var string: String { get { return self.text ?? "" } set { self.text = newValue }}
  
}
