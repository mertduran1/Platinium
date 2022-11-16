//
//  DecimalUtils.swift
//  Platinium
//
//  Created by Mert Duran on 10.11.2022.
//

import Foundation

extension Decimal {
    var doubleValue: Double {
        return NSDecimalNumber(decimal: self).doubleValue
    }
}
