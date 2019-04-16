//
//  AppDelegate.swift
//  AssistMe
//
//  Created by Radyslav Krechet on 3/17/19.
//  Copyright © 2019 RubyGarage. All rights reserved.
//

import UIKit
import Intents
import AssisMeCore

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    var window: UIWindow?

    // MARK: - UIApplicationDelegate

    func application(_ application: UIApplication,
                     didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {

        requestSiriAuthorization()
        
        return true
    }

    func application(_ application: UIApplication,
                     handle intent: INIntent,
                     completionHandler: @escaping (INIntentResponse) -> Void) {

        let response: INIntentResponse

        if let intent = intent as? INStartWorkoutIntent {
            WorkoutService.start(with: intent)

            if let tabBarController = window?.rootViewController as? UITabBarController,
                let navigationController = tabBarController.viewControllers?.first as? UINavigationController,
                let workoutViewController = navigationController.viewControllers.first as? WorkoutViewController {

                workoutViewController.setupWorkout()
                workoutViewController.setupUI()
            }

            response = INStartWorkoutIntentResponse(code: .success, userActivity: nil)
        } else if let _ = intent as? INEndWorkoutIntent {
            WorkoutService.end()
            
            if let tabBarController = window?.rootViewController as? UITabBarController,
                let navigationController = tabBarController.viewControllers?.first as? UINavigationController,
                let workoutViewController = navigationController.viewControllers.first as? WorkoutViewController {

                workoutViewController.setupWorkout()
                workoutViewController.setupUI()
            }

            response = INEndWorkoutIntentResponse(code: .success, userActivity: nil)
        } else {
            response = INStartWorkoutIntentResponse(code: .failure, userActivity: nil)
        }

        completionHandler(response)
    }

    // MARK: - Setup

    private func requestSiriAuthorization() {
        INPreferences.requestSiriAuthorization { status in }
    }
}
