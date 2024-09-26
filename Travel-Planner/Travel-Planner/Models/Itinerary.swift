//
//  Itinerary.swift
//  Travel-Planner
//
//  Created by Jason Zeng on 9/26/24.
//

import Foundation

// Represents the entire itinerary for a trip
struct Itinerary {
    var title: String
    var startDate: Date
    var endDate: Date
    var dayPlans: [DayPlan]
}

// Represents a specific day's plan in the itinerary
struct DayPlan: Identifiable {
    let id = UUID()
    var date: Date
    var activities: [Activity]
}

// Represents a specific activity within a day's plan
struct Activity: Identifiable {
    let id = UUID()
    var time: Date
    var description: String
    var location: String
}

// Example of mock data
struct MockData {
    static let sampleItinerary = Itinerary(
        title: "Vacation to Paris",
        startDate: Date(),
        endDate: Calendar.current.date(byAdding: .day, value: 7, to: Date())!,
        dayPlans: [
            DayPlan(date: Date(), activities: [
                Activity(time: Date(), description: "Visit the Eiffel Tower", location: "Eiffel Tower"),
                Activity(time: Date(), description: "Lunch at Le Jules Verne", location: "Le Jules Verne"),
                Activity(time: Date(), description: "Explore the Louvre Museum", location: "Louvre Museum")
            ]),
            DayPlan(date: Calendar.current.date(byAdding: .day, value: 1, to: Date())!, activities: [
                Activity(time: Date(), description: "Day trip to Versailles", location: "Palace of Versailles"),
                Activity(time: Date(), description: "Dinner at Le Meurice", location: "Le Meurice")
            ]),
            DayPlan(date: Calendar.current.date(byAdding: .day, value: 2, to: Date())!, activities: [
                Activity(time: Date(), description: "Morning walk in Montmartre", location: "Montmartre"),
                Activity(time: Date(), description: "Visit Sacré-Cœur", location: "Sacré-Cœur"),
                Activity(time: Date(), description: "Lunch at Le Relais Gascon", location: "Le Relais Gascon")
            ]),
            DayPlan(date: Calendar.current.date(byAdding: .day, value: 3, to: Date())!, activities: [
                Activity(time: Date(), description: "Seine River Cruise", location: "Seine River"),
                Activity(time: Date(), description: "Picnic at Champ de Mars", location: "Champ de Mars"),
                Activity(time: Date(), description: "Visit Musée d'Orsay", location: "Musée d'Orsay")
            ]),
            DayPlan(date: Calendar.current.date(byAdding: .day, value: 4, to: Date())!, activities: [
                Activity(time: Date(), description: "Explore the Catacombs", location: "Catacombs of Paris"),
                Activity(time: Date(), description: "Lunch at La Coupole", location: "La Coupole"),
                Activity(time: Date(), description: "Shopping on Champs-Élysées", location: "Champs-Élysées")
            ]),
            DayPlan(date: Calendar.current.date(byAdding: .day, value: 5, to: Date())!, activities: [
                Activity(time: Date(), description: "Day trip to Giverny", location: "Giverny"),
                Activity(time: Date(), description: "Explore Monet's Garden", location: "Monet's Garden"),
                Activity(time: Date(), description: "Return to Paris", location: "Paris")
            ]),
            DayPlan(date: Calendar.current.date(byAdding: .day, value: 6, to: Date())!, activities: [
                Activity(time: Date(), description: "Visit the Palace of Fontainebleau", location: "Fontainebleau"),
                Activity(time: Date(), description: "Lunch in Fontainebleau", location: "Fontainebleau"),
                Activity(time: Date(), description: "Return to Paris", location: "Paris")
            ])
        ]
    )
}


