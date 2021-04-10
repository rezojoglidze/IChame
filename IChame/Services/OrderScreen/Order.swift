//
//  Order.swift
//  IChame
//
//  Created by Rezo Joglidze on 4/10/21.
//  Copyright © 2021 Rezo Joglidze. All rights reserved.
//

import Foundation

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
}
