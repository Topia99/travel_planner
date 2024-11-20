//
//  TripViewModel.swift
//  Travel-Planner
//
//  Created by Jason Zeng on 11/17/24.
//

import Foundation
import CoreData

class TripViewModel: ObservableObject {
    let manager = CoreDataManager.instance
    @Published var trips: [TripEntity] = []
    
    init() {
        getTrips()
    }
    
    
    func getTrips() {
        let request = NSFetchRequest<TripEntity>(entityName: "TripEntity")
        
        do {
            trips = try manager.context.fetch(request)
        } catch let error {
            print("Error fetching trips. \(error.localizedDescription)")
        }
    }
    
    func addTrip(title: String, startDate: Date, endDate: Date) {
        let newTrip = TripEntity(context: manager.context)
        newTrip.title = title
        newTrip.startDate = startDate
        newTrip.endDate = endDate
        
        // Add Empty DayPlan to new trip
        addEmptyDayPlanToNewTrip(newTrip: newTrip, startDate: startDate, endDate: endDate)
        
        save()
    }
    
    func deleteTrip(trip: TripEntity) {
        manager.context.delete(trip)
        save()
    }
    
    func addEmptyDayPlanToNewTrip(newTrip: TripEntity, startDate: Date, endDate: Date) {
        
        let numberOfDays = DateUtils.numberOfDaysBetweenTwoDates(startDate, endDate)
        
        for day in 0...numberOfDays {
            if let dayDate = Calendar.current.date(byAdding: .day, value: day, to: startDate){
                let newDayPlan = DayPlanEntity(context: manager.context)
                newDayPlan.dayNumber = Int16(day+1)
                newDayPlan.date = dayDate
                newDayPlan.trip = newTrip
                
                self.manager.save()
            }
        }
    }
    
    func save() {
        trips.removeAll()
        
        DispatchQueue.main.async {
            self.manager.save()
            self.getTrips()
        }
    }
}
