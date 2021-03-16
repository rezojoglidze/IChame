//
//  Menu.swift
//  IChame
//
//  Created by Rezo Joglidze on 3/17/21.
//  Copyright © 2021 Rezo Joglidze. All rights reserved.
//

import Foundation

struct Menu: Codable {
  var hotDishes: [Sample]
  var drinks: [Sample]
  var sauce: [Sample]
  var menuId: String
}

struct Sample: Codable {
  var description: String
  var name: String
  var price: Double
}
