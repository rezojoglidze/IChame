//
//  UITableView+Extensions.swift
//  IChame
//
//  Created by Rezo Joglidze on 3/27/21.
//  Copyright © 2021 Rezo Joglidze. All rights reserved.
//

import Foundation
import UIKit

extension UITableView {
    func dequeueReusableCell<T: UITableViewCell>(for indexPath: IndexPath) -> T where T: Reusable {
        if let cell = self.dequeueReusableCell(withIdentifier: T.reuseIdentifier, for: indexPath as IndexPath) as? T {
            return cell
        } else {
            print("Couldn't dequeue cell with identifier: \(T.reuseIdentifier). Returning empty, newly initialized \(T.reuseIdentifier) cell")
            return T()
        }
    }
}

public protocol Reusable: class {
    static var reuseIdentifier: String { get }
}
