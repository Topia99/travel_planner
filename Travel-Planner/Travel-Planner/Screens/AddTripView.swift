//
//  AddTripView.swift
//  Travel-Planner
//
//  Created by Jason Zeng on 10/10/24.
//

import SwiftUI

struct AddTripView: View {
    @StateObject var vm: TripViewModel
    
    @State private var newTripTitle: String = ""
    @State private var startDate: Date?
    @State private var endDate: Date?
    @State private var isCalendarVisible: Bool = false
    
    @Environment(\.dismiss) private var dismiss
    
    var body: some View {
        ZStack {
            // Gradient background
            LinearGradient(
                gradient: Gradient(colors: [Color.gray.opacity(0.8),
                                            Color.blue.opacity(0.7),
                                            Color.green.opacity(0.7)]),
                startPoint: .top,
                endPoint: .bottom
            )
            .edgesIgnoringSafeArea(.all)
            
            Form {
                Section(header: Text("WHAT'S YOUR TITLE?")) {
                    TextField("Title", text: $newTripTitle)
                }
                
                DateRangeSelection(
                    startDate: $startDate,
                    endDate: $endDate,
                    isCalendarVisible: $isCalendarVisible,
                    calendar: Calendar.current
                )
            }
            .scrollContentBackground(.hidden) // Ensures the Form content background is hidden
            .background(Color.clear) // Makes the background transparent
        }
        .navigationTitle("Add Trip")
        .toolbar {
            ToolbarItem(placement: .topBarLeading) {
                Button {
                    dismiss()
                } label: {
                    Text("Cancel")
                        .foregroundColor(Color.red)
                }
            }
            
            // Save Button
            ToolbarItem(placement: .navigationBarTrailing) {
                Button("Save") {
                    if let startDate = startDate, let endDate = endDate, !newTripTitle.isEmpty {
                        vm.addTrip(title: newTripTitle, startDate: startDate, endDate: endDate)
                        dismiss()
                    } else {
                        print("Please enter a title and select start and end dates.")
                    }
                }
                .disabled(startDate == nil || endDate == nil || newTripTitle.isEmpty)
            }
        }
    }
}

#Preview {
    AddTripView(vm: TripViewModel())
}
