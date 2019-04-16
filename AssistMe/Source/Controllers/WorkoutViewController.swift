//
//  WorkoutViewController.swift
//  AssistMe
//
//  Created by Radyslav Krechet on 3/17/19.
//  Copyright © 2019 RubyGarage. All rights reserved.
//

import UIKit
import AssisMeCore

class WorkoutViewController: UIViewController {
    @IBOutlet private(set) weak var kindSegmentedControl: UISegmentedControl!
    @IBOutlet private(set) weak var goalSegmentedControl: UISegmentedControl!
    @IBOutlet private(set) weak var valueLabel: UILabel!
    @IBOutlet private(set) weak var valueStepper: UIStepper!
    @IBOutlet private(set) weak var actionButton: UIButton!

    private var workout: Workout?
    private var kind: Workout.Kind!
    private var goal: Workout.Goal!
    private var value: Double!

    // MARK: - View controller lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()

        setupWorkout()
        setupUI()
    }

    // MARK: - Setup

    func setupWorkout() {
        workout = WorkoutService.current

        if let workout = workout {
            kind = workout.kind
            goal = workout.goal
            value = workout.value
        } else {
            kind = .run
            goal = .miles
            value = Workout.Goal.miles.availability.min
        }
    }

    func setupUI() {
        if workout == nil {
            kindSegmentedControl.isEnabled = true
            goalSegmentedControl.isEnabled = true
            valueStepper.isHidden = false
        } else {
            kindSegmentedControl.isEnabled = false
            goalSegmentedControl.isEnabled = false
            valueStepper.isHidden = true
        }

        setupKindSegmentedControl()
        setupGoalSegmentedControl()
        setupValueLabel()
        setupValueStepper()
        setupActionButton()
    }

    private func setupKindSegmentedControl() {
        kindSegmentedControl.selectedSegmentIndex = Workout.Kind.allCases.firstIndex(of: kind)!
    }

    private func setupGoalSegmentedControl() {
        goalSegmentedControl.selectedSegmentIndex = goal.rawValue
    }

    private func setupValueLabel() {
        valueLabel.text = String(Int(value))
    }

    private func setupValueStepper() {
        let (min, max, step) = goal.availability
        valueStepper.minimumValue = min
        valueStepper.maximumValue = max
        valueStepper.stepValue = step
        valueStepper.value = value
    }

    private func setupActionButton() {
        let title = workout == nil ? "Start" : "Stop"
        actionButton.setTitle(title, for: .normal)
    }

    // MARK: - Actions

    @IBAction private func kindSegmentedControlDidChangeValue(_ sender: UISegmentedControl) {
        let title = sender.titleForSegment(at: sender.selectedSegmentIndex)!.lowercased()
        kind = Workout.Kind(rawValue: title)!
    }
    
    @IBAction private func goalSegmentedControlDidChangeValue(_ sender: UISegmentedControl) {
        goal = Workout.Goal(rawValue: sender.selectedSegmentIndex)!
        value = goal.availability.min
        setupValueLabel()
        setupValueStepper()
    }

    @IBAction private func valueStepperDidChangeValue(_ sender: UIStepper) {
        value = sender.value
        setupValueLabel()
    }
    
    @IBAction private func actionButtonDidTap(_ sender: UIButton) {
        if workout == nil {
            WorkoutService.start(with: kind, goal: goal, value: value)
        } else {
            WorkoutService.end()
        }

        setupWorkout()
        setupUI()
    }
}
