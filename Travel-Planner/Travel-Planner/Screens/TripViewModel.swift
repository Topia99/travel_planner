//
//  ItineraryViewModel.swift
//  Travel-Planner
//
//  Created by Jason Zeng on 10/1/24.
//

import SwiftUI

final class TripViewModel: ObservableObject {
    @Published var trips: [Trip] = []
    @Published var nextImageIndex: Int = 0 // Keep track of the next image index

    init() {
        loadTrips()
        loadNextImageIndex()
    }

    func saveTrips() {
        DispatchQueue.global(qos: .background).async {
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

    func saveNextImageIndex() {
        UserDefaults.standard.set(nextImageIndex, forKey: "nextImageIndex")
    }

    func loadNextImageIndex() {
        nextImageIndex = UserDefaults.standard.integer(forKey: "nextImageIndex")
    }

    // Function to add a new trip to the list of trips
    func addTrip(title: String, startDate: Date, endDate: Date, destinations: [String]) {
        // Generate day plans for the trip based on the start and end dates
        let dayPlans = generateDayPlans(from: startDate, to: endDate)
        // Select an image for the trip from the default set of images
        // Use modulo to cycle through the default images without going out of bounds
        let imageName = defaultTripImages[nextImageIndex % defaultTripImages.count]
        // Create a new Trip instance with the provided details
        let newTrip = Trip(
            title: title,                   // Title of the trip
            startDate: startDate,           // Start date of the trip
            endDate: endDate,               // End date of the trip
            destinations: destinations,     // List of destinations for the trip
            dayPlans: dayPlans,             // Day-by-day plans for the trip
            imageName: imageName            // Image associated with the trip
        )
        // Append the newly created trip to the trips array
        trips.append(newTrip)
        // Increment the image index to ensure the next trip gets a different image
        nextImageIndex += 1
        // Save the updated list of trips to persistent storage
        saveTrips()
        // Save the updated image index to ensure it persists across app sessions
        saveNextImageIndex()
    }

    private func generateDayPlans(from startDate: Date, to endDate: Date) -> [DayPlan] {
        var dayPlans: [DayPlan] = []
        let numberOfDays = DateUtilities.numberOfDaysBetweenTwoDates(startDate, endDate)
        for day in 0...numberOfDays {
            if let dayDate = Calendar.current.date(byAdding: .day, value: day, to: startDate) {
                let dayPlan = DayPlan(dayNumber: day + 1, date: dayDate, items: [])
                dayPlans.append(dayPlan)
            }
        }
        return dayPlans
    }
}

