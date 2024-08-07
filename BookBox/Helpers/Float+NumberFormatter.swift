//
//  Double+NumberFormatter.swift
//  BookBox
//
//  Created by Oleksandr Oliinyk on 07.08.2024.
//

import Foundation

extension Float {
    private var timeFormater: NumberFormatter {
        let formatter = NumberFormatter()
        formatter.minimumFractionDigits = 2
        formatter.maximumFractionDigits = 1
        formatter.decimalSeparator = "."
        return formatter
    }
    
    func timeWith2Decimals() -> String {
        let number = NSNumber(value: self)
        return timeFormater.string(from: number) ?? "0.0"
    }
    
}
