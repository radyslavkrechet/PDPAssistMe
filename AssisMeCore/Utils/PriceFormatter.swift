//
//  PriceFormatter.swift
//  AssistMe
//
//  Created by Radyslav Krechet on 4/15/19.
//  Copyright © 2019 RubyGarage. All rights reserved.
//

import Foundation

public struct PriceFormatter {
    public static func format(_ price: Double) -> String {
        return String(format: "$%.2f", price)
    }

    public static func format(_ price: Double, with count: Double) -> String {
        let totalPrice = format(price * count)
        let countDescription = "item\(count > 1 ? "s" : "")"
        return String(format: "Total (%.0f %@): %@", count, countDescription, totalPrice)
    }
}
