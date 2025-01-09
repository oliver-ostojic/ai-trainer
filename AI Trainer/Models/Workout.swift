//
//  Workout.swift
//  AI Trainer
//
//  Created by Oliver Ostojic on 1/7/25.
//
// This contains all structs related to workouts
import Foundation

enum MuscleGroup {
    case bicep
    case tricep
    case chest
    case abs
    case glutes
    case lats
    case back
    case shoulder
    case hamstring
    case quadricep
    case forearm
    case calves
    case obliques
    case traps
    case deltoid
    case hipFlexors
    case adductors
    case abductors
}

enum DayOfWeek {
    case sunday
    case monday
    case tuesday
    case wednesday
    case thursday
    case friday
    case saturday
}

enum ExerciseType {
    case cableMachine
    case dumbell
    case barbell
}

struct ScheduleEntity {
    let id: UUID
    let day: DayOfWeek
    let title: String
    let muscleGroups: [MuscleGroup]
    
    init(day: DayOfWeek, title: String, muscleGroups: [MuscleGroup]) {
        self.id = UUID()
        self.day = day
        self.title = title
        self.muscleGroups = muscleGroups
    }
}

struct WorkoutSchedule {
    let id: UUID
    var schedule: [ScheduleEntity]
    
    init() {
        self.id = UUID()
        self.schedule = []
    }
}

struct WorkoutSet {
    let id: UUID
    var reps: Int8
    var weight: Double
    
    init( reps: Int8, weight: Double) {
        self.id = UUID()
        self.reps = reps
        self.weight = weight
    }
}

struct Exercise {
    let muscle: MuscleGroup
    let type: ExerciseType
    
    init(muscle: MuscleGroup, type: ExerciseType) {
        self.muscle = muscle
        self.type = type
    }
}

struct WorkoutEntry {
    let id: UUID
    let exercise: Exercise
    var sets: [WorkoutSet]
    var difficulty: Int8
    
    init(exercise: Exercise, sets: [WorkoutSet], difficulty: Int8) {
        self.id = UUID()
        self.exercise = exercise
        self.sets = sets
        self.difficulty = difficulty
    }
}
