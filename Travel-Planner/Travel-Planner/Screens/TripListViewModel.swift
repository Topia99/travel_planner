//
//  TripListViewModel.swift
//  Travel-Planner
//
//  Created by Jason Zeng on 11/3/24.
//

import SwiftUI

final class TripListViewModel: ObservableObject {
    @Published var trips: [TripViewModel] = []
    
    init() {
        loadTrips()
    }
    
    func saveTrips() {
        DispatchQueue.global(qos: .background).async {
            let tripsToSave = self.trips.map { $0.trip }
            if let encodedTrips = try? JSONEncoder().encode(tripsToSave) {
                UserDefaults.standard.set(encodedTrips, forKey: "trips")
            }
        }
    }
    
    func loadTrips() {
        if let savedData = UserDefaults.standard.data(forKey: "trips"),
           let decodedTrips = try? JSONDecoder().decode([Trip].self, from: savedData) {
            trips = decodedTrips.map { TripViewModel(trip: $0) }
        } else {
            trips = []
        }
    }
    
    func addTrip(title: String, startDate: Date, endDate: Date, destinations: [String]) {
        let dayPlans = generateDayPlans(from: startDate, to: endDate)
        let newTrip = Trip(title: title, startDate: startDate, endDate: endDate, destinations: destinations, dayPlans: dayPlans)
        let newTripViewModel = TripViewModel(trip: newTrip)
        trips.append(newTripViewModel)
    }
    
    private func generateDayPlans(from startDate: Date, to endDate: Date) -> [DayPlan] {
        var dayPlans: [DayPlan] = []
        let numberOfDays = DateUtils.numberOfDaysBetweenTwoDates(startDate, endDate)
        
        for day in 0...numberOfDays {
            if let dayDate = Calendar.current.date(byAdding: .day, value: day, to: startDate) {
                let dayPlan = DayPlan(dayNumber: day + 1, date: dayDate, items: [])
                dayPlans.append(dayPlan)
            }
        }
        
        return dayPlans
    }
}

