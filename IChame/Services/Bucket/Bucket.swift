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
    var sauces : [String : MenuItem]?
    var restaurantId: String
    var userId: String?
    var status: OrderStatus?
}

extension Bucket {
    
    func item(at index: Int, type: MenuType) -> MenuItem? {
        let category = getBucketCategory(by: type)
        return getBucketCategoryArray(at: index, category: category)
    }
    
    var numberOfSections: Int {
        var numberOfSections = 0
        [hotDishes,coldDishes,drinks,sauces].forEach { (item) in
            if let _ = item?.first {
                numberOfSections += 1
            }
        }
        return numberOfSections
    }
    
    func numberOfRowsInSection(type: MenuType) -> Int? {
        let category = getBucketCategory(by: type)
        return category?.count
    }
    
    var sections: [MenuType] {
        var sections: [MenuType] = []
        [hotDishes,coldDishes,drinks,sauces].forEach { (item) in
            if let _ = item?.first {
                sections.append(item?.first?.value.type ?? .hotDishes)
            }
        }
        return sections
    }
    
    var getTotalAmount: Double {
        var totalAmount: Double = 0
        [hotDishes,coldDishes,drinks,sauces].forEach { (category) in
            if let values = category?.values {
                for item in values {
                    totalAmount += item.price
                }
            }
        }
        return totalAmount
    }
    
    private func getBucketCategoryArray(at index: Int, category: [String : MenuItem]?) -> MenuItem? {
        var categoryValues: [MenuItem] = []
        if let values = category?.values {
            for item in values {
                categoryValues.append(item)
            }
        }
        return categoryValues[index]
    }
    
    private func getBucketCategory(by type: MenuType) -> [String : MenuItem]? {
        switch type {
        case .coldDishes:
            return coldDishes
        case .hotDishes:
            return hotDishes
        case .drinks:
            return drinks
        case .sauces:
            return sauces
        }
    }
}
