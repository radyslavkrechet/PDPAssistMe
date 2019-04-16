//
//  WorkoutService.swift
//  AssisMeCore
//
//  Created by Radyslav Krechet on 4/8/19.
//  Copyright © 2019 RubyGarage. All rights reserved.
//

import Foundation
import Intents

private let kindKey = "kind"
private let goalKey = "goal"
private let valueKey = "value"
private let workoutKey = "workout"

public struct WorkoutService {
    public static var current: Workout? {
        guard let data = Storage.defaults.data(forKey: workoutKey) else {
            return nil
        }

        return try! JSONDecoder().decode(Workout.self, from: data)
    }

    public static func start(with kind: Workout.Kind, goal: Workout.Goal, value: Double) {
        let workout = Workout(kind: kind, goal: goal, value: value)
        start(workout: workout)
    }

    public static func start(with intent: INStartWorkoutIntent) {
        let kind = Workout.Kind(rawValue: intent.workoutName!.spokenPhrase)!
        let goal = Workout.Goal(goal: intent.workoutGoalUnitType.rawValue)!
        let value = intent.goalValue!
        let workout = Workout(kind: kind, goal: goal, value: value)
        start(workout: workout)
    }

    public static func end() {
        Storage.defaults.set(nil, forKey: workoutKey)
    }

    private static func start(workout: Workout) {
        let data = try! JSONEncoder().encode(workout)
        Storage.defaults.set(data, forKey: workoutKey)
    }
}
