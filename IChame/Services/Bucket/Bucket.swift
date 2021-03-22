//
//  Bucket.swift
//  IChame
//
//  Created by Rezo Joglidze on 3/21/21.
//  Copyright © 2021 Rezo Joglidze. All rights reserved.
//

import Foundation
import UIKit

struct Bucket: Codable {
    var hotDishes : [String : MenuItem]?
    var coldDishes : [String : MenuItem]?
    var drinks : [String : MenuItem]?
    var sauce : [String : MenuItem]?
}

extension Bucket {
    
    var bucketDataSource: [(type: MenuType, img: UIImage?)] {
        var dataSource: [(type: MenuType, img: UIImage?)] = []
        [hotDishes,coldDishes,drinks,sauce].forEach { (item) in
            if let item = item?.first {
                dataSource.append((type: item.value.type, img: item.value.type.image))
            }
        }
        return dataSource
    }

    func item(at index: Int, type: MenuType) -> MenuItem? {
        switch type {
        case .coldDishes:
            return coldDishes?["\(index)"]
        case .hotDishes:
            return hotDishes?["\(index)"]
        case .drinks:
            return drinks?["\(index)"]
        case .sauce:
            return sauce?["\(index)"]
        }
    }
    
    var numberOfSections: Int {
        var numberOfSections = 0
        [hotDishes,coldDishes,drinks,sauce].forEach { (item) in
            if let _ = item?.first {
                numberOfSections += 1
            }
        }
        return numberOfSections
    }
    
    func numberOfRowsInSection(type: MenuType) -> Int? {
        switch type {
        case .coldDishes:
            return coldDishes?.count
        case .hotDishes:
            return hotDishes?.count
        case .drinks:
            return drinks?.count
        case .sauce:
            return sauce?.count
        }
    }

}
