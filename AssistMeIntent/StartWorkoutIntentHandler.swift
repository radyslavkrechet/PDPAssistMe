//
//  StartWorkoutIntentHandler.swift
//  AssistMeIntent
//
//  Created by Radyslav Krechet on 3/31/19.
//  Copyright © 2019 RubyGarage. All rights reserved.
//

import Intents
import AssisMeCore

class StartWorkoutIntentHandler: NSObject, INStartWorkoutIntentHandling {

    // MARK: - INStartWorkoutIntentHandling

    func resolveWorkoutName(for intent: INStartWorkoutIntent,
                            with completion: @escaping (INSpeakableStringResolutionResult) -> Void) {

        let result: INSpeakableStringResolutionResult

        if let workoutName = intent.workoutName {
            let names = Workout.Kind.allCases.map { $0.rawValue }

            if let name = names.first(where: { $0 == workoutName.spokenPhrase }) {
                let resolvedString = INSpeakableString(spokenPhrase: name)
                result = INSpeakableStringResolutionResult.success(with: resolvedString)
            } else {
                let stringsToDisambiguate = names.map { INSpeakableString(spokenPhrase: $0) }
                result = INSpeakableStringResolutionResult.disambiguation(with: stringsToDisambiguate)
            }
        } else {
            result = INSpeakableStringResolutionResult.needsValue()
        }

        completion(result)
    }

    func resolveGoalValue(for intent: INStartWorkoutIntent,
                          with completion: @escaping (INDoubleResolutionResult) -> Void) {

        let result: INDoubleResolutionResult
        let workoutGoalUnitType = intent.workoutGoalUnitType

        if let goalValue = intent.goalValue {
            let isValid: ((min: Double, max: Double, step: Double), INWorkoutGoalUnitType) -> Bool = { availability, type in
                let (min, max, _) = availability
                let range = min...max
                return workoutGoalUnitType == type && range.contains(goalValue)
            }

            let isValidMiles = isValid(Workout.Goal.miles.availability, INWorkoutGoalUnitType.mile)
            let isValidMinutes = isValid(Workout.Goal.minutes.availability, INWorkoutGoalUnitType.minute)
            let isValidCalories = isValid(Workout.Goal.calories.availability, INWorkoutGoalUnitType.kiloCalorie)

            if isValidMiles || isValidMinutes || isValidCalories {
                result = INDoubleResolutionResult.success(with: goalValue)
            } else {
                result = INDoubleResolutionResult.unsupported()
            }
        } else {
            result = INDoubleResolutionResult.needsValue()
        }

        completion(result)
    }

    func handle(intent: INStartWorkoutIntent, completion: @escaping (INStartWorkoutIntentResponse) -> Void) {
        let result: INStartWorkoutIntentResponse

        if WorkoutService.current == nil {
            result = INStartWorkoutIntentResponse(code: .handleInApp, userActivity: nil)
        } else {
            result = INStartWorkoutIntentResponse(code: .failureOngoingWorkout, userActivity: nil)
        }

        completion(result)
    }
}
