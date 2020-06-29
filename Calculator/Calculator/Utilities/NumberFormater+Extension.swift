//
//  NumberFormater+Extension.swift
//  Calculator
//
//  Created by Devi Prasad Ghimire on 29/6/20.
//  Copyright © 2020 Devi Prasad Ghimire. All rights reserved.
//

import Foundation

let formatToCalculate: NumberFormatter = {
    let formatter = NumberFormatter()
    let locale = Locale.current
    formatter.groupingSeparator = ""
    formatter.decimalSeparator = locale.decimalSeparator
    formatter.numberStyle = .decimal
    formatter.maximumIntegerDigits = 100
    formatter.minimumFractionDigits = 0
    formatter.maximumFractionDigits = 100
    return formatter
}()

let formatToCalculateTotal: NumberFormatter = {
    let formatter = NumberFormatter()
    formatter.groupingSeparator = ""
    formatter.decimalSeparator = ""
    formatter.numberStyle = .decimal
    formatter.maximumIntegerDigits = 100
    formatter.minimumFractionDigits = 0
    formatter.maximumFractionDigits = 100
    return formatter
}()

let formatToDisplay: NumberFormatter = {
    let formatter = NumberFormatter()
    let locale = Locale.current
    formatter.groupingSeparator = locale.groupingSeparator
    formatter.decimalSeparator = locale.decimalSeparator
    formatter.numberStyle = .decimal
    formatter.maximumIntegerDigits = 9
    formatter.minimumFractionDigits = 0
    formatter.maximumFractionDigits = 8
    return formatter
}()

let formatToDisplayScientific: NumberFormatter = {
    let formatter = NumberFormatter()
    formatter.numberStyle = .scientific
    formatter.maximumFractionDigits = 3
    formatter.exponentSymbol = "e"
    return formatter
}()
