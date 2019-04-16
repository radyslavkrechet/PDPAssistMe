//
//  ProductService.swift
//  AssisMeCore
//
//  Created by Radyslav Krechet on 4/8/19.
//  Copyright © 2019 RubyGarage. All rights reserved.
//

import Foundation

public struct ProductService {
    public static let all = [
        Product(id: "1", name: "Power Speed Ultimate", imageName: "ultimate", price: 9.99),
        Product(id: "2", name: "Power Speed Extreme", imageName: "extreme", price: 14.99)
    ]

    public static func product(withId id: String) -> Product? {
        return all.first(where: { $0.id == id })
    }
}
