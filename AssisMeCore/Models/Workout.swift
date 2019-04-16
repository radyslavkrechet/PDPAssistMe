//
//  Workout.swift
//  AssisMeCore
//
//  Created by Radyslav Krechet on 3/31/19.
//  Copyright © 2019 RubyGarage. All rights reserved.
//

import Foundation

public struct Workout: Codable {
    public enum Kind: String, CaseIterable, Codable {
        case run
        case walk
    }

    public enum Goal: Int, Codable {
        case miles
        case minutes
        case calories

        public var availability: (min: Double, max: Double, step: Double) {
            switch self {
            case .miles:
                return (1, 10, 1)
            case .minutes:
                return (5, 60, 5)
            case .calories:
                return (50, 250, 50)
            }
        }

        init?(goal: Int) {
            switch goal {
            case 4:
                self = .miles
            case 7:
                self = .minutes
            case 10:
                self = .calories
            default:
                return nil
            }
        }
    }

    public let kind: Kind
    public let goal: Goal
    public let value: Double
}
