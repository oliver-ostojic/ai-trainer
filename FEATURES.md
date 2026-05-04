# AI Trainer — Feature Bank

> **Purpose:** Resume ammunition. Each feature entry has enough technical and contextual detail to generate tailored bullets for different job types.
> Filter by `Tags` to pull relevant features per application, then ask Claude to synthesize into polished bullets.
>
> **Job type tags:** `[ios]` `[mobile]` `[data-modeling]` `[ml-adjacent]` `[persistence]` `[architecture]` `[algorithms]` `[fullstack]` `[testing]`

---

## 1. Data Modeling & Domain Layer

---

### Workout Domain Model

Defines the full exercise taxonomy as a structured Swift type system. `MuscleGroup` enumerates 18 distinct muscle targets (bicep through abductors). `ExerciseType` distinguishes equipment categories (cable machine, dumbbell, barbell). `Exercise` composes a muscle target and equipment type. `WorkoutEntry` aggregates an exercise with its recorded sets and a per-entry difficulty rating (1–10 scale via `Int8`). `WorkoutSet` captures the atomic unit of training: reps and weight.

**Key files:** [AI Trainer/Models/Workout.swift](AI%20Trainer/Models/Workout.swift)
**Tech:** Swift, value types (`struct`), enums with associated semantics, composition over inheritance
**Tags:** `[data-modeling]` `[ios]` `[mobile]`

---

### User Profile & Level System

`User` is a reference-type model holding a UUID identity, display name, fitness level, primary muscle goal, and a `WorkoutSchedule`. `UserLevel` (novice / intermediate / advanced) drives two computed properties used by the recommendation engine: `setCount` (2 for novice, 3 otherwise) and `repetitionMaxRange` — a `ClosedRange<Double>` that maps level to a target percentage-of-max-effort band (60–70% novice, 70–80% intermediate, 70–100% advanced). Methods `editGoal` and `editLevel` expose mutable state through explicit intent-named functions rather than direct property writes.

**Key files:** [AI Trainer/Models/User.swift](AI%20Trainer/Models/User.swift)
**Tech:** Swift, `enum` computed properties, `ClosedRange`, reference semantics (`class`)
**Tags:** `[data-modeling]` `[ios]` `[ml-adjacent]`

---

### Weekly Statistics Aggregation

`WeeklyStatistic` is a value-type snapshot computed from a `[WorkoutSession]` slice. Fields include per-muscle weight averages (`[MuscleGroup: Double]`), per-muscle rep totals (`[MuscleGroup: Int]`), a consecutive-day training streak (`Int`), plateau detections (`[PlateauInstance]`), progress instances (`[ProgressInstance]`), and generated insights (`[WorkoutInsight]`). Designed to be computed once per week boundary and handed to the `InsightEngine` and `AnalyticsEngine` for downstream processing.

**Key files:** [AI Trainer/Models/Statistic.swift](AI%20Trainer/Models/Statistic.swift)
**Tech:** Swift, dictionary-keyed aggregation, value types, enum-keyed `[MuscleGroup: T]` maps
**Tags:** `[data-modeling]` `[algorithms]` `[ml-adjacent]`

---

## 2. AI / Recommendation Engine

---

### Recommendation Engine

`RecommendationEngine` is a class owned by `Trainer` responsible for pre-populating session templates with weight and rep targets. `generateWeightSuggestions(user:)` reads a user's level and training history to produce full-session recommendations. `singleExerciseRecommendation(inputted_set:workoutEntry:)` handles real-time mid-session updates: when a user logs a set, remaining sets in that entry are recalculated to keep the user on pace with their `UserLevel.repetitionMaxRange` target intensity.

**Key files:** [AI Trainer/Models/Recommendation.swift](AI%20Trainer/Models/Recommendation.swift), [AI Trainer/Models/Trainer.swift](AI%20Trainer/Models/Trainer.swift)
**Tech:** Swift, CoreML (planned), user-level parameterized logic
**Tags:** `[ml-adjacent]` `[algorithms]` `[ios]`

---

### Insight Engine

`InsightEngine` produces `WorkoutInsight` records across three time horizons: per-session (`generateSessionInsights`), weekly (`generateWeeklyInsights`), and all-time (`generateToDateInsights`). Each `WorkoutInsight` carries a typed `InsightType` (sessionFocus, personalRecord, intensity, volumeLoad), a human-readable message string, and an `isPositive` polarity flag for UI rendering (green vs. red feedback). Insights are embedded directly in `WorkoutSession` and `WeeklyStatistic` records.

**Key files:** [AI Trainer/Models/Insight.swift](AI%20Trainer/Models/Insight.swift)
**Tech:** Swift, enum-typed domain events, value semantics
**Tags:** `[ml-adjacent]` `[data-modeling]` `[ios]`

---

### Progress & Plateau Detection Engine

`ProgressDetectionEngine` operates on a user's session history to surface two signal types. `detectPlateaus(user_id:)` identifies stagnation by comparing recent interval averages per muscle (`PlateauInstance.lastIntervalAverage`). `detectProgress(user_id:)` tracks upward trends via `ProgressInstance.averageIncrease` per muscle. Both outputs feed `WeeklyStatistic` and downstream insight generation, closing the feedback loop between raw logged data and actionable coaching signals.

**Key files:** [AI Trainer/Models/Progress.swift](AI%20Trainer/Models/Progress.swift)
**Tech:** Swift, time-series comparison logic, per-muscle-group signal isolation
**Tags:** `[algorithms]` `[ml-adjacent]` `[data-modeling]`

---

## 3. Session & Scheduling Architecture

---

### Trainer Session Lifecycle

`TrainerSession` orchestrates the full arc of a single workout. On init it creates a `WorkoutSessionTemplate` (pre-filled with recommendations if history exists via `initSessionTemplateWithRecommendations`) and binds a `Trainer` instance. `startTrainer()` enters a live input loop monitoring `(weight, reps)` entries; each input triggers `Trainer.generateUpdatedRecommendationsFromUserInput` to recalculate remaining sets in real time. On completion, `generateWorkoutSession()` serializes the session into an immutable `WorkoutSession` for persistence.

**Key files:** [AI Trainer/Models/Trainer.swift](AI%20Trainer/Models/Trainer.swift), [AI Trainer/Models/WorkoutSession.swift](AI%20Trainer/Models/WorkoutSession.swift)
**Tech:** Swift, reference-type lifecycle management, template pattern
**Tags:** `[architecture]` `[ios]` `[mobile]`

---

### Workout Scheduling System

`WorkoutSchedule` holds an ordered list of `ScheduleEntity` records, each mapping a `DayOfWeek` to a named workout (e.g., "Leg Day") and its target `[MuscleGroup]` list. The schedule is stored on `User` and drives both session template initialization (which muscles to include) and planned notification triggers. Supports arbitrary multi-muscle days and is designed to be editable at runtime without invalidating existing `WorkoutSession` history.

**Key files:** [AI Trainer/Models/Workout.swift](AI%20Trainer/Models/Workout.swift)
**Tech:** Swift, `DayOfWeek` enum, value-type scheduling entities
**Tags:** `[data-modeling]` `[ios]` `[mobile]`

---

### Session Type Classification

`WorkoutSession` records carry a `SessionType` classification: `restDay`, `personalRecordDay`, or `normalDay`. Classification is assigned at session-close time, enabling the analytics layer to segment weekly statistics and weight PR-day sessions differently when computing progress trends and generating motivational insights.

**Key files:** [AI Trainer/Models/WorkoutSession.swift](AI%20Trainer/Models/WorkoutSession.swift)
**Tech:** Swift, enum-based session tagging
**Tags:** `[data-modeling]` `[algorithms]`

---

## 4. Persistence Layer

---

### Core Data Stack

`CoreDataManager` is a singleton wrapping an `NSPersistentContainer` named `AI_Trainer`. The managed object context is exposed via a `viewContext` computed property. `saveContext()` guards against no-op saves (`context.hasChanges`) and fails fast with `fatalError` on unresolved store errors — appropriate for a local-first mobile app where a broken store is unrecoverable without user intervention. The `.xcdatamodeld` schema backs all domain model persistence.

**Key files:** [AI Trainer/Services/CoreDataManager.swift](AI%20Trainer/Services/CoreDataManager.swift), [AI Trainer/Resources/AI_Trainer.xcdatamodeld](AI%20Trainer/Resources/AI_Trainer.xcdatamodeld)
**Tech:** Swift, CoreData, `NSPersistentContainer`, `NSManagedObjectContext`, singleton pattern
**Tags:** `[persistence]` `[ios]` `[architecture]`

---

## 5. Testing

---

### Model Unit Test Suite

XCTest suite covering `User` model initialization and mutation. Tests follow strict AAA (Arrange / Act / Assert) structure. `testUserInitialization` verifies all three constructor parameters are stored correctly. `testUpdateUserGoal` and `testUpdateUserLevel` verify the `editGoal` and `editLevel` mutation methods against known before/after states. Uses `@testable import AI_Trainer` to access internal types without relaxing access control in production code.

**Key files:** [AI Trainer/Tests/Model Unit Tests/Model_Unit_Tests.swift](AI%20Trainer/Tests/Model%20Unit%20Tests/Model_Unit_Tests.swift)
**Tech:** Swift, XCTest, `@testable import`, AAA pattern
**Tags:** `[testing]` `[ios]`

---

## 6. App Architecture

---

### SwiftUI App Entry & Scene Management

App entry point uses the `@main` attribute on `AI_TrainerApp` conforming to the `App` protocol, Swift's declarative alternative to `UIApplicationDelegate`. A single `WindowGroup` scene wraps `ContentView`, letting the OS manage multi-window lifecycle on iPadOS/macOS without manual scene delegation. `ContentView` is registered as a `PreviewProvider` for hot-reload design iteration in Xcode Previews without building to a simulator.

**Key files:** [AI Trainer/App/AI_TrainerApp.swift](AI%20Trainer/App/AI_TrainerApp.swift), [AI Trainer/Views/ContentView.swift](AI%20Trainer/Views/ContentView.swift)
**Tech:** SwiftUI, `@main`, `App` protocol, `WindowGroup`, `PreviewProvider`
**Tags:** `[ios]` `[mobile]` `[architecture]`

---

## 7. Planned Architecture

> These entries describe architectural decisions and integrations designed into the system but not yet implemented. Useful for conveying technical scope and intentional design.

---

### CoreML On-Device Recommendation Model

The `RecommendationEngine` is designed to back its weight/rep suggestions with a CoreML model trained on anonymized workout progression data. The `.mlmodel` file compiles into the app bundle at build time; inference runs entirely on-device via the Neural Engine — no network round-trip. The `UserLevel.repetitionMaxRange` bands serve as rule-based fallback output when the model has insufficient history (cold-start problem). Model inputs are per-muscle `(lastWeight, lastReps, sessionCount, level)` feature vectors; output is a predicted `(recommendedWeight, recommendedReps)` tuple.

**Key files:** [AI Trainer/Models/Recommendation.swift](AI%20Trainer/Models/Recommendation.swift)
**Tech:** CoreML, `MLModel`, `MLFeatureProvider`, Neural Engine, on-device inference, cold-start fallback
**Tags:** `[ml-adjacent]` `[algorithms]` `[ios]` `[mobile]`

---

### CloudKit Cross-Device Sync

Workout history stored in CoreData is designed to sync across a user's devices via CloudKit using `NSPersistentCloudKitContainer` — a drop-in upgrade to `NSPersistentContainer` that mirrors the local SQLite store to CloudKit's private database. Conflict resolution uses CloudKit's last-write-wins strategy at the record level, appropriate for workout log data where concurrent writes across devices are rare. No server infrastructure required; all sync logic is handled by the framework.

**Key files:** [AI Trainer/Services/CoreDataManager.swift](AI%20Trainer/Services/CoreDataManager.swift)
**Tech:** CloudKit, `NSPersistentCloudKitContainer`, iCloud private database, automatic sync
**Tags:** `[persistence]` `[fullstack]` `[ios]` `[architecture]`

---

### Push Notification & Workout Reminder System

The `WorkoutSchedule` stored on `User` is designed to drive local push notifications via the `UserNotifications` framework. On schedule edit, the app cancels all pending `UNNotificationRequest` objects for that user and re-registers a new set keyed by `ScheduleEntity.id`. Each notification fires at a user-configured time on the matching `DayOfWeek` using `UNCalendarNotificationTrigger`. No remote server involvement — all scheduling is local, preserving user privacy.

**Key files:** [AI Trainer/Models/Workout.swift](AI%20Trainer/Models/Workout.swift)
**Tech:** `UserNotifications`, `UNUserNotificationCenter`, `UNCalendarNotificationTrigger`, `UNNotificationRequest`
**Tags:** `[ios]` `[mobile]` `[architecture]`

---

### Analytics Chart Data Pipeline

`AnalyticsEngine.generateChartData(weeklyStat:)` is designed to transform a `WeeklyStatistic` snapshot into chart-ready data point structs for rendering in SwiftUI via Swift Charts. The pipeline: raw `WorkoutSession` records → `WeeklyStatistic` aggregation (weight averages, rep totals, plateau/progress flags) → chart data point series keyed by `MuscleGroup` and week boundary date. Enables sparkline-style per-muscle progress views and full-history trend lines without re-scanning the full session log on each render.

**Key files:** [AI Trainer/Models/Statistic.swift](AI%20Trainer/Models/Statistic.swift)
**Tech:** Swift Charts, `AnalyticsEngine`, `WeeklyStatistic`, `[MuscleGroup: Double]` series
**Tags:** `[ios]` `[mobile]` `[data-modeling]` `[algorithms]`
