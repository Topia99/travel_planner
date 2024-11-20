//
//  CoreDataManager.swift
//  Travel-Planner
//
//  Created by Jason Zeng on 11/17/24.
//

import Foundation
import CoreData

class CoreDataManager {
    static let instance = CoreDataManager()
    let container: NSPersistentContainer
    let context: NSManagedObjectContext
    
    init() {
        container = NSPersistentContainer(name: "TripContainer")
        container.loadPersistentStores { (description, error)  in
            if let error = error {
                print("Error loading Core Data. \(error)")
            }
        }
        context = container.viewContext
    }
    
    func save() {
        do {
            try context.save()
            print("Saved successfully")
        } catch let error {
            print("Error saving Core Data. \(error)")
        }
    }
}
