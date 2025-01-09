//
//  CoreDataManager.swift
//  AI Trainer
//
//  Created by Oliver Ostojic on 1/9/25.
//
// The Core Data manager manages all persistence data storage.

import Foundation
import CoreData

class CoreDataManager {
    static let shared = CoreDataManager()
    // Persistent container for Core Data Stack
    let persistentContainer: NSPersistentContainer
    // Context for interacting with core data
    var context: NSManagedObjectContext {
        return persistentContainer.viewContext
    }
    
    private init() {
        // Initialize the persistent container
        self.persistentContainer = NSPersistentContainer(name: "AI_Trainer")
        // Load the persistent stores
        self.persistentContainer.loadPersistentStores { storeDescription, error in
            if let error = error {
                fatalError("Unresolved error \(error.localizedDescription)")
            }
        }
    }
    
    // Save the current state of the managed object context to the persistent store
    func saveContext() {
        let context = persistentContainer.viewContext
        if context.hasChanges {
            do {
                try context.save()
            } catch {
                let nserror = error as NSError
                fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
            }
        }
    }
}

