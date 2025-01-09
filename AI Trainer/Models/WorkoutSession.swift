//
//  WorkoutSession.swift
//  AI Trainer
//
//  Created by Oliver Ostojic on 1/8/25.
//
// This contains all workouts related to WorkoutSessions
import Foundation

enum SessionType {
    case restDay
    case personalRecordDay
    case normalDay
}

struct WorkoutSessionTemplate {
    var workoutEntries: [WorkoutEntry]
    
    init(user: User) {
        // Initialize with zero values
        
        // Or init with recommendations if data exists
        
        // Temporary
        self.workoutEntries = []
    }
}

class WorkoutSession {
    let id: UUID
    let workoutEntries: [WorkoutEntry]
    let date: Date
    let duration: TimeInterval
    let insights: [WorkoutInsight]
    let intensity: SessionType
    
    init(session: TrainerSession) {
        // Create insights call function
        self.id = UUID()
        // Create today's date object
        let today = Calendar.current.startOfDay(for: Date())
        self.date = today
        // Temporary
        self.workoutEntries = []
        self.duration = 0
        self.insights = []
        self.intensity = SessionType.normalDay
    }
}
