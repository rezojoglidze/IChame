//
//  Double + Extensions.swift
//  IChame
//
//  Created by Rezo Joglidze on 3/27/21.
//  Copyright © 2021 Rezo Joglidze. All rights reserved.
//

import Foundation

extension Double {
    func rounded(toPlaces places: Int) -> Double {
        let divisor = pow(10.0, Double(places))
        return (self * divisor).rounded() / divisor
    }
}
