//
//  Order.swift
//  AssisMeCore
//
//  Created by Radyslav Krechet on 4/15/19.
//  Copyright © 2019 RubyGarage. All rights reserved.
//

import Foundation

public struct Order: Codable {
    public let id: UUID
    public let product: Product
    public let count: Double
}
