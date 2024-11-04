//
//  AddActivityView.swift
//  Travel-Planner
//
//  Created by Jason Zeng on 10/29/24.
//

import SwiftUI

struct AddActivityView: View {
    
    @Environment(\.dismiss) var dismiss
    
    @State var title: String = ""
    @State var location: String = ""
    @State var selectedItemType: ItemType = .food
    @State var date: Date = Date()
    @State var url: String = ""
    @State var notes: String = ""
    
    @State var isSetTimeEnabled: Bool = false
    
    var onSave: (Item) -> Void
    
    
    var body: some View {
        Form {
            Section() {
                TextField("Title", text: $title)
                TextField("Location", text: $location)
            }
            
            Section() {
                ItemTypePickerView(selectedItemType: $selectedItemType)
            }
            
            Section() {
                Toggle("Set Time", isOn: $isSetTimeEnabled)
                
                if isSetTimeEnabled {
                    DatePicker(
                        "Start time",
                        selection: $date,
                        displayedComponents: [.date, .hourAndMinute]
                    )
                }
            }
            
            Section() {
                TextField("url", text: $url)
                
                TextField("Notes", text: $notes, axis: .vertical)
                
            }
            
            
            
        }
        .navigationTitle("Add Activity") // Add Activity or Edit Activity
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            // Cancel Button
            ToolbarItem(placement: .navigationBarLeading) {
                Button("Cancel") {
                    dismiss()
                }
                .foregroundStyle(.red)
            }
            
            // Add / Done Button
            ToolbarItem(placement: .navigationBarTrailing) {
                Button("Add") {
                    let newActivity = Item(title: title,
                                           location: location,
                                           date: isSetTimeEnabled ? date : nil,
                                           url: url,
                                           notes: notes,
                                           type: selectedItemType)
                    
                    onSave(newActivity)
                    dismiss()
                }
                .fontWeight(.bold)
                .foregroundStyle(.red)
            }
        }
    }
}



