//
//  Date+Utils.swift
//  Platinium
//
//  Created by Mert Duran on 12.11.2022.
//

import Foundation

extension Date {
    static var platiniumDateFormatter: DateFormatter {
        let formatter = DateFormatter()
        formatter.timeZone = TimeZone(abbreviation: "MDT")
        return formatter
    }
    
    var monthDayYearString: String {
        let dateFormatter = Date.platiniumDateFormatter
        dateFormatter.dateFormat = "MMM d, yyyy"
        return dateFormatter.string(from: self)
    }
}
