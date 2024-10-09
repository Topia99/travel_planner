//
//  AddTripView.swift
//  TravelPlanner
//
//  Created by siye yang on 9/22/24.
//

import SwiftUI

struct AddTripView: View {
    
    @StateObject var viewModel = ItineraryViewModel()
    @State private var duration: Int = 0
    @State private var isCalendarVisible: Bool = false
    
    // Variables for multiple destination input
    @State private var newDestination: String = ""
    @State private var showErrorMessage: Bool = false

    let maxDuration: Int = 10 // Maximum allowed duration in days
    
    var body: some View {
        NavigationView {
            ZStack {
                
                Form {
                    // Trip Details Section
                    Section(header: Text("WHAT'S YOUR TITLE?")
                        .foregroundColor(Color("darkGreen"))) {
                            TextField("Title", text: $viewModel.itinerary.title)
                                .padding()
                                .background(Color("softGreen")) // Softer green background for input
                                .cornerRadius(10)
                                .overlay(
                                    RoundedRectangle(cornerRadius: 10)
                                        .stroke(Color("darkGreen"), lineWidth: 1) // Add soft border
                                )
                        }
                    
                    // Date Duration Section
                    Section(header: Text("What's your date duration")
                        .foregroundColor(Color("darkGreen"))) {
                        Button(action: {
                            // Toggle the visibility of the custom calendar view
                            withAnimation {
                                isCalendarVisible.toggle()
                            }
                        }) {
                            HStack {
                                Text("    Date")
                                Spacer()
                                if let startDate = viewModel.itinerary.startDate, let endDate = viewModel.itinerary.endDate {
                                    Text("\(DateUtilities.formattedDateRange(start: startDate, end: endDate))   ")
                                        .foregroundColor(Color("darkGreen"))
                                } else {
                                    Text("Select Date Range    ")
                                        .foregroundColor(Color("darkGreen"))
                                }
                            }
                            
                            .frame(width: 320, height: 60, alignment: Alignment.center)
                            .background(Color("softGreen"))
                            .cornerRadius(10)
                            .overlay(
                                RoundedRectangle(cornerRadius: 10)
                                    .stroke(Color("darkGreen"), lineWidth: 1)
                            )
                        }
                        .foregroundColor(Color("darkGreen"))
                        
                        // Conditionally show the calendar
                        if isCalendarVisible {
                            CustomCalendarView(startDate: $viewModel.itinerary.startDate, endDate: $viewModel.itinerary.endDate)
                        }
                    }
                    
                    // Destination Input Section with Multiple Destinations Support
                    Section(header: Text("What's your destination?")
                        .foregroundColor(Color("darkGreen"))) {
                        TextField("Enter a destination", text: $newDestination)
                            .padding()
                            .background(Color("softGreen"))
                            .cornerRadius(10)
                            .overlay(
                                RoundedRectangle(cornerRadius: 10)
                                    .stroke(Color("darkGreen"), lineWidth: 1)
                            )


                    
                        // Show error message if the input is empty
                        if showErrorMessage {
                            Text("Destination cannot be empty.")
                                .foregroundColor(.red)
                                .font(.caption)
                        }
                        
                        // Button to add destination
                        Button(action: {
                            addDestination()
                        }) {
                            Text("Save Destination")
                                .padding()
                                .frame(maxWidth: .infinity)
                                .background(Color("darkGreen"))
                                .foregroundColor(.white)
                                .cornerRadius(10)
                        }
                        
                        // Display saved destinations
                        Section(header: Text("Saved Destinations")
                            .foregroundColor(Color("darkGreen"))) {
                            List(viewModel.itinerary.destination.indices, id: \.self) { index in
                                HStack {
                                    Text("\(getLabel(for: index))")
                                    Spacer()
                                    Text(viewModel.itinerary.destination[index])
                                }
                                .padding()
                                .background(Color("softGreen"))
                                .cornerRadius(10)
                            }
                        }
                    }
                }
                .scrollContentBackground(.hidden) // Hide default form background
                .background(Color.white) // Custom background for the form
            }
            .navigationTitle("Add Trip")
            .navigationBarTitleDisplayMode(.inline)
            .foregroundColor(Color("darkGreen"))
        }
    }
    
    // Function to save destination, with validation for empty input
    func addDestination() {
        if newDestination.trimmingCharacters(in: .whitespaces).isEmpty {
            showErrorMessage = true
        } else {
            viewModel.itinerary.destination.append(newDestination)
            newDestination = "" // Clear the input field after saving
            showErrorMessage = false
        }
    }
    
    // Get a label for the destination based on its index
    func getLabel(for index: Int) -> String {
        switch index {
        case 0:
            return "1st Destination"
        case 1:
            return "2nd Destination"
        case 2:
            return "3rd Destination"
        default:
            return "\(index + 1)th Destination"
        }
    }
}

#Preview {
    AddTripView()
}

