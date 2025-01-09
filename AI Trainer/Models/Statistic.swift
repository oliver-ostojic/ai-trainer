//
//  Statistic.swift
//  AI Trainer
//
//  Created by Oliver Ostojic on 1/9/25.
//
// This model encompasses the Statistic class
import Foundation

struct WeeklyStatistic {
    let id: UUID
    let weightAverages: [MuscleGroup: Double]
    let repTotals: [MuscleGroup: Int]
    let streak: Int
    let plateaus: [PlateauInstance]
    let progress: [ProgressInstance]
    let insights: [WorkoutInsight]
    
    init(weeklySessions: [WorkoutSession]) {
        self.id = UUID()
        // Compute averages
        
        // Generate progress insights
        
        // Generate trend insights
        
        // Temporary
        self.weightAverages = [:]
        self.repTotals = [:]
        self.streak = 0
        self.plateaus = []
        self.progress = []
        self.insights = []
    }
}

class AnalyticsEngine {
    let id: UUID
    
    init() {
        self.id = UUID()
    }
    
    func generateWeeklyStats(weeklySessions: [WorkoutSession]) {
        
    }
    
    // Create and save chart data points
    func generateChartData(weeklyStat: WeeklyStatistic) {
        
    }
}
