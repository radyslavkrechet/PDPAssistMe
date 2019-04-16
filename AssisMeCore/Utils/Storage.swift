//
//  Storage.swift
//  AssisMeCore
//
//  Created by Radyslav Krechet on 4/8/19.
//  Copyright © 2019 RubyGarage. All rights reserved.
//

import Foundation

private let suiteName = "group.rubygarage.pdp.assistme"

struct Storage {
    static let defaults = UserDefaults(suiteName: suiteName)!
}
