//
//  Model_Unit_Tests.swift
//  Model Unit Tests
//
//  Created by Oliver Ostojic on 1/9/25.
//

import XCTest
@testable import AI_Trainer

final class Model_Unit_Tests: XCTestCase {
    func testUserInitialization() {
        // Arrange
        let name = "Oliver"
        let level = UserLevel.intermediate
        let goal = MuscleGroup.chest
        // Act
        let user = User(name: name, level: level, goal: goal)
        // Assert
        XCTAssertEqual(user.name, name, "User name should be initialized correctly.")
        XCTAssertEqual(user.level, level, "User level should be initialized correctly.")
        XCTAssertEqual(user.goal, goal, "User goal should be initialized correctly.")
    }
    
    func testUpdateUserGoal() {
        // Arrange
        let name = "Oliver"
        let level = UserLevel.intermediate
        let goal = MuscleGroup.chest
        let updated_goal = MuscleGroup.quadricep
        // Act
        let user = User(name: name, level: level, goal: goal)
        user.editGoal(goal: updated_goal)
        // Assert
        XCTAssertEqual(user.goal, updated_goal, "User goal should be updated correctly.")
    }
    
    func testUpdateUserLevel() {
        // Arrange
        let name = "Oliver"
        let level = UserLevel.intermediate
        let goal = MuscleGroup.chest
        let updated_level = UserLevel.advanced
        // Act
        let user = User(name: name, level: level, goal: goal)
        user.editLevel(level: updated_level)
        // Assert
        XCTAssertEqual(user.level, updated_level, "User level should be updated correctly.")
    }
}
