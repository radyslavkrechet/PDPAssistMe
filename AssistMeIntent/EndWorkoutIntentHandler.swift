//
//  EndWorkoutIntentHandler.swift
//  AssistMeIntent
//
//  Created by Radyslav Krechet on 3/31/19.
//  Copyright © 2019 RubyGarage. All rights reserved.
//

import Intents
import AssisMeCore

class EndWorkoutIntentHandler: NSObject, INEndWorkoutIntentHandling {

    // MARK: - INEndWorkoutIntentHandling
    
    func handle(intent: INEndWorkoutIntent, completion: @escaping (INEndWorkoutIntentResponse) -> Void) {
        let result: INEndWorkoutIntentResponse

        if WorkoutService.current != nil {
            result = INEndWorkoutIntentResponse(code: .handleInApp, userActivity: nil)
        } else {
            result = INEndWorkoutIntentResponse(code: .failureNoMatchingWorkout, userActivity: nil)
        }

        completion(result)
    }
}
