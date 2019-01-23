//
//  Extensions.swift
//  Treads
//
//  Created by Ramit sharma on 23/01/19.
//  Copyright © 2019 Ramit sharma. All rights reserved.
//

import Foundation

extension Double {
    func metersToMiles(places: Int) -> Double {
        let divisor = pow(10.0, Double(places))
        return ((self / 1609.34) * divisor).rounded() / divisor
    }
}
