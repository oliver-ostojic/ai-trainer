//
//  Insight.swift
//  AI Trainer
//
//  Created by Oliver Ostojic on 1/9/25.
//
// This code pertains to the insight engine
import Foundation

struct WorkoutInsight {
    let id: UUID
    let type: InsightType
    let message: String
    let isPositive: Bool
    
    enum InsightType {
        case sessionFocus
        case personalRecord
        case intensity
        case volumeLoad
    }
    
    init(type: InsightType, message: String, isPositive: Bool) {
        self.id = UUID()
        self.type = type
        self.message = message
        self.isPositive = isPositive
    }
}

class InsightEngine {
    let id: UUID
    
    init() {
        self.id = UUID()
    }
    
    func generateWeeklyInsights(weeklyStat: WeeklyStatistic) {
        
    }
    
    func generateToDateInsights(user_id: UUID) {
        
    }
    
    func generateSessionInsights(workoutSessionTemplate: WorkoutSessionTemplate) {
        
    }
    
}
