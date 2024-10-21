//
//  AddTripView.swift
//  Travel-Planner
//
//  Created by Jason Zeng on 10/10/24.


import SwiftUI
import Foundation

let defaultTripImages = ["image1", "image2", "image3", "image4", "image5"]

struct AddTripView: View {
    @EnvironmentObject var tripViewModel: TripViewModel
    
    @State private var newTripTitle: String = ""
    @State private var startDate: Date? = nil
    @State private var endDate: Date? = nil
    @State private var newDestination: String = ""
    @State private var destinations: [String] = []
    
    @State private var isCalendarVisible = false
    
    @Environment(\.dismiss) private var dismiss
    
    // Computed property to check if the form is valid
    private var isFormValid: Bool {
        !newTripTitle.isEmpty && startDate != nil && endDate != nil && !destinations.isEmpty
    }
    
    var body: some View {
        NavigationStack{
            ZStack {
                Form {
                    // Title Section
                    TripTitleSection(newTripTitle: $newTripTitle)
                    
                    // Date Duration Section
                    TripDateSection(
                        startDate: $startDate,
                        endDate: $endDate,
                        isCalendarVisible: $isCalendarVisible)
                    
                    // Destinations Section
                    TripDestinationsSection(
                        newDestination: $newDestination,
                        destinations: $destinations)
                }
                .scrollContentBackground(.hidden) // Ensures Form background is transparent
                .background(Color.white) // Apply background to the entire view
                .navigationTitle("Add Trip")
                .toolbar {
                    // Cancel Button
                    ToolbarItem(placement: .navigationBarLeading) {
                        Button {
                            dismiss()
                        } label: {
                            Text("Cancel")
                                .foregroundColor(Color.brandPrimary)
                        }
                    }
                    
                    // Save Button
                    ToolbarItem(placement: .navigationBarTrailing) {
                        Button {
                            // Save action
                            tripViewModel.addTrip(title: newTripTitle, startDate: startDate!, endDate: endDate!, destinations: destinations)
                            tripViewModel.saveTrips()
                            dismiss()
                        } label: {
                            Text("Save")
                                .foregroundColor(isFormValid ? Color.brandPrimary : .gray)
                        }
                        .disabled(!isFormValid)
                    }
                }
            }
            .foregroundColor(Color("darkGreen"))
        }
    }
}

// Section for entering the trip title
struct TripTitleSection: View {
    @Binding var newTripTitle: String // Binding variable for the trip title input

    var body: some View {
        Section(header: Text("WHAT'S YOUR TITLE?")
            .foregroundColor(Color("darkGreen"))) {
                TextField("Title", text: $newTripTitle)
                    .padding()
                    .background(Color("softGreen"))
                    .cornerRadius(10)
                    .overlay(
                        RoundedRectangle(cornerRadius: 10)
                            .stroke(Color("darkGreen"), lineWidth: 1)
                    )
            }
    }
}

// Section for adding destinations
struct TripDestinationsSection: View {
    @Binding var newDestination: String // Binding for the new destination input
    @Binding var destinations: [String] // Binding for the list of destinations

    var body: some View {
        Section(header: Text("Destinations")
            .foregroundColor(Color("darkGreen"))) {
                HStack {
                    TextField("Add Destination", text: $newDestination)
                        .padding()
                        .background(Color("softGreen"))
                        .cornerRadius(10)
                        .overlay(
                            RoundedRectangle(cornerRadius: 10)
                                .stroke(Color("darkGreen"), lineWidth: 1)
                        )
                    
                    // Button to add the destination to the list
                    Button(action: {
                        if !newDestination.isEmpty {
                            destinations.append(newDestination)
                            newDestination = ""
                        }
                    }) {
                        // Image for the add button
                        Image(systemName: "plus.circle.fill")
                            .foregroundColor(newDestination.isEmpty ? .gray : Color.brandPrimary)
                    }
                    .disabled(newDestination.isEmpty) // Disable the button if input is empty
                }
                
                // Display the list of destinations added
                if !destinations.isEmpty {
                    ForEach(destinations, id: \.self) { destination in
                        Text(destination)
                    }
                    // Enable deleting destinations from the list
                    .onDelete { indices in
                        destinations.remove(atOffsets: indices) // Remove destination at index
                    }
                }
            }
    }
}

#Preview{
    AddTripView()
}


