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
    static var currentMenuId: String = ""
    
    var hotDishes: [MenuItem]
    var coldDishes: [MenuItem]
    var drinks: [MenuItem]
    var sauce: [MenuItem]
    var menuId: String
    
    var menuScreenDataSource: [(type: MenuType, img: UIImage?)] {
        var dataSource: [(type: MenuType, img: UIImage?)] = []
        [hotDishes,coldDishes,drinks,sauce].forEach { (item) in
            if let item = item.first {
                dataSource.append((type: item.type, img: item.type.image))
            }
        }
        return dataSource
    }
}


struct MenuItem: Codable {
    var description: String
    var name: String
    var price: Double
    var type: MenuType
}

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
    
    var engTitle: String {
        switch self {
        case .hotDishes, .coldDishes, .drinks, .sauce:
            return self.rawValue
        }
    }
    
    var image: UIImage? {
        switch self {
        case .hotDishes, .coldDishes, .drinks, .sauce:
            return UIImage(named: "\(self.rawValue)_icon")
        }
    }
    
    func getMenuItems(from menu: Menu) -> [MenuItem] {
        switch self {
        case .coldDishes:
            return menu.coldDishes
        case .hotDishes:
            return menu.hotDishes
        case .drinks:
            return menu.drinks
        case .sauce:
            return menu.sauce
        }
    }
}
