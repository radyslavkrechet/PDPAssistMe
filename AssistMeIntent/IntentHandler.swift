//
//  IntentHandler.swift
//  AssistMeIntent
//
//  Created by Radyslav Krechet on 3/17/19.
//  Copyright © 2019 RubyGarage. All rights reserved.
//

import Intents

class IntentHandler: INExtension {
    override func handler(for intent: INIntent) -> Any? {
        if intent is INStartWorkoutIntent {
            return StartWorkoutIntentHandler()
        } else if intent is INEndWorkoutIntent {
            return EndWorkoutIntentHandler()
        } else {
            return OrderProductIntentHandler()
        }
    }
}
