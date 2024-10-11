//
//  AddTripView.swift
//  Travel-Planner
//
//  Created by Jason Zeng on 10/10/24.
//

import SwiftUI

struct AddTripView: View {
    @EnvironmentObject var tripViewModel: TripViewModel
    
    @State private var newTripTitle: String = ""
    @State private var startDate: Date = Date()
    @State private var endDate: Date = Calendar.current.date(byAdding: .day, value: 1, to: Date()) ?? Date()
    @State private var newDestination: String = ""
    @State private var destinations: [String] = []
    
    @Environment(\.dismiss) private var dismiss
    
    
    var body: some View {
        Form {
            Section(header: Text("WHAT'S YOUR TITLE?")) {
                TextField("Title", text: $newTripTitle)
            }
            
            Section(header: Text("Date")) {
                DatePicker("Start Date", selection: $startDate, displayedComponents: [.date])
                DatePicker("End Date", selection: $endDate, in: startDate..., displayedComponents: [.date])
            }
            
            Section(header: Text("Destinations")) {
                HStack {
                    TextField("Add Destination", text: $newDestination)
                    Button(action: {
                        destinations.append(newDestination)
                        newDestination = ""
                    }) {
                        Image(systemName: "plus.circle.fill")
                            .foregroundColor(newDestination.isEmpty ? .gray : Color.brandPrimary)
                    }
                    .disabled(newDestination.isEmpty)
                }
                
                if !destinations.isEmpty {
                    ForEach(destinations, id: \.self) { destination in
                        Text(destination)
                    }
                    .onDelete { indices in
                        destinations.remove(atOffsets: indices)
                    }
                }
            }
        }
        .navigationTitle("Add Trip")
        .toolbar {
            ToolbarItem(placement: .topBarLeading) {
                Button {
                    dismiss()
                } label: {
                    Text("Cancel")
                        .foregroundColor(Color.brandPrimary)
                }
            }
            
            ToolbarItem(placement: .topBarTrailing) {
                Button {
                    tripViewModel.addTrip(title: newTripTitle, startDate: startDate, endDate: endDate, destinations: destinations)
                    tripViewModel.saveTrips() // Save Trips
                    dismiss()
                } label: {
                    Text("Save")
                        .foregroundColor(Color.brandPrimary)
                }
            }
        }
    }
}

#Preview {
        AddTripView()
}
