//
//  TripListView.swift
//  Travel-Planner
//
//  Created by Jason Zeng on 10/10/24.
//

import SwiftUI

struct TripListView: View {
    // Access the TripViewModel environment object
    @EnvironmentObject var tripViewModel: TripViewModel

    // State variables to control the display of views and modes
    @State private var showAddTrip: Bool = false      // Controls the display of AddTripView
    @State private var deleteMode: Bool = false       // Toggles delete mode

    var body: some View {
        NavigationStack {
            ScrollView {
                VStack {
                    // Iterate over the list of trips
                    ForEach($tripViewModel.trips) { $trip in
                        TripListItemView(
                            trip: $trip,
                            deleteMode: $deleteMode,
                            deleteAction: deleteTrip)
                    }
                }
                .padding()
                .frame(maxWidth: .infinity, maxHeight: .infinity)
            }
            .navigationTitle(deleteMode ? "Delete Trips" : "Trips")
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    if deleteMode {
                        // Show "Done" button to exit delete mode
                        Button("Done") {
                            deleteMode = false
                        }
                        .foregroundColor(.blue)
                    } else {
                        // Show a menu with "Add" and "Delete" options
                        Menu {
                            Button(action: {
                                showAddTrip.toggle()
                            }) {
                                Label("Add", systemImage: "plus")
                            }
                            Button(action: {
                                deleteMode.toggle()
                            }) {
                                Label("Delete", systemImage: "trash")
                            }
                        } label: {
                            Image(systemName: "plus")
                        }
                    }
                }
            }
            // Present AddTripView as a full-screen modal when showAddTrip is true
            .fullScreenCover(isPresented: $showAddTrip) {
                NavigationStack {
                    AddTripView()
                }
                .environmentObject(tripViewModel) // Pass the environment object to the AddTripView
            }
        }
    }

    // Function to handle trip deletion
    private func deleteTrip(_ trip: Trip) {
        // Find the index of the trip to be deleted
        if let index = tripViewModel.trips.firstIndex(where: { $0.id == trip.id }) {
            withAnimation {
                // Remove the trip from the list
                tripViewModel.trips.remove(at: index)
                // Save the updated trips list
                tripViewModel.saveTrips()
            }
        }
    }
}

// View representing a single item in the trip list
struct TripListItemView: View {
    @Binding var trip: Trip            // Binding to a Trip object
    @Binding var deleteMode: Bool      // Binding to delete mode state
    var deleteAction: (Trip) -> Void   // Closure to handle deletion

    var body: some View {
        ZStack(alignment: .topTrailing) {
            // NavigationLink to navigate to TripView when a trip card is tapped
            NavigationLink(destination: TripView(trip: $trip)) {
                // Display the trip card
                TripCardView(trip: trip)
            }
            .buttonStyle(PlainButtonStyle()) // Remove default button styling
            .disabled(deleteMode)            // Disable navigation when in delete mode

            // Show the delete button when in delete mode
            if deleteMode {
                Button(action: {
                    deleteAction(trip)
                }) {
                    Image(systemName: "minus.circle.fill")
                        .foregroundColor(.red)
                        .font(.title)
                }
                .padding([.top, .trailing], 10) // Position the delete button
            }
        }
    }
}

#Preview {
    TripListView()
        .environmentObject(TripViewModel())

}
