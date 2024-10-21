import SwiftUI

struct AddTripView: View {
    @Environment(\.presentationMode) var presentationMode
    @Binding var trips: [Trip]

    @State private var title: String = ""
    @State private var destination: String = ""
    @State private var startDate: Date?
    @State private var endDate: Date?

    // Known destinations
    let knownDestinations = [
        "San Diego",
        "San Jose",
        "San Francisco",
        "Los Angeles",
        "New York",
        "Chicago",
        "Miami",
        // Add more destinations as needed
    ]

    // Date formatter for displaying selected dates
    let dateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateStyle = .medium
        return formatter
    }()

    var body: some View {
        Form {
            // Trip Details Section
            Section(header: Text("Trip Details")) {
                TextField("Title", text: $title)

                AutoCompleteTextField(
                    text: $destination,
                    suggestions: knownDestinations,
                    onSelection: { selectedDestination in
                        self.destination = selectedDestination
                    }
                )
            }

            // Trip Dates Section
            Section(header: Text("Trip Dates")) {
                // Display selected dates
                VStack(alignment: .leading) {
                    Text("Start Date: \(startDate != nil ? dateFormatter.string(from: startDate!) : "Not selected")")
                    Text("End Date: \(endDate != nil ? dateFormatter.string(from: endDate!) : "Not selected")")
                }
                .padding(.bottom, 5)

                // Custom Calendar View
                CustomCalendarView(startDate: $startDate, endDate: $endDate)
                    .frame(height: 400) // Adjust height as needed
            }

            // Save Button Section
            Section {
                Button("Save") {
                    guard let start = startDate, let end = endDate else { return }

                    let newTrip = Trip(
                        title: title,
                        startDate: start,
                        endDate: end,
                        destinations: [destination],
                        itinerary: [],
                        participants: [],
                        expenses: []
                    )
                    trips.append(newTrip)
                    presentationMode.wrappedValue.dismiss()
                }
                .disabled(
                    title.isEmpty ||
                    destination.isEmpty ||
                    !knownDestinations.contains(destination) ||
                    startDate == nil ||
                    endDate == nil
                )
            }
        }
        .navigationTitle("Add Trip")
    }
}
