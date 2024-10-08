//
//  ItineraryViewModel.swift
//  Travel-Planner
//
//  Created by Jason Zeng on 10/1/24.
//

import SwiftUI

final class ItineraryViewModel: ObservableObject {
    
    @Published var dayPlans: [DayPlan] = []
    @State var selectedDates: Date? = nil
    
    init() {
           // Set the default selected date to the first day's date in the itinerary
        _selectedDates = State(initialValue: dayPlans.first?.date)
        
        dayPlans = generateMockDayPlans()
    }
    
    func fetchDayPlanData() {
        dayPlans.append(contentsOf: generateMockDayPlans())
    }
    
    
    func generateMockDayPlans() -> [DayPlan] {
        let mockItems: [Item] = [
            Item(title: "Breakfast", time: "08:00 AM", description: "Morning breakfast at hotel", location: "Hotel Restaurant", type: .food),
            Item(title: "City Tour", time: "10:00 AM", description: "Explore the main sights of the city", location: "City Center", type: .activity),
            Item(title: "Lunch", time: "12:00 PM", description: "Lunch at a popular restaurant", location: "Downtown", type: .food),
            Item(title: "Museum Visit", time: "2:00 PM", description: "Visit the national museum", location: "National Museum", type: .activity),
            Item(title: "Dinner", time: "7:00 PM", description: "Dinner at an exclusive restaurant", location: "Fine Dining", type: .food)
        ]
        
        return [
            DayPlan(title: "Day 1: Arrival and City Tour", description: "Explore the city and enjoy the local food.", dayNumber: 1, date: Date(), items: []),
            DayPlan(title: "Day 2: Cultural Exploration", description: "Visit famous museums and historic places.", dayNumber: 2, date: Calendar.current.date(byAdding: .day, value: 1, to: Date())!, items: mockItems),
            DayPlan(title: "Day 3: Leisure Day", description: "Relax and enjoy the amenities of the resort.", dayNumber: 3, date: Calendar.current.date(byAdding: .day, value: 2, to: Date())!, items: mockItems),
            DayPlan(title: "Day 4: Adventure", description: "Engage in outdoor activities and adventure sports.", dayNumber: 4, date: Calendar.current.date(byAdding: .day, value: 3, to: Date())!, items: mockItems),
            DayPlan(title: "Day 5: Departure", description: "Wrap up your trip and head home.", dayNumber: 5, date: Calendar.current.date(byAdding: .day, value: 4, to: Date())!, items: mockItems)
        ]
    }
}
