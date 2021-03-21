//
//  Bucket.swift
//  IChame
//
//  Created by Rezo Joglidze on 3/21/21.
//  Copyright © 2021 Rezo Joglidze. All rights reserved.
//

import Foundation

struct Bucket: Codable {
    var hotDishes : [String : MenuItem]?
    var coldDishes : [String : MenuItem]?
    var drinks : [String : MenuItem]?
    var sauce : [String : MenuItem]?
}
