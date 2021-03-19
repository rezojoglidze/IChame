//
//  Menu.swift
//  IChame
//
//  Created by Rezo Joglidze on 3/17/21.
//  Copyright © 2021 Rezo Joglidze. All rights reserved.
//

import Foundation
import UIKit

struct Menu: Codable {
    var hotDishes: [MenuItem]
    var coldDishes: [MenuItem]
    var drinks: [MenuItem]
    var sauce: [MenuItem]
    var menuId: String
    
    var menuScreenDataSource: [(title: String, img: UIImage?)] {
        var dataSource: [(title: String, img: UIImage?)] = []
        [hotDishes,coldDishes,drinks,sauce].forEach { (item) in
            if let item = item.first {
                dataSource.append((title: item.type.title, img: item.type.image))
            }
        }
        return dataSource
    }
    
    struct MenuItem: Codable {
        var description: String
        var name: String
        var price: Double
        var type: MenuType
        
        enum MenuType: String, Codable {
            case hotDishes
            case coldDishes
            case drinks
            case sauce
            
            var title: String {
                switch self {
                case .hotDishes:
                    return "ცხელი კერძები"
                case .coldDishes:
                    return "ცივი კერძები"
                case .drinks:
                    return "სასმელები"
                case .sauce:
                    return "სოუსები"
                }
            }
            
            var image: UIImage? {
                switch self {
                case .hotDishes, .coldDishes, .drinks, .sauce:
                    return UIImage(named: "\(self.rawValue)_icon")
                }
            }
        }
    }
}
