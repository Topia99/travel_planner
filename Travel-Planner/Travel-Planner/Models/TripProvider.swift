//
//  TripProvider.swift
//  Travel-Planner
//
//  Created by Jason Zeng on 11/6/24.
// Help with manage and interact with data in data stack

//import Foundation
//import CoreData
//
//
//final class TripProvider {
//    
//    static let shared = TripProvider() // make it singleton so it only have one instance
//    
//    private let persistentContainer: NSPersistentContainer
//    
//    var viewContext: NSManagedObjectContext {
//        persistentContainer.viewContext
//    }
//    
//    private init(){
//        persistentContainer = NSPersistentContainer(name: "TripsDataModel")
//        persistentContainer.viewContext.automaticallyMergesChangesFromParent = true
//        persistentContainer.loadPersistentStores { _, error in
//            if let error {
//                fatalError("Unable to load store with errorL \(error)")
//            }
//        }
//    }
//    
//    
//}
