//
//  User.swift
//  AI Trainer
//
//  Created by Oliver Ostojic on 1/7/25.
//
// This contains the User class

// UserLevel specifies things such as intensity, and set range.
import Foundation

enum UserLevel {
    case novice
    case intermediate
    case advanced
    
    var setCount: Int8 {
        switch self {
        case .novice:
            return 2
        case .intermediate:
            return 3
        case .advanced:
            return 3
        }
    }
    var repetitionMaxRange: ClosedRange<Double> {
        switch self {
        case .novice:
            return 60...70
        case .intermediate:
            return 70...80
        case .advanced:
            return 70...100
        }
    }
}

class User {
    let id: UUID
    let name: String
    var level: UserLevel
    var goal: MuscleGroup
    var schedule: WorkoutSchedule
    
    init( name: String, level: UserLevel, goal: MuscleGroup) {
        self.id = UUID()
        self.name = name
        self.level = level
        self.goal = goal
        self.schedule = WorkoutSchedule()
    }
    
    func editGoal(goal: MuscleGroup) {
        self.goal = goal
    }
    
    func editLevel(level: UserLevel) {
        self.level = level
    }
    
    func startWorkoutSession() {
        print("Workout session started for \(self.name)!")
    }
    
    func fetchMuscleData(muscle: MuscleGroup) {
        print("Fetching data for \(muscle).")
    }
    
    func fetchWorkoutSession(session: WorkoutSession) {
        print("Fetching data for session: \(session)")
    }
}

