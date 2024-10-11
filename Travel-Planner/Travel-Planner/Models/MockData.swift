//
//  MockData.swift
//  Travel-Planner
//
//  Created by Jason Zeng on 10/8/24.
//

import Foundation



struct MockData {
    
    // Mock items with time as Date?
    static var mockItems: [Item] {
        return [
            Item(title: "Breakfast", time: createTime(hour: 8, minute: 0), description: "Morning breakfast at hotel", location: "Hotel Restaurant", type: .food),
            Item(title: "City Tour", time: createTime(hour: 10, minute: 0), description: "Explore the main sights of the city", location: "City Center", type: .activity),
            Item(title: "Lunch", time: createTime(hour: 12, minute: 0), description: "Lunch at a popular restaurant", location: "Downtown", type: .food),
            Item(title: "Museum Visit", time: createTime(hour: 14, minute: 0), description: "Visit the national museum", location: "National Museum", type: .activity),
            Item(title: "Dinner", time: createTime(hour: 19, minute: 0), description: "Dinner at an exclusive restaurant", location: "Fine Dining", type: .food)
        ]
    }
    
    // Mock day plans with the generated items
    static var mockDayPlans: [DayPlan] {
        let startDate = Calendar.current.date(byAdding: .day, value: 0, to: Date())!
        let endDate = Calendar.current.date(byAdding: .day, value: 4, to: Date())!
        let calendar = Calendar.current
        
        var dayPlans: [DayPlan] = []
        for i in 0...calendar.dateComponents([.day], from: startDate, to: endDate).day! {
            if let dayDate = calendar.date(byAdding: .day, value: i, to: startDate) {
                let dayPlan = DayPlan(
                    title: "Day \(i + 1)",
                    description: "Activities for Day \(i + 1)",
                    dayNumber: i + 1,
                    date: dayDate,
//                    items: MockData.mockItems
                    items: []
                )
                dayPlans.append(dayPlan)
            }
        }
        return dayPlans
    }
    
    // Mock trips with day plans
    static var mockTrips: [Trip] {
        let trip1 = Trip(
            title: "Trip to Paris",
            startDate: Date(),
            endDate: Calendar.current.date(byAdding: .day, value: 5, to: Date())!,
            destinations: ["Tokyo", "London", "New York", "Paris", "Berlin"],
            dayPlans: mockDayPlans
        )
        let trip2 = Trip(
            title: "Trip to Tokyo",
            startDate: Date(),
            endDate: Calendar.current.date(byAdding: .day, value: 7, to: Date())!,
            destinations: ["Tokyo", "London", "New York", "Paris", "Berlin"],
            dayPlans: mockDayPlans
        )
        
        return [trip1, trip2]
    }
    
    // Helper function to create a specific time as Date
    static func createTime(hour: Int, minute: Int) -> Date? {
        var components = DateComponents()
        components.hour = hour
        components.minute = minute
        return Calendar.current.date(from: components)
    }
}
