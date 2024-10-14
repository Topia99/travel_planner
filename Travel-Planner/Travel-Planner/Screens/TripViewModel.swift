//
//  ItineraryViewModel.swift
//  Travel-Planner
//
//  Created by Jason Zeng on 10/1/24.
//

import SwiftUI

final class TripViewModel: ObservableObject {
    
    @Published var trips: [Trip] = []
    
    // Injecting MockData for Testing Purpose only
    init(){
        loadTrips()
    }
    
    func saveTrips() {
        // Save tips object in userDefault
        
        DispatchQueue.global(qos: .background).async { // Perform the Save in background process
            if let encodedTrips = try? JSONEncoder().encode(self.trips) {
                UserDefaults.standard.set(encodedTrips, forKey: "trips")
            }
        }
    }
    
    func loadTrips() {
        if let savedData = UserDefaults.standard.data(forKey: "trips"),
           let decodedTrips = try? JSONDecoder().decode([Trip].self, from: savedData) {
            trips = decodedTrips
        } else {
            trips = []
        }
    }
    
    func addTrip(title: String, startDate: Date, endDate: Date, destinations: [String]) {
        let dayPlans = generateDayPlans(from: startDate, to: endDate)
        let newTrip = Trip(title: title, startDate: startDate, endDate: endDate, destinations: destinations, dayPlans: dayPlans)
        trips.append(newTrip)
    }

    
    private func generateDayPlans(from startDate: Date, to endDate: Date) -> [DayPlan] {
        var dayPlans: [DayPlan] = []
        
        let numberOfDays = DateUtilities.numberOfDaysBetweenTwoDates(startDate, endDate)
        
        for day in 0...numberOfDays {
            if let dayDate = Calendar.current.date(byAdding: .day, value: day, to: startDate){
                let dayPlan = DayPlan(dayNumber: day+1, date: dayDate, items: [])
                dayPlans.append(dayPlan)
            }
        }
        
        return dayPlans
    }
}
