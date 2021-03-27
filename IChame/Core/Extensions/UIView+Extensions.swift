//
//  UIView+Extensions.swift
//  IChame
//
//  Created by Rezo Joglidze on 3/13/21.
//  Copyright © 2021 Rezo Joglidze. All rights reserved.
//

import UIKit

extension UIView {
    
    //Return newly initialized view from given bundle, by given name, with given owner and with given options
    fileprivate static func _load<T>(bundle: Bundle = .main, name: String, owner: Any? = self, options: [UINib.OptionsKey: Any]? = nil) -> T? {
        if let views = bundle.loadNibNamed(name, owner: owner, options: options) {
            for view in views {
                if view is T {
                    return view as? T
                }
            }
        }
        return nil
    }
    
    //Return newly initialized view from given bundle, by given name, with given owner and with given options
    fileprivate static func load<T>(bundle: Bundle = .main, name: String, owner: Any? = self, options: [UINib.OptionsKey: Any]? = nil) -> T? {
        return self._load(bundle: bundle, name: name, owner: owner, options: options)
    }
    
    //Return newly initialized view with classname as id for given owner with given options
    static func load(bundle: Bundle = .main, owner: Any? = self, options: [UINib.OptionsKey: Any]? = nil) -> Self? {
        return self.load(bundle: bundle, name: self.className, owner: owner, options: options)
    }
    
}

extension NSObject {
    //Return class full name as String
    static var stringFromClass : String { return NSStringFromClass(self) }
 
    //Return class name as String
    static var className : String { return self.stringFromClass.components(separatedBy: ".").last! }
}

//MARK: Loader
extension UIView {
    func startLoader(animated: Bool = true, offset: CGFloat? = nil) {
        LoaderManager.shared.startLoader(forView: self, animated: animated, offset: offset)
    }
    
    func stopLoader(animated: Bool = true) {
        LoaderManager.shared.stopLoader(forView: self, animated: animated)
    }
}
