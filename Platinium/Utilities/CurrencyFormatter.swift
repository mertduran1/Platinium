//
//  CurrencyFormatter.swift
//  Platinium
//
//  Created by Mert Duran on 10.11.2022.
//

import Foundation
import UIKit

struct CurrencyFormatter {
    func makeAttributedCurrency(_ amount: Decimal) -> NSMutableAttributedString {
        let tuple = breakIntoLirasAndKurus(amount)
        return makeBalanceAttributed(liras: tuple.0, kurus: tuple.1)
    }
    
    //123123.12 yi > "123,123" "12" e çevirir
    func breakIntoLirasAndKurus(_ amount: Decimal) -> (String, String) {
        let tuple = modf(amount.doubleValue)
        
        let liras = convertLiras(tuple.0)
        let kurus = convertKurus(tuple.1)
        
        return(liras, kurus)
    }
    //123123 > 123,123
    private func convertLiras(_ liraPart: Double) -> String {
        let lirasWithDecimal = lirasFormatted(liraPart)
        let formatter = NumberFormatter()
        formatter.locale = Locale(identifier: "tr_TR")
        let decimalSeparator = formatter.decimalSeparator! //"."
        let liraComponents = lirasWithDecimal.components(separatedBy:decimalSeparator) //"123,123" "12"
        var liras = liraComponents.first! //"123,123"
        liras.removeFirst() // "baştaki ₺ yi atarız
        return liras
    }
    // 0.12 > 12
    private func convertKurus(_ kurusPart: Double) -> String {
        let kurus: String
        if kurusPart == 0 {
            kurus = "00"
        }else {
            kurus = String(format: "%.0f", kurusPart * 100)
        }
        return kurus
    }
    func lirasFormatted(_ liras: Double) -> String {
        let formatter = NumberFormatter()
        formatter.numberStyle = .currency
        formatter.usesGroupingSeparator = true
        formatter.locale = Locale(identifier: "tr_TR")
        
        if let result = formatter.string(from: liras as NSNumber) {
            return result
        }
        return " "
    }
    
    private func makeBalanceAttributed(liras: String, kurus: String) -> NSMutableAttributedString {
        let liraSignAttributes: [NSAttributedString.Key : Any] = [.font: UIFont.preferredFont(forTextStyle: .callout), .baselineOffset: 8]
        let liraAttributes: [NSAttributedString.Key: Any] = [.font: UIFont.preferredFont(forTextStyle: .title1)]
        let kurusAttributes: [NSAttributedString.Key: Any] = [.font: UIFont.preferredFont(forTextStyle: .callout), .baselineOffset: 8]
        
        let rootString = NSMutableAttributedString(string: "₺", attributes: liraSignAttributes)
        let liraString = NSAttributedString(string: liras, attributes: liraAttributes)
        let kurusString = NSAttributedString(string: kurus, attributes: kurusAttributes)
        
        rootString.append(liraString)
        rootString.append(kurusString)
        
        return rootString
    }
}
