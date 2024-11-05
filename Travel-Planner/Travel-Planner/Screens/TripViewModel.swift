//
//  ItineraryViewModel.swift
//  Travel-Planner
//
//  Created by Jason Zeng on 10/1/24.
//

import SwiftUI

final class TripViewModel: ObservableObject, Identifiable {
    
    @Published var trip: Trip
    @Published var dayPlans: [DayPlanViewModel]
    
    
    // Injecting MockData for Testing Purpose only
    init(trip: Trip){
        self.trip = trip
        self.dayPlans = trip.dayPlans.map { DayPlanViewModel(dayPlan: $0) }
    }
    
    func addDayPlan(date: Date, dayNumber: Int) {
        let newDayPlan = DayPlan(dayNumber: dayNumber, date: date, items: [])
        let newDayPlanViewModel = DayPlanViewModel(dayPlan: newDayPlan)
        dayPlans.append(newDayPlanViewModel)
        trip.dayPlans.append(newDayPlan)
    }
}
