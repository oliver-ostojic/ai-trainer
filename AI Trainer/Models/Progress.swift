//
//  Progress.swift
//  AI Trainer
//
//  Created by Oliver Ostojic on 1/9/25.
//
// This code pertains to the progress engine that detects progress or
// plateaus in training process
import Foundation

struct PlateauInstance {
    let muscle: MuscleGroup
    let lastIntervalAverage: Double
}

struct ProgressInstance {
    let muscle: MuscleGroup
    let averageIncrease: Double
}

class ProgressDetectionEngine {
    let id: UUID
    
    init() {
        self.id = UUID()
    }
    
    func detectPlateaus(user_id: UUID) {
        
    }
    
    func detectProgress(user_id: UUID) {
        
    }
}

