//
//  AppFormatters.swift
//  Balam
//
//  Created by Alejandro Zamudio Guajardo on 30/07/2021.
//

import Foundation

struct AppFormatters {

    let currencyFormatter: NumberFormatter = {
        let formatter = NumberFormatter()
        formatter.allowsFloats = true
        formatter.alwaysShowsDecimalSeparator = false
        formatter.currencyCode = "USD"
        formatter.currencySymbol = "$"
        formatter.currencyDecimalSeparator = "."
        formatter.currencyGroupingSeparator = ","
        formatter.numberStyle = .currencyISOCode
        formatter.roundingMode = .ceiling
        return formatter
    }()

}
