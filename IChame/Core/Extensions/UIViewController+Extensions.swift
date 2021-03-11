//
//  UIViewController+Extensions.swift
//  IChame
//
//  Created by Rezo Joglidze on 3/11/21.
//  Copyright © 2021 Rezo Joglidze. All rights reserved.
//

import Foundation
import UIKit

extension UIViewController {
  
  static var stringFromClass : String { return NSStringFromClass(self) }
  
  static var className : String { return self.stringFromClass.components(separatedBy: ".").last! }
  
  static func load(from storyboard: String, for bundle: Bundle? = nil) -> Self? {
    return self.load(with: self.className, from: storyboard, for: bundle)
  }
  
  ///Return newly initialized view controller with given id from given storyboard for given bundle
  fileprivate static func _load<T>(with id: String, from storyboard: String, for bundle: Bundle? = nil) -> T? {
    return UIStoryboard(name: storyboard, bundle: bundle).instantiateViewController(withIdentifier: id) as? T
  }
  
  ///Return newly initialized view controller with given id from given storyboard for given bundle
  static func load(with id: String, from storyboard: String, for bundle: Bundle? = nil) -> Self? {
    return self._load(with: id, from: storyboard, for: bundle)
  }
  
  public class func loadFromStoryboard() -> Self {
    let name = self.className.replacingOccurrences(of: "NavigationController", with: "")
      .replacingOccurrences(of: "ViewController", with: "")
      .replacingOccurrences(of: "Controller", with: "")
    return self.load(from: name) ?? Self.init()
  }
}
