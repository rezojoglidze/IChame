//
//  Order.swift
//  IChame
//
//  Created by Rezo Joglidze on 4/10/21.
//  Copyright © 2021 Rezo Joglidze. All rights reserved.
//

import Foundation
import UIKit

struct Order: Decodable {
    var hotDishes : [String : MenuItem]?
    var coldDishes : [String : MenuItem]?
    var drinks : [String : MenuItem]?
    var sauces : [String : MenuItem]?
    var restaurantId: String
    var userId: String?
    var status: OrderStatus?
}

enum OrderStatus: String, Codable {
    case inProgress
    case accepted
    case rejected
    
    var title: String {
        switch self {
        case .inProgress:
            return "პროცესშია"
        case .accepted:
            return "დადასტურებულია"
        case .rejected:
            return "უარყოფილია"
        }
    }
    
    var color: UIColor {
        switch self {
        case .inProgress:
            return #colorLiteral(red: 0.9607843161, green: 0.7058823705, blue: 0.200000003, alpha: 1)
        case .accepted:
            return #colorLiteral(red: 0.3411764801, green: 0.6235294342, blue: 0.1686274558, alpha: 1)
        case .rejected:
            return #colorLiteral(red: 0.7450980544, green: 0.1568627506, blue: 0.07450980693, alpha: 1)
        }
    }
}
