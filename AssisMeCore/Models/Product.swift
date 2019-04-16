//
//  Product.swift
//  AssisMeCore
//
//  Created by Radyslav Krechet on 4/8/19.
//  Copyright © 2019 RubyGarage. All rights reserved.
//

import Foundation

public struct Product: Codable {
    public let id: String
    public let name: String
    public let imageName: String
    public let price: Double
}
