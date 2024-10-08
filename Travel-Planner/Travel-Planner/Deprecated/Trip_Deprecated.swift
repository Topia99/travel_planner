//
//  Itinerary.swift
//  Travel-Planner
//
//  Created by Jason Zeng on 9/26/24.
//

import Foundation
import MapKit
import SwiftUI
//
//// Represents the entire itinerary of a trip
//struct Trip: Identifiable {
//    var id = UUID()
//    var title: String
//    var startDate: Date
//    var endDate: Date
//    var dayPlans: [DayPlan] = []
//}
//
//// Represents a specific day's plan in the itinerary
//struct DayPlan: Identifiable {
//    var id = UUID()
//    var title: String = ""
//    var description: String = ""
//    var date: Date
//    var items: [TripItem] = []
//}
//
//enum ItemType: String {
//    case food
//    case accommodation
//    case activity
//}
//
//protocol TripItem {
//    var type: ItemType { get }
//    var title: String { get }
//    var time: String? { get }
//    var location: String? { get }
//    var description: String? { get }
//}
//
//struct FoodItem: TripItem {
//    let type: ItemType = .food
//    var title: String
//    var time: String?
//    var location: String?
//    var description: String?
//}
//
//struct AccommodationItem: TripItem {
//    let type: ItemType = .accommodation
//    var title: String
//    var time: String?
//    var location: String?
//    var description: String?
//    var checkInDate: Date?
//    var checkOutDate: Date?
//}
//
//struct ActivityItem: TripItem {
//    let type: ItemType = .activity
//    var title: String
//    var time: String?
//    var location: String?
//    var description: String?
//}
//
//
//
//let mockData = Trip(
//    title: "European Adventure",
//    startDate: Date(),
//    endDate: Date().addingTimeInterval(86400 * 5),
//    dayPlans: [
//        DayPlan(
//            title: "Day 1 - Exploring Paris",
//            description: "Visit major attractions in Paris.",
//            date: Date(),
//            items: [
//                FoodItem(
//                    title: "Cafe de Flore",
//                    time: "08:00 AM",
//                    location: "172 Boulevard Saint-Germain, Paris",
//                    description: "Enjoy a traditional French breakfast."
//                ),
//                AccommodationItem(
//                    title: "Hotel Le Meurice",
//                    time: "03:00 PM",
//                    location: "228 Rue de Rivoli, Paris",
//                    description: "Check-in at the luxurious Hotel Le Meurice.",
//                    checkInDate: Date(),
//                    checkOutDate: Date().addingTimeInterval(86400 * 2)
//                ),
//                ActivityItem(
//                    title: "Eiffel Tower",
//                    time: "05:00 PM",
//                    location: "Champ de Mars, Paris",
//                    description: "Visit the iconic Eiffel Tower and enjoy the view from the top."
//                )
//            ]
//        ),
//        DayPlan(
//            title: "Day 2 - A Day in Rome",
//            description: "Exploring the historical landmarks of Rome.",
//            date: Date().addingTimeInterval(86400),
//            items: [
//                FoodItem(
//                    title: "Trattoria Da Enzo",
//                    time: "12:00 PM",
//                    location: "Via dei Vascellari 29, Rome",
//                    description: "Enjoy authentic Roman pasta dishes."
//                ),
//                AccommodationItem(
//                    title: "Hotel Eden",
//                    time: "02:00 PM",
//                    location: "Via Ludovisi 49, Rome",
//                    description: "Check-in at the luxurious Hotel Eden.",
//                    checkInDate: Date().addingTimeInterval(86400),
//                    checkOutDate: Date().addingTimeInterval(86400 * 2)
//                ),
//                ActivityItem(
//                    title: "Colosseum Tour",
//                    time: "03:30 PM",
//                    location: "Piazza del Colosseo, Rome",
//                    description: "Guided tour of the historic Colosseum."
//                )
//            ]
//        ),
//        DayPlan(
//            title: "Day 3 - Barcelona Adventure",
//            description: "Enjoying the sights and sounds of Barcelona.",
//            date: Date().addingTimeInterval(86400 * 2),
//            items: [
//                FoodItem(
//                    title: "El Nacional",
//                    time: "01:00 PM",
//                    location: "Passeig de Gràcia, 24, Barcelona",
//                    description: "Experience Spanish tapas in a historic setting."
//                ),
//                AccommodationItem(
//                    title: "W Barcelona",
//                    time: "04:00 PM",
//                    location: "Plaça de la Rosa dels Vents, 1, Barcelona",
//                    description: "Check-in at the beachside W Barcelona.",
//                    checkInDate: Date().addingTimeInterval(86400 * 2),
//                    checkOutDate: Date().addingTimeInterval(86400 * 3)
//                ),
//                ActivityItem(
//                    title: "Sagrada Familia",
//                    time: "06:00 PM",
//                    location: "Carrer de Mallorca, 401, Barcelona",
//                    description: "Visit Gaudi’s architectural masterpiece, Sagrada Familia."
//                )
//            ]
//        )
//    ]
//)
