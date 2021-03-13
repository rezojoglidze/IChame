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
  
  ///Return newly initialized view controller with given id from given storyboard for given bundle
  fileprivate static func _load<T>(with id: String, from storyboard: String, for bundle: Bundle? = nil) -> T? {
    return UIStoryboard(name: storyboard, bundle: bundle).instantiateViewController(withIdentifier: id) as? T
  }
  
  ///Return newly initialized view controller with given id from given storyboard for given bundle
  static func load(with id: String, from storyboard: String, for bundle: Bundle? = nil) -> Self? {
    return self._load(with: id, from: storyboard, for: bundle)
  }
  
  static func load(from storyboard: String, for bundle: Bundle? = nil) -> Self? {
    return self.load(with: self.className, from: storyboard, for: bundle)
  }
  
  public class func loadFromStoryboard() -> Self {
    let name = self.className.replacingOccurrences(of: "NavigationController", with: "")
      .replacingOccurrences(of: "ViewController", with: "")
      .replacingOccurrences(of: "Controller", with: "")
    return self.load(from: name) ?? Self.init()
  }
}

//MARK: Keyboard extensions
extension UIViewController {
  func hideKeyboardWhenTappedOutside() {
    let tap = UITapGestureRecognizer(target: self, action: #selector(UIViewController.dismissKeyboard))
    tap.cancelsTouchesInView = false
    view.addGestureRecognizer(tap)
  }
  
  @objc func dismissKeyboard() {
    view.endEditing(true)
  }
}

//MARK: Alert message
extension UIViewController {
  
  var standardFailBlock: Network.StatusBlock {
    return { [weak self] error in
      guard let errorMsg = error?.localizedDescription else { return }
      self?.showAlert(text: errorMsg)
    }
  }
  
func showAlert(text: String) {
    let alert = UIAlertController(title: text, message: nil, preferredStyle: .alert)
    alert.addAction(UIAlertAction(title: "გასაგებია", style: .cancel, handler: nil))
    self.present(alert, animated: true, completion: nil)
  }
}
