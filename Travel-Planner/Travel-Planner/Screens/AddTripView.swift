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
    @State private var startDate: Date = Date()
    @State private var endDate: Date = Calendar.current.date(byAdding: .day, value: 1, to: Date()) ?? Date()
    
    @Environment(\.dismiss) private var dismiss
    
    
    var body: some View {
        Form {
            Section(header: Text("WHAT'S YOUR TITLE?")) {
                TextField("Title", text: $newTripTitle)
            }
        
            Section(header: Text("Date")) {
                DatePicker("Start Date", selection: $startDate)
                DatePicker("End Date", selection: $endDate, in: startDate...)
//                DatePicker("Start Date", selection: $startDate, displayedComponents: [.date])
//                DatePicker("End Date", selection: $endDate, in: startDate..., displayedComponents: [.date])
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
                    vm.addTrip(title: newTripTitle, startDate: startDate, endDate: endDate)
                    
                    dismiss()
                } label: {
                    Text("Save")
                        .foregroundColor(Color.brandPrimary)
                }
            }
        }
    }
}

