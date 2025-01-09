//
//  Trainer.swift
//  AI Trainer
//
//  Created by Oliver Ostojic on 1/8/25.
//
// This contains all the trainer structs and classes
import Foundation

class Trainer {
    let id: UUID
    let recommendationEngine: RecommendationEngine
    let insightEngine: InsightEngine
    
    init() {
        self.id = UUID()
        self.recommendationEngine = RecommendationEngine()
        self.insightEngine = InsightEngine()
    }
    
    func generateSessionInsights(sessionTemplate: WorkoutSessionTemplate) {
        // Figure out
    }
    
    // Function to generate recommendations post workout completion.
    func generateRecommendations(user_id: UUID) {
        // Figure out how to pass in and parse all user data
    }
    
    // Function to generate updated recommendations from user input.
    // Ex: User inputs a weight and set, calculated from their intensity level,
    // the remaining sets are updated to keep user on track.
    func generateUpdatedRecommendationsFromUserInput(exercise: Exercise, workoutSet: WorkoutSet) {
        
    }
    
    func updateNeuralParameters() {
        // Figure out
    }
}

class TrainerSession {
    let id: UUID
    var sessionTemplate: WorkoutSessionTemplate
    let trainer: Trainer
    
    init(user: User) {
        self.id = UUID()
        self.sessionTemplate = WorkoutSessionTemplate(user: user)
        self.trainer = Trainer()
        
    }
    
    // Function to initalize trainer
    func startTrainer() {
        // Constantly check for (weight, reps) to be inputted.
    }
    
    // Generate a WorkoutSession object and save it once session is complete.
    func generateWorkoutSession() {
        
    }
    
    // If previous workout data exists, fill in template with recommendations.
    func initSessionTemplateWithRecommendations() {
        
    }
    
}
