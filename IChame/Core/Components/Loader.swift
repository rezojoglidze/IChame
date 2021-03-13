//
//  Loader.swift
//  IChame
//
//  Created by Rezo Joglidze on 3/13/21.
//  Copyright © 2021 Rezo Joglidze. All rights reserved.
//

import UIKit
import MBProgressHUD

fileprivate class WeakObject<T: UIView>: Hashable {
    
    static func == (lhs: WeakObject<T>, rhs: WeakObject<T>) -> Bool {
        return lhs.value == rhs.value
    }
    
    weak var value: T?
    
    deinit {
        print("deinit: - WeakObject<UIView>")
    }
    
    init(value: T) {
        self.value = value
    }
    
    func hash(into hasher: inout Hasher) {
        if let value = self.value {
            hasher.combine(ObjectIdentifier(value).hashValue)
        }
    }
    
}

private class Loader {
    
    let loader: MBProgressHUD
    private weak var view: UIView?
    
    private(set) var isLoading = false
    
    deinit {
        print("deinit: - Loader")
    }
    
    init(forView view: UIView) {
        self.view = view
        self.loader = MBProgressHUD(view: view)
        loader.contentColor = #colorLiteral(red: 0.2039215686, green: 0.1725490196, blue: 0.8352941176, alpha: 1)
        loader.bezelView.color = UIColor.white
        loader.bezelView.style = .solidColor
        self.loader.removeFromSuperViewOnHide = true
    }
    
    func startLoader(animated: Bool = true, offset: CGFloat?) {
        self.loader.show(animated: animated)
        self.view?.addSubview(self.loader)
        self.view?.bringSubviewToFront(loader)
        if let offset = offset {
            loader.offset.y = CGFloat(offset)
        }
        self.isLoading = true
        self.view?.isUserInteractionEnabled = false
    }
    
    func stopLoader(animated: Bool = true) {
        self.loader.hide(animated: animated)
        self.isLoading = false
        self.view?.isUserInteractionEnabled = true
    }
    
}

class LoaderManager {
    
    static let shared = LoaderManager()
    
    private var loaders: [WeakObject<UIView>: Loader] = [:]
    
    func startLoader(forView view: UIView, animated: Bool = true, offset: CGFloat?) {
        let object = WeakObject(value: view)
        let loader = Loader(forView: view)
        self.loaders[object] = loader
        loader.startLoader(animated: animated, offset: offset)
    }
    
    func stopLoader(forView view: UIView, animated: Bool = true) {
        let object = WeakObject(value: view)
        let loader = self.loaders[object]
        loader?.stopLoader(animated: animated)
        self.loaders[object] = nil
    self.loaders.removeValue(forKey: object)
    }
    
    func isLoading(forView view: UIView) -> Bool {
        let object = WeakObject(value: view)
        let loader = self.loaders[object]
        return loader?.isLoading == true
    }
    
}
