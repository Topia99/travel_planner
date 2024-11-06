import SwiftUI

final class TripViewModel: ObservableObject {
    
    @Published var trips: [Trip] = []
    
    init() {
        loadTrips()
    }

   
    func exportTrip(_ trip: Trip) {
        ItineraryExporter.copyToClipboard(trip: trip)
    }
    func deleteTrip(_ trip: Trip) {
            if let index = trips.firstIndex(where: { $0.id == trip.id }) {
                trips.remove(at: index)
                saveTrips()
            }
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
    
    func addTrip(title: String, startDate: Date, endDate: Date, destinations: [String]) {
        let dayPlans = generateDayPlans(from: startDate, to: endDate)
        let newTrip = Trip(title: title, startDate: startDate, endDate: endDate, destinations: destinations, dayPlans: dayPlans)
        trips.append(newTrip)
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
