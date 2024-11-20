//
//  AddActivityView.swift
//  Travel-Planner
//
//  Created by Jason Zeng on 11/19/24.
//

import SwiftUI

struct AddActivityView: View {
    
    @ObservedObject var vm: ActivityViewModel
    @Environment(\.dismiss) var dismiss
    
    @State var titleTextField: String = ""
    @State var locationTextField: String = ""
    @State private var selectedActivityType: ActivityType = .activity
    @State var time: Date = Date()
    @State var notesTextField: String = ""
    
    @State var isSetTimeEnabled: Bool = false
    
    
    var body: some View {
        Form {
            Section() {
                TextField("Title", text: $titleTextField)
                TextField("Location", text: $locationTextField)
            }
            
            Section() {
                ActivityTypePickerView(selectedActivityType: $selectedActivityType)
            }
            
            Section() {
                Toggle("Set Time", isOn: $isSetTimeEnabled)
                
                if isSetTimeEnabled {
                    DatePicker(
                        "Start time",
                        selection: $time,
                        displayedComponents: [.date, .hourAndMinute]
                    )
                }
            }
            
            Section() {
                TextField("Notes", text: $notesTextField, axis: .vertical)
                
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
                    
                    vm.addActivity(title: titleTextField,
                                   location: locationTextField,
                                   time: isSetTimeEnabled ? time : nil,
                                   notes: notesTextField,
                                   activityType: selectedActivityType)
                    dismiss()
                }
                .fontWeight(.bold)
                .foregroundStyle(.red)
            }
        }
    }
}

struct ActivityTypePickerView: View {
    @Binding var selectedActivityType: ActivityType

    var body: some View {
        Picker("Type", selection: $selectedActivityType) {
            ForEach(ActivityType.allCases, id: \.self) { type in
                HStack {
                    Label {
                        Text(type.displayName)
                    } icon: {
                        Image(systemName: type.iconName)
                            .foregroundStyle(.white, type.iconColor)
                    }
                }
                .tag(type)
            }
        }
    }
}
