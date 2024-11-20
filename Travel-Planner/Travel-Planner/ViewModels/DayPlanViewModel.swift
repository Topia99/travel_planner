//
//  DayPlanViewModel.swift
//  Travel-Planner
//
//  Created by Jason Zeng on 11/18/24.
//

import Foundation
import CoreData

class DayPlanViewModel: ObservableObject {
    let manager = CoreDataManager.instance
    let trip: TripEntity
    @Published var dayPlans: [DayPlanEntity] = []
    
    init(trip: TripEntity) {
        self.trip = trip
        getDayPlans()
    }
    
    func getDayPlans() {
        let request = NSFetchRequest<DayPlanEntity>(entityName: "DayPlanEntity")
        let filter = NSPredicate(format: "trip = %@", trip)
        let sort = NSSortDescriptor(keyPath: \DayPlanEntity.dayNumber, ascending: true)
        
        request.predicate = filter
        request.sortDescriptors = [sort]
        
        do {
            dayPlans = try manager.context.fetch(request)
        } catch let error {
            print("Error fetching day plans: \(error.localizedDescription)")
        }
    }
    
    func addDayPlan(title: String, dayNumber: Int, date: Date, notes: String) {
        let newDayPlan = DayPlanEntity(context: manager.context)
        newDayPlan.title = title
        newDayPlan.dayNumber = Int16(dayNumber)
        newDayPlan.date = date
        newDayPlan.notes = notes
        
        
        newDayPlan.trip = self.trip
        
        save()
    }
    
    
    func save() {
        func save() {
            do {
                try manager.context.save()
                getDayPlans()
            } catch {
                print("Error saving context: \(error.localizedDescription)")
            }
        }

    }
}

